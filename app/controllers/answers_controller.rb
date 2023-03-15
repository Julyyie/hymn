class AnswersController < ApplicationController
  skip_before_action :authenticate_user!, only: :login

  def index
    @song = Song.find(params[:song_id])
    @answers = policy_scope(Answer) # Confirmer le scope avec un TA
    @answers = Answer.where(song: @song).order(time: :asc)
    @game = @song.game

    if params[:status] == "ongoing"
      @song.game.ongoing!
      GameChannel.broadcast_to(
        @song.game,
        { event: "game_started", url: new_song_answer_path(@song.game.songs.first) }
      )
    end
    @next_song = @game.songs.order(:id).where("id > ?", @song.id).first

    @prev_song = @game.songs.order(:id).where("id < ?", @song.id).last
    if @game.user == current_user
      AnswersIndexChannel.broadcast_to(
        @prev_song,
       { event: "next_song", url: new_song_answer_path(@song), timestamp: Time.now }
      )
    end
  end

  def new
    @answer = Answer.new
    authorize @answer
    @song = Song.find(params[:song_id])
  end

  def create
    @response_time = Time.now - Time.at(params[:timestamp].to_i / 1000)
    @song = Song.find(params[:song_id])
    user = current_user
    game = @song.game
    users_game = UsersGame.find_by(user: user, game: game)
    @answer = Answer.new
    @answer.users_game = users_game
    @answer.song = @song
    @answer.response_time = @response_time
    authorize @answer

    if @answer.save
      AnswersIndexChannel.broadcast_to(
        @song,
        event: "player_buzzed",
        answer: render_to_string(partial: "answers", locals: { answer: @answer, song: @song }),
        answer_modal: render_to_string(partial: "answer_modal", locals: { answer: @answer, song: @song }),
      )
      redirect_to song_answers_path(@song)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def accept
    @answer = Answer.find(params[:answer_id])
    authorize @answer
    @answer.update(result_status: 'accepted')
    users_game = @answer.users_game
    users_game.score += 10

    if @answer.response_time < 1
      users_game.score += 20
    elsif @answer.response_time < 3
      users_game.score += 10
    elsif @answer.response_time < 5
      users_game.score += 5
    end

    users_game.save
    respond_to do |format|
      format.html { redirect_to song_answers_path }
      format.text { head :ok }
    end
    @song = Song.find(params[:song_id])
    @answers = Answer.where(song: @song).order(time: :asc)
    AnswersIndexChannel.broadcast_to(
      @song,
      event: "answer_updated",
      users_game_id: users_game.id,
      answers: render_to_string(partial: "answers_list", locals: { answers: @answers, song: @song }, formats: [:html])
    )
  end

  def refuse
    @answer = Answer.find(params[:answer_id])
    authorize @answer
    @answer.update(result_status: 'refused')
    users_game = @answer.users_game
    users_game.score -= 5
    users_game.save
    respond_to do |format|
      format.html { redirect_to song_answers_path }
      format.text { head :ok }
    end
    @song = Song.find(params[:song_id])
    @answers = Answer.where(song: @song).order(time: :asc)
    AnswersIndexChannel.broadcast_to(
      @song,
      event: "answer_updated",
      users_game_id: users_game.id,
      answers: render_to_string(partial: "answers_list", locals: { answers: @answers, song: @song }, formats: [:html])
    )
  end

  private

  def anwser_params
    params.require(:answer).permit(:time, :user_game, :song_id)
  end
end
