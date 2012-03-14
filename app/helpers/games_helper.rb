module GamesHelper
  def year_select
    years = []
    this_year = 2011
    14.times do |i|
      years << this_year - i
    end
    years
  end
end
