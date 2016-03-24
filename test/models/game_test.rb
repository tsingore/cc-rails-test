# test/models/game_test.rb

require 'test_helper'

class GameTest < ActiveSupport::TestCase

  test "#leaderboard" do
    Player.destroy_all
    Game.destroy_all


    player_1 = Player.create(name: "Peach")
    player_2 = Player.create(name: "Mario")
    player_3 = Player.create(name: "Luigi")

    Game.create(winner_id: player_1.id)
    Game.create(winner_id: player_1.id)
    Game.create(winner_id: player_2.id)
    Game.create(winner_id: player_2.id)
    Game.create(winner_id: player_2.id)
    Game.create(winner_id: player_2.id)
    Game.create(winner_id: player_2.id)
    Game.create(winner_id: player_1.id)
    Game.create(winner_id: player_2.id)
    Game.create(winner_id: player_2.id)
    Game.create(winner_id: player_2.id)
    Game.create(winner_id: player_2.id)
    Game.create(winner_id: player_1.id)
    Game.create(winner_id: player_2.id)
    Game.create(winner_id: player_2.id)
    Game.create(winner_id: player_2.id)
    Game.create(winner_id: player_3.id)
    Game.create(winner_id: player_2.id)

    assert player_1.valid?                                      # Player 1 signed in
    assert_equal(player_1.name, "Peach")                        # Player 1 named "Peach"
    assert_equal(player_2.id, 980190964)                        # Mario has id 980190964
    assert_equal(Game.count, 18)                                # Total games played : 18
    assert_equal(Game.where("winner_id = 980190964").count, 13) # Victories for Mario (score) : 13
    assert_equal(Player.find(Game.first.winner_id).name, player_1.name) # Peach winner for 1st game
    assert_equal((Player.count >= 3), true)                     # Enough players for ranking ( >= 3)

    leaderboard = Game.leaderboard

    assert_equal(player_2.name, leaderboard[0][:player])        # Mario is the first ranked
    assert_equal(player_1.name, leaderboard[1][:player])        # Peach, the second
    assert_equal(player_3.name, leaderboard[2][:player])        # Luigi the third
    assert_equal(13, leaderboard[0][:score])                    # The score is 13
    assert_equal(3, leaderboard.length) # Leaderboard has the 3 players required
  end

end
