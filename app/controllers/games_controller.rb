class GamesController < ApplicationController
  def new
    @game = Game.new
    @step = "new_playlist" # For rendering first view of games#new

    if params[:playlist].present?
      @step = "namegame" # For rendering second view of games#new
    end
    authorize @game
  end

  def create
    @game = Game.new(params_game)
    @game.user = current_user # Assigning current_user as game's master
    authorize @game

    if @game.save
      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
    # Save all songs associated to the chosen playlist
    find_songs(@game)
  end

  def show
    @game = Game.find(params[:id])
    authorize @game
    # Creating all participants
    unless current_user == @game.user || UsersGame.find_by(user: current_user, game: @game).present?
      users_game = UsersGame.new # users_game = "participant": user in the context of a game
      users_game.game = @game
      users_game.user = current_user
      if users_game.save!
        # Insert player's card in the waiting room
        GameChannel.broadcast_to(
          @game,
          { event: "player_joined", html: render_to_string(partial: "player", locals: { user_game: users_game }) }
        )
      end
    end

    if params[:status] == "finished"
      @game.finished!
      @song = @game.songs.find(params[:song_id])
      AnswersIndexChannel.broadcast_to(
        @song,
        { event: "game_finished", url: game_path(@game) }
      )
    end
  end

  def list
    @playlists = RSpotify::Playlist.search("#{params[:query]}").first(8)
    render json: { html: render_to_string(partial: "list", locals: { playlists: @playlists }) }
    skip_authorization
  end

  def find_songs(game)
    playlist_uri = game.spotify_playlist_id
    # Decomposing the URI
    spotify_playlist_id = playlist_uri[17..-1]
    # Spotify API call using RSpotify gem - find associated tracks
    spotify_playlist = RSpotify::Playlist.find("playlist", "#{spotify_playlist_id}")
    tracks = spotify_playlist.tracks
    # Saving associated songs
    tracks.each do |track|
      song = Song.new
      song.game = game
      song.title = track.name
      song.album = track.album.name
      song.artist = track.artists.first.name
      song.spotify_track_id = track.uri
      song.save!
    end
  end

  private

  def params_game
    params.require(:game).permit(:name, :spotify_playlist_id)
  end
end
