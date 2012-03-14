class Game < ActiveRecord::Base

  def winning_team
    Team.find(:first, :conditions => "teams.id = #{self.winning_team_id}")
  end

  def losing_team
    Team.find(:first, :conditions => "teams.id = #{self.losing_team_id}")
  end
end
