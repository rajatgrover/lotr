class CreaturesController < ApplicationController
  # GET /creatures
  # GET /creatures.json
  def index
    @creatures = Creature.all
    @events = Creature.event.except(:comes_in)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @creatures }
    end
  end

  # GET /creatures/1
  # GET /creatures/1.json
  def show
    @creature = Creature.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @creature }
    end
  end

  # GET /creatures/new
  # GET /creatures/new.json
  def new
    r = Ring.instance
    @creature = Creature.new(latitude: r.latitude, longitude: r.longitude)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @creature }
    end
  end

  # GET /creatures/1/edit
  def edit
    @creature = Creature.find(params[:id])
  end

  # POST /creatures
  # POST /creatures.json
  def create
    @creature = Creature.new(params[:creature])

    respond_to do |format|
      if @creature.save
        format.html { redirect_to @creature, notice: 'Creature was successfully created.' }
        format.json { render json: @creature, status: :created, location: @creature }
      else
        format.html { render action: "new" }
        format.json { render json: @creature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /creatures/1
  # PUT /creatures/1.json
  def update
    @creature = Creature.find(params[:id])

    respond_to do |format|
      if @creature.update_attributes(params[:creature])
        format.html { redirect_to @creature, notice: 'Creature was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @creature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /creatures/1
  # DELETE /creatures/1.json
  def destroy
    @creature = Creature.find(params[:id])
    @creature.destroy

    respond_to do |format|
      format.html { redirect_to creatures_url }
      format.json { head :no_content }
    end
  end

  def execute_event
    lat = params[:latitude].to_f
    lon = params[:longitude].to_f
    e = params[:event].to_sym
    cid = params[:cid]
    kid = params[:killed_by]
    r = Ring.instance
    errors = []
    creatures = []
    if !cid.blank?
      c = Creature.where(id: cid).first
      if c.has_ring?
        raise Exception.new("Please transfer the ring to someone else before going away.") if :goes_away == e
        raise Exception.new("Already have the ring with You.") if :receive_ring == e
      end
      creatures << c
    elsif e == :change_position
      creatures = Creature.where(latitude: r.latitude, longitude: r.longitude, is_alive: true)
    end

    creatures.each do |c|
      c.current_event = Creature.event[e]
      puts "==============#{c.current_event} is getting executed for #{c.name}=============="
      c.update_death kid if :died == e
      c.update_ring_creature if e == :receive_ring
      c.update_position(lat, lon) if [:change_position, :goes_away].include? e

      if c.errors.present?
        errors << c.errors
        raise Exception.new(errors.join(", "))
      end
    end

    respond_to do |format|
      if errors.blank?
        flash[:success]="#{Creature.event[:event]} was successful."
        format.html { redirect_to creatures_url, notice: '#{Creature.event[:event]} was successful.' }
        format.json { head :no_content }
      else
        flash[:error]="#{errors.join(",")} so #{Creature.event[:event]} was failled."
        format.html { redirect_to creatures_url, error: '#{errors.join(",")} so #{Creature.event[:event]} was failled.' }
        format.json { render json: errors, status: :unprocessable_entity }
      end
    end
  end
end
