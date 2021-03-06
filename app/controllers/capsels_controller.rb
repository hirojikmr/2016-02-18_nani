class CapselsController < ApplicationController
  before_action :set_capsel, only: [:show, :edit, :update, :destroy]
  before_action :set_title

  @title = "Capsels"
  # GET /capsels
  # GET /capsels.json
  def index
    @capsels = Capsel.all
  end

  # GET /capsels/1
  # GET /capsels/1.json
  def show
  end

  # GET /capsels/new
  def new
    @capsel = Capsel.new
  end

  # GET /capsels/1/edit
  def edit
  end

  # POST /capsels
  # POST /capsels.json
  def create
    Capsel.delete_all

    data = params[:data]
    arr = []
    data.each_line do |l|
      sp = l.split(' ')
      regex = /\d{1,2}\/\d{1,2}/
      arr << {start:Date.parse(sp[0][regex]), end:Date.parse(sp[1][regex])}
    end

    arr.each do |h|
      Capsel.create(h)
    end

    redirect_to memos_path
  end

  # PATCH/PUT /capsels/1
  # PATCH/PUT /capsels/1.json
  def update
    respond_to do |format|
      if @capsel.update(capsel_params)
        format.html { redirect_to @capsel, notice: 'Capsel was successfully updated.' }
        format.json { render :show, status: :ok, location: @capsel }
      else
        format.html { render :edit }
        format.json { render json: @capsel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /capsels/1
  # DELETE /capsels/1.json
  def destroy
    @capsel.destroy
    respond_to do |format|
      format.html { redirect_to capsels_url, notice: 'Capsel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_capsel
      @capsel = Capsel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def capsel_params
      params.require(:capsel).permit(:start, :end)
    end

    def set_title
      @title="Capsels"
    end
end
