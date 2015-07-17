class LinacsController < ApplicationController
  before_action :set_linac, only: [:show, :edit, :update, :destroy]

  # GET /linacs
  # GET /linacs.json
  def index
    @linacs = Linac.all
  end

  # GET /linacs/1
  # GET /linacs/1.json
  def show
  end

  # GET /linacs/new
  def new
    @linac = Linac.new
  end

  # GET /linacs/1/edit
  def edit
  end

  # POST /linacs
  # POST /linacs.json
  def create
    @linac = Linac.new(linac_params)

    respond_to do |format|
      if @linac.save
        format.html { redirect_to root_path, notice: 'Linac was successfully created.' }
        format.json { render :show, status: :created, location: @linac }
      else
        format.html { render :new }
        format.json { render json: @linac.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /linacs/1
  # PATCH/PUT /linacs/1.json
  def update
    respond_to do |format|
      if @linac.update(linac_params)
        format.html { redirect_to @linac, notice: 'Linac was successfully updated.' }
        format.json { render :show, status: :ok, location: @linac }
      else
        format.html { render :edit }
        format.json { render json: @linac.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /linacs/1
  # DELETE /linacs/1.json
  def destroy
    @linac.destroy
    respond_to do |format|
      format.html { redirect_to linacs_url, notice: 'Linac was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_linac
      @linac = Linac.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def linac_params
      params.require(:linac).permit(:name, :user_group_id)
    end
end
