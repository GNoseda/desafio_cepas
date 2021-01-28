class WinesController < ApplicationController
  before_action :set_wine, only: %i[ show edit update destroy ]
  before_action :set_strains, only: %i[ new create update]
  before_action :set_oenologists, only: %i[ edit update]
  before_action :user_can_edit, only: %i[ new edit update destroy ]
  # GET /wines or /wines.json
  def index
    @wines = Wine.all.order(:name)
  end

  # GET /wines/1 or /wines/1.json
  def show
  end

  # GET /wines/new
  def new
    @wine = Wine.new
  end

  # GET /wines/1/edit
  def edit
    @strains = Strain.all
    @oenologists = Oenologist.all
  end

  # POST /wines or /wines.json
  def create
    @wine = Wine.new(wine_params)

    respond_to do |format|
      if @wine.save
        format.html { redirect_to @wine, notice: "Wine was successfully created." }
        format.json { render :show, status: :created, location: @wine }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @wine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wines/1 or /wines/1.json
  def update
    respond_to do |format|
      if @wine.update(wine_params)
        format.html { redirect_to @wine, notice: "Wine was successfully updated." }
        format.json { render :show, status: :ok, location: @wine }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @wine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wines/1 or /wines/1.json
  def destroy
    @wine.destroy_dependencies
    @wine.destroy
    respond_to do |format|
      format.html { redirect_to wines_url, notice: "Wine was successfully destroyed." }
      format.json { head :no_content } 
    end
  end

  private
    def user_can_edit
      if !current_user.can_edit?
        redirect_to root_path, notice: "You cant access there!"
      end
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_wine
      @wine = Wine.find(params[:id])
    end

    def set_strains
      @strains = Strain.all
    end
    
    def set_oenologists
      @oenologists = Oenologist.pluck(:name, :id)
    end
    
    
    # Only allow a list of trusted parameters through.
    def wine_params
      params.require(:wine).permit(:name, assemblies_attributes: [:id, :portion, :strain_id], grades_attributes: [:id, :oenologist_id, :grade])
    end
end
