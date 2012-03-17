class Team < ActiveRecord::Base
  has_many :wins, :class_name => 'Game', :foreign_key => :winning_team_id
  has_many :losses, :class_name => 'Game', :foreign_key => :losing_team_id

  def games
    Game.where("games.winning_team_id = #{id} or games.losing_team_id = #{id}")
  end

  def won(game)
    game.winning_team.id = self.id
  end

  def lost(game)
    game.losing_team.id = self.id
  end
end
