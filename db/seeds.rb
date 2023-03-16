# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"

puts "cleaning database..."
User.destroy_all

User.destroy_all

puts "Start creating new users..."

user1 = User.create!(nickname: "Julyyie 🧚‍♂️", email: "delaruejuulie@gmail.com", password: "123456")
file = URI.open("https://res.cloudinary.com/dwvaux61b/image/upload/v1678966551/5C10FC66-6267-4762-AB1C-870DA1D25F0D_kbfapt.jpg")
user1.photo.attach(io: file, filename: "julie_avatar.png", content_type: "image/png")


user2 = User.create!(nickname: "Laure 🎤", email: "laurematoussowsky@gmail.com", password: "123456")
file = URI.open("https://res.cloudinary.com/dwvaux61b/image/upload/v1678966466/PP_Slack_bt0qzk.jpg")
user2.photo.attach(io: file, filename: "laure_avatar.png", content_type: "image/png")


user3 = User.create!(nickname: "Shanti 🫖", email: "shanti.ravdjee@gmail.com", password: "123456")
file = URI.open("https://res.cloudinary.com/dwvaux61b/image/upload/v1678966464/Portraits_LeWagon_20230206_by_BenoitBillard036_hrve7x.jpg")
user3.photo.attach(io: file, filename: "shanti_avatar.png", content_type: "image/png")

user4 = User.create!(nickname: "Sade 👩‍🎤", email: "akonojo.eb@gmail.com", password: "123456")
file = URI.open("https://res.cloudinary.com/dwvaux61b/image/upload/v1678973257/8505BA74-F27C-491D-B8DE-7F0A3E0B3BF8_kqenzc.jpg")
user4.photo.attach(io: file, filename: "jordan_avatar.png", content_type: "image/png")


user5 = User.create!(nickname: "Piou 🐣", email: "hamza.ramdani@hotmail.fr", password: "123456")
file = URI.open("https://res.cloudinary.com/dwvaux61b/image/upload/v1678973112/hamza_zo3d1z.jpg")
user5.photo.attach(io: file, filename: "hamza_avatar.png", content_type: "image/png")

user6 = User.create!(nickname: "Lady Wagona 💃", email: "brien.nicolas@gmail.com", password: "123456")
file = URI.open("https://res.cloudinary.com/dwvaux61b/image/upload/v1678966052/slack-imgs.com_huu1rd.jpg")
user6.photo.attach(io: file, filename: "nicolas_avatar.png", content_type: "image/png")

user7 = User.create!(nickname: "Geof", email: "g.moreaud@gmail.com", password: "123456")
file = URI.open("https://res.cloudinary.com/dwvaux61b/image/upload/v1678973137/geoffroy_yrkrwk.jpg")
user7.photo.attach(io: file, filename: "geoffroy_avatar.png", content_type: "image/png")


user8 = User.create!(nickname: "Jean 🐰", email: "jean.l94240@gmail.com ", password: "123456")
file = URI.open("https://res.cloudinary.com/dwvaux61b/image/upload/v1678968866/jean_jhnert.jpg")
user8.photo.attach(io: file, filename: "jean_avatar.png", content_type: "image/png")

user9 = User.create!(nickname: "Maalox", email: "malo.bobrow@gmail.com", password: "123456")
file = URI.open("https://res.cloudinary.com/dwvaux61b/image/upload/v1678966628/T02NE0241-U04J2S1QY9M-1e53771d3b9a-512_vj0lnu.jpg")
user9.photo.attach(io: file, filename: "malo_avatar.png", content_type: "image/png")


user10 = User.create!(nickname: "Saoule", email: " murielbourre@gmail.com", password: "123456")
file = URI.open("https://res.cloudinary.com/dwvaux61b/image/upload/v1678973130/muriel_mzhakx.jpg")
user10.photo.attach(io: file, filename: "muriel_avatar.png", content_type: "image/png")

user11 = User.create!(nickname: "Millette 🥐", email: "lisamilletpro@gmail.com", password: "123456")
file = URI.open("https://res.cloudinary.com/dwvaux61b/image/upload/v1678966589/T02NE0241-U04JE269VRC-fd5fe896f1ec-512_tshri2.jpg")
user11.photo.attach(io: file, filename: "lisa_avatar.png", content_type: "image/png")

user12 = User.create!(nickname: "Miracolosa", email: " millielasarte@gmail.com", password: "123456")
file = URI.open("https://res.cloudinary.com/dwvaux61b/image/upload/v1678966732/T02NE0241-U04JALGT892-8df71b2e9cde-512_js00x3.png")
user12.photo.attach(io: file, filename: "millie_avatar.png", content_type: "image/png")

user13 = User.create!(nickname: "Guim's", email: "guillaumelaurent05@gmail.com", password: "123456")
file = URI.open("https://res.cloudinary.com/dwvaux61b/image/upload/v1678973104/guillaume_oqhs68.jpg")
user13.photo.attach(io: file, filename: "guillaume_avatar.png", content_type: "image/png")

user14 = User.create!(nickname: "Hache 🪓", email: "halogen.g@gmail.com", password: "123456")
file = URI.open("https://res.cloudinary.com/dwvaux61b/image/upload/v1678973118/gauthier_plpl0v.jpg")
user14.photo.attach(io: file, filename: "gauthier_avatar.png", content_type: "image/png")

user15 = User.create!(nickname: "Mica", email: "micaeldemiranda.pro@gmail.com", password: "123456")
file = URI.open("https://res.cloudinary.com/dwvaux61b/image/upload/v1678968797/michael_mymxvw.jpg")
user15.photo.attach(io: file, filename: "michael_avatar.png", content_type: "image/png")

user16 = User.create!(nickname: "Ursula 💕", email: "ursula.lewagon@gmail.com", password: "123456")
file = URI.open("https://res.cloudinary.com/dwvaux61b/image/upload/v1678973879/T02NE0241-U03AV5KHMDZ-b9d9b1fc9c3b-512_qfkclv.png")
user16.photo.attach(io: file, filename: "ursula_avatar.png", content_type: "image/png")


puts "#{User.all.count} users created"
puts "-------------------------------------------------------------------------"
puts "Start creating a game..."

game = Game.new(name: "test game")

puts "Selecting a playlist on spotify..."
playlist = RSpotify::Playlist.search('exception française').first
game.spotify_playlist_id = playlist.uri

puts "Assigning a game master..."
game.user = user1
game.save

puts "#{game.name} created"
puts "#{game.user.nickname} is the game master!"
puts "Associated playlist: #{playlist.name}"
puts "-------------------------------------------------------------------------"


puts "Start creating a participants (users_games)..."
users = User.all.to_a
# users.pop(7)
users.delete_at(0)

users.each do |user|
  users_game = UsersGame.new
  users_game.game = game
  users_game.user = user
  users_game.save!
  puts "#{users_game.user.nickname} plays at #{game.name}"
end

puts "#{UsersGame.all.count} participants created"
puts "-------------------------------------------------------------------------"

# Find associated tracks
puts "Finding songs from #{playlist.name}..."
tracks = playlist.tracks

# Iterate on each track to create a song
puts "Saving them in song table.."
tracks.each do |track|
  song = Song.new
  song.game = game
  song.title = track.name
  song.album = track.album.name
  song.artist = track.artists.first.name
  song.spotify_track_id = track.uri
  song.save!
end

puts "#{Song.all.count} songs created"
puts "-------------------------------------------------------------------------"

# Generate Fake Answers
puts "Start generating fake aswers for first song (Juliette Armanet - Qu'importe)"
5.times do
  answer = Answer.new
  users_games = UsersGame.all.to_a
  answer.users_game = users_games.sample
  answer.time = rand(2.0..5.0)
  answer.song = Song.find_by(spotify_track_id: "spotify:track:4CAJWoy2MpfDFHirq2ekwB")
  answer.save
end
puts "#{Answer.all.count} answers created"

# Generate Fake scores
5.times do
  users_games = UsersGame.all.to_a
  user_game = users_games.sample
  user_game.score = rand(0.0..50.0).truncate(2)
  user_game.save
end
puts "5 scores generated"

puts "All Done!"
