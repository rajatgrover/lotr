class CreatureHistoriesController < ApplicationController
  # GET /creature_histories
  # GET /creature_histories.json
  def index
    @creature_histories = CreatureHistory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @creature_histories }
    end
  end

  # GET /creature_histories/1
  # GET /creature_histories/1.json
  def show
    @creature_history = CreatureHistory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @creature_history }
    end
  end

  # GET /creature_histories/new
  # GET /creature_histories/new.json
  def new
    @creature_history = CreatureHistory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @creature_history }
    end
  end

  # GET /creature_histories/1/edit
  def edit
    @creature_history = CreatureHistory.find(params[:id])
  end

  # POST /creature_histories
  # POST /creature_histories.json
  def create
    @creature_history = CreatureHistory.new(params[:creature_history])

    respond_to do |format|
      if @creature_history.save
        format.html { redirect_to @creature_history, notice: 'Creature history was successfully created.' }
        format.json { render json: @creature_history, status: :created, location: @creature_history }
      else
        format.html { render action: "new" }
        format.json { render json: @creature_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /creature_histories/1
  # PUT /creature_histories/1.json
  def update
    @creature_history = CreatureHistory.find(params[:id])

    respond_to do |format|
      if @creature_history.update_attributes(params[:creature_history])
        format.html { redirect_to @creature_history, notice: 'Creature history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @creature_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /creature_histories/1
  # DELETE /creature_histories/1.json
  def destroy
    @creature_history = CreatureHistory.find(params[:id])
    @creature_history.destroy

    respond_to do |format|
      format.html { redirect_to creature_histories_url }
      format.json { head :no_content }
    end
  end
end
