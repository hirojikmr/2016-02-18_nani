class MemosController < ApplicationController
  before_action :set_memo, only: [:show,  :update, :destroy]

  # GET /memos
  # GET /memos.json
  def index
    @year = Date.today.year
    @month =Date.today.month
    @weeks = cal(@year,@month)
    @memos = Memo.all
  end

  # GET /memos/1
  # GET /memos/1.json
  def show
    day=params[:day]
    month=params[:month]
    year = params[:year]
    memos = Memo.where :date=> sprintf("%04d-%02d-%02d",year,month,day)
    @memo = memos[0]
    
  end


  # GET /memos/new
  def new
    @memo = Memo.new
  end

  # GET /memos/1/edit
  def edit
    day=params[:day]
    month=params[:month]
    year = params[:year]
    memos = Memo.where :date=> sprintf("%04d-%02d-%02d",year,month,day)
    @memo = memos[0]


  end

  # POST /memos
  # POST /memos.json
  def create
    @memo = Memo.new(memo_params)

    respond_to do |format|
      if @memo.save
        format.html { redirect_to @memo, notice: 'Memo was successfully created.' }
        format.json { render :show, status: :created, location: @memo }
      else
        format.html { render :new }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memos/1
  # PATCH/PUT /memos/1.json
  def update
    respond_to do |format|
      if @memo.update(memo_params)
        format.html { redirect_to @memo, notice: 'Memo was successfully updated.' }
        format.json { render :show, status: :ok, location: @memo }
      else
        format.html { render :edit }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memos/1
  # DELETE /memos/1.json
  def destroy
    @memo.destroy
    respond_to do |format|
      format.html { redirect_to memos_url, notice: 'Memo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memo
      @memo = Memo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def memo_params
      params.require(:memo).permit(:date, :body)
    end

    # Returns array of weeks of the year/month.
    #   wday_start: Start day of week (0=Sun, 1=Mon, ..., 6=Sat)
    #
    # Example:
    #   cal(2013, 1)
    #     => [[nil,nil,  1,  2,  3,  4,  5],
    #         [  6,  7,  8,  9, 10, 11, 12],
    #         [ 13, 14, 15, 16, 17, 18, 19],
    #         [ 20, 21, 22, 23, 24, 25, 26],
    #         [ 27, 28, 29, 30, 31]]

    def cal(year, month, wday_start = 1)
      last_day = Date.new(year, month, -1).day
      wday = (Date.new(year, month, 1).wday - wday_start) % 7
      weeks = (wday + last_day + 6) / 7

      (0 ... weeks).map do |i|
        day = i * 7 - wday + 1
        if day <= 0  # First week of the month.
          [nil] * wday + (1 .. 7 - wday).to_a
        elsif day + 7 > last_day  # Last week of the month.
          (day .. last_day).to_a
        else
          (day .. day + 6).to_a
        end
      end
    end


end
