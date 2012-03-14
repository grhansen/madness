class ReportsController < ApplicationController

  def detailed_winning_percentage
    @round = params[:round] || '1'
    @results = Hash.new
    1.upto(16) do |seed|
      games = Game.find(:all, :conditions => "round=#{@round} and (winning_team_seed = #{seed} or losing_team_seed = #{seed})", :order => "losing_team_seed asc")

      wins = Hash.new
      losses = Hash.new
      for game in games
        if game.winning_team_seed == seed
          wins[game.losing_team_seed] = wins[game.losing_team_seed].nil? ? 1 : wins[game.losing_team_seed] + 1
        else
          losses[game.winning_team_seed] = losses[game.winning_team_seed].nil? ? 1 : losses[game.winning_team_seed] + 1
        end
      end

      seed_percentage_array = Array.new
      wins.each { |opponent_seed, number_of_wins|
        games = number_of_wins + (losses[opponent_seed].nil? ? 0 : losses[opponent_seed])
        winning_percentage = ( (number_of_wins / games.to_f) * 100 )
        seed_percentage_array << { opponent_seed => winning_percentage }
        @results[seed] = seed_percentage_array
      }
    end
  end

  def winning_percentage_by_team
    @teams = Team.all(:order => "name")
  end

  def do_winning_percentage_by_team
    @team_1 = Team.find(params[:team_one_id])
    @team_2 = Team.find(params[:team_two_id])
    @round = params[:round]
    @results = {}
    wins_1 = []
    losses_1 = []
    wins_2 = []
    losses_2 = []
    for i in 1..16
      wins_1 << Game.count(:conditions => ["winning_team_id = ? and winning_team_seed = ? and round = ?", @team_1.id, i, @round ])
      losses_1 << Game.count(:conditions => ["losing_team_id = ? and losing_team_seed = ? and round = ?", @team_1.id, i, @round ])
      wins_2 << Game.count(:conditions => ["winning_team_id = ? and winning_team_seed = ? and round = ?", @team_2.id, i, @round ])
      losses_2 << Game.count(:conditions => ["losing_team_id = ? and losing_team_seed = ? and round = ?", @team_2.id, i, @round ])
    end
    @results[:wins_1] = wins_1
    @results[:losses_1] = losses_1
    @results[:wins_2] = wins_2
    @results[:losses_2] = losses_2
  end

  private
  def compute_wins_by_round(_round=1)
      winning_percentage = Hash.new
      games = Game.find(:all, :conditions => "round = #{_round}")
      total_games_by_seed = Hash.new
      won_games_by_seed = Hash.new

      for game in games
        total_games_by_seed[game.winning_team_seed].nil? ? total_games_by_seed[game.winning_team_seed] = 1 : total_games_by_seed[game.winning_team_seed] = total_games_by_seed[game.winning_team_seed] += 1
        won_games_by_seed[game.winning_team_seed].nil? ? won_games_by_seed[game.winning_team_seed] = 1 : won_games_by_seed[game.winning_team_seed] = won_games_by_seed[game.winning_team_seed] += 1

        total_games_by_seed[game.losing_team_seed].nil? ? total_games_by_seed[game.losing_team_seed] = 1 : total_games_by_seed[game.losing_team_seed] = total_games_by_seed[game.losing_team_seed] += 1
      end

      total_games_by_seed.each_pair { |total_key, total_value| winning_percentage[total_key] = won_games_by_seed[total_key].nil? ? 0 : won_games_by_seed[total_key] / total_games_by_seed[total_key].to_f  }
      winning_percentage
  end
end

