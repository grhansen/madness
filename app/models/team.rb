class Team < ActiveRecord::Base
  def won(game)
    game.winning_team.id = self.id
  end

  def lost(game)
    game.losing_team.id = self.id
  end
end
