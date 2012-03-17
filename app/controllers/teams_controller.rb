class TeamsController < ApplicationController
  def index
    @teams = Team.paginate(:page => params[:page] || '1', :per_page => 50, :order => :name)
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(params[:team])
    if @team.save
      flash[:notice] = 'Team was successfully created.'
      redirect_to games_path
    else
      render :action => 'new'
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    @team = Team.find(params[:id])
    if @team.update_attributes(params[:team])
      flash[:notice] = 'Team was successfully updated.'
      redirect_to :action => 'show', :id => @team
    else
      render games_path
    end
  end

  def destroy
    Team.find(params[:id]).destroy
    redirect_to games_path
  end
end
