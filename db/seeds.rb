# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'

p "Seed Init"

File.open("db/data_seed/companies.json", "r") do |file|
  JSON.load(file).map do |company_data|
    Company.create(company_data)
  end
end

File.open("db/data_seed/platforms.json", "r") do |file|
  JSON.load(file).map do |platform_data|
    Platform.create(platform_data)
  end
end

File.open("db/data_seed/genres.json", "r") do |file|
  JSON.load(file)["genres"].map do |genre_name|
    Genre.create(name: genre_name)
  end
end

File.open("db/data_seed/games.json", "r") do |file|
  games = JSON.load(file).map do |game_hash|
    game_platforms = game_hash["platforms"].to_a.map do |platform_data|
      Platform.find_by(platform_data)
    end
    game_genres = game_hash["genres"].to_a.map do |genre_name|
      Genre.find_by(name: genre_name)
    end

    game_hash["platforms"] = game_platforms
    game_hash["genres"] = game_genres

    game_hash
  end

  main_games, unsaved_games = 
    games
    .map{|game_hash| game_hash.slice("name", "summary", "release_date", "category", "rating", "parent") }
    .partition{|game_hash| game_hash["category"]==0}
  
  saved_games = main_games.map{|game_hash| Game.create(game_hash)}

  while unsaved_games.length != 0
    saved_titles = saved_games.map{|game| game.name}
    to_be_save, unsaved_games = unsaved_games.partition do |unsaved_game|
      saved_titles.include?(unsaved_game["parent"])
    end
    to_be_save.each do |game_hash|
      parent = Game.find_by(name: game_hash["parent"])
      game_hash["parent"] = parent
      Game.create(game_hash)
    end
  end

  games.each do |game_hash|
    game_hash["name"]
    game_hash["involved_companies"]
    game = Game.find_by(name: game_hash["name"])
    next if game_hash["involved_companies"].nil?
    game_hash["involved_companies"].each do |involved_company|
      company = Company.find_by(name: involved_company["name"])
      involved_company_hash = involved_company.slice("developer", "publisher")
      involved_company_hash["company"] = company
      involved_company_hash["game"] = game
      inv = InvolvedCompany.create(involved_company_hash)
    end
  end

  p "Seed Finished"
end