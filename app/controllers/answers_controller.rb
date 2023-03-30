class AnswersController < ApplicationController
  skip_before_action :authenticate_user!, only: :login

  def index
    find_song
    @answers = policy_scope(Answer)

    # Redirecting all participants to the first song: answers#new
    if params[:status] == "ongoing"
      @song.game.ongoing!
      GameChannel.broadcast_to(
        @song.game,
        { event: "game_started", url: new_song_answer_path(@song.game.songs.first) }
      )
    end

    # Display all answers
    @answers = Answer.where(song: @song).order(response_time: :asc)

    # Find next song id
    @game = @song.game
    @next_song = @game.songs.order(:id).where("id > ?", @song.id).first
    @prev_song = @game.songs.order(:id).where("id < ?", @song.id).last

    # Redirecting all participants to the next song: answers#new
    if @game.user == current_user
      AnswersIndexChannel.broadcast_to(
        @prev_song,
        event: "next_song",
        url: new_song_answer_path(@song)
      )
    end
  end

  def new
    @answer = Answer.new
    authorize @answer
    find_song
  end

  def create
    find_song
    user = current_user
    game = @song.game
    users_game = UsersGame.find_by(user: user, game: game)
    @answer = Answer.new
    @answer.users_game = users_game
    @answer.song = @song
    @answer.response_time = Time.now - Time.at(params[:timestamp].to_i / 1000)
    authorize @answer

    # Inserting participants answers to the answers's index
    if @answer.save
      AnswersIndexChannel.broadcast_to(
        @song,
        event: "player_buzzed",
        answer: render_to_string(partial: "answers", locals: { answer: @answer, song: @song }),
        answer_modal: render_to_string(partial: "answer_modal", locals: { answer: @answer, song: @song })
      )
      redirect_to song_answers_path(@song)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def accept
    find_answer
    authorize @answer
    @answer.update(result_status: 'accepted')
    users_game = @answer.users_game
    increase_score(users_game, @answer)
    users_game.save
    clear_headers
    find_song
    @answers = Answer.where(song: @song).order(time: :asc)
    # Inserting participants answers to the answers's index with accepted css class
    broadcast_updated_answers(@song, users_game, @answers)
  end

  def refuse
    find_answer
    authorize @answer
    @answer.update(result_status: 'refused')
    users_game = @answer.users_game
    decrease_score(users_game)
    users_game.save
    clear_headers
    find_song
    @answers = Answer.where(song: @song).order(time: :asc)
    # Insert participants answers to the answers's index with refused css class
    broadcast_updated_answers(@song, users_game, @answers)
  end

  def find_song
    @song = Song.find(params[:song_id])
  end

  def find_answer
    @answer = Answer.find(params[:answer_id])
  end

  def increase_score(users_game, answer)
    users_game.score += 10
    if answer.response_time < 1
      users_game.score += 20
    elsif answer.response_time < 3
      users_game.score += 10
    elsif answer.response_time < 5
      users_game.score += 5
    end
  end

  def decrease_score(users_game)
    users_game.score -= 5
  end

  def broadcast_updated_answers(song, users_game, answers)
    AnswersIndexChannel.broadcast_to(
      song,
      event: "answer_updated",
      users_game_id: users_game.id,
      answers: render_to_string(partial: "answers_list", locals: { answers:, song: }, formats: [:html])
    )
  end

  def clear_headers
    respond_to do |format|
      format.html { redirect_to song_answers_path }
      format.text { head :ok }
    end
  end

  private

  def anwser_params
    params.require(:answer).permit(:time, :user_game, :song_id)
  end
end
