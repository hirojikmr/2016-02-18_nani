class TaskColorsController < ApplicationController
  before_action :set_task_color, only: [:show, :edit, :update, :destroy]

  # GET /task_colors
  # GET /task_colors.json
  def index
    @task_colors = TaskColor.all
  end

  # GET /task_colors/1
  # GET /task_colors/1.json
  def show
  end

  # GET /task_colors/new
  def new
    @task_color = TaskColor.new
  end

  # GET /task_colors/1/edit
  def edit
  end

  # POST /task_colors
  # POST /task_colors.json
  def create
    @task_color = TaskColor.new(task_color_params)

    respond_to do |format|
      if @task_color.save
        format.html { redirect_to @task_color, notice: 'Task color was successfully created.' }
        format.json { render :show, status: :created, location: @task_color }
      else
        format.html { render :new }
        format.json { render json: @task_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_colors/1
  # PATCH/PUT /task_colors/1.json
  def update
    respond_to do |format|
      if @task_color.update(task_color_params)
        format.html { redirect_to @task_color, notice: 'Task color was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_color }
      else
        format.html { render :edit }
        format.json { render json: @task_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_colors/1
  # DELETE /task_colors/1.json
  def destroy
    @task_color.destroy
    respond_to do |format|
      format.html { redirect_to task_colors_url, notice: 'Task color was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_color
      @task_color = TaskColor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_color_params
      params.require(:task_color).permit(:text, :color)
    end
end
