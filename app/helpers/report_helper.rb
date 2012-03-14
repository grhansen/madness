module ReportHelper
  def compute_percentage(wins, losses, seed)
    wins = wins[seed]
    losses = losses[seed]
    wins + losses > 0 ? ( wins.to_f / (wins.to_f + losses.to_f)) : 0
  end
end
