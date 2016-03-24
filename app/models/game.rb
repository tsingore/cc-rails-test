class Game < ActiveRecord::Base


  def self.leaderboard

    players = Player.select("id","name")
    results = Game.group(:winner_id).count
    rankingForAll = Hash.new
    
    players.each do |player|
      name = player[:name]
      score = results[player[:id]]
      rankingForAll[name] = score
    end

    top3 = []

    rankingForAll.sort_by{|name, score| score}.reverse[0,3].each do |name, score|
      top3 << { :player => name, :score => score }
    end

    puts top3
    top3 
  end 


end
