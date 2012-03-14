class GamesController < ApplicationController
  def index
    @games = Game.paginate(:page => params[:page] || '1', :per_page => 32, :order => "id desc")
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
    @teams = Team.find(:all, :order => "name")
  end

  def create
    @game = Game.new(params[:game])
    if @game.save
      flash[:notice] = 'Game was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @game = Game.find(params[:id])
    @teams = Team.find(:all, :order => "name")
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(params[:game])
      flash[:notice] = 'Game was successfully updated.'
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end

  def destroy
    Game.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
