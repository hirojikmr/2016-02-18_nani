class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_title



  def start
    @task = Task.new
    last_task = Task.last
    @task.start = last_task.end
  end

  def end
  end

  # GET /tasks
  # GET /tasks.json
  def index
    
    @days_tasks = get_days_tasks

  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.end = Time.now
    @task.dur = Time.at(@task.end-@task.start)

    #respond_to do |format|
      if @task.save
        @tasks = Task.all

        @days_tasks = get_days_tasks


        render "index"
        #format.html { redirect_to @task, notice: 'Task was successfully created.' }
        #format.json { render :show, status: :created, location: @task }
    #  else
        #format.html { render :new }
        #format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    # end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update

    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:start, :end, :dur, :body)
    end


    def get_days_tasks
      #no tasks? (THIS ONLY HAPPENS WHEN DB.TABLE IS EMPTY..)
      if Task.all[0].nil?
        return []
      end

      all_tasks = Task.all
      days_tasks=[]

      tasks=[]
      cur_day = all_tasks[0].start.day
      all_tasks.each do |t|
        if cur_day != t.start.day
          days_tasks << tasks
          tasks = []
          cur_day = t.start.day
        end
        tasks << t
      end
      days_tasks << tasks

  end

  def set_title
    @title = "Tasks"
  end
end
