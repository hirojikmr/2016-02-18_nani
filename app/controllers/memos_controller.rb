class MemosController < ApplicationController
  before_action :set_memo, only: [:show,:edit,  :update, :destroy]

  #登録されている予定の配列
  @yotei

  # GET /memos
  # GET /memos.json
  def index
    
    #
    #  先月、今月、来月の予定配列の生成する
    #
    now= Time.now.last_month
    @yotei = Memo.where(:date => now.beginning_of_month..now.end_of_month)
    now = Time.now
    @yotei += Memo.where(:date => now.beginning_of_month..now.end_of_month)
    now = Time.now.next_month
    @yotei += Memo.where(:date => now.beginning_of_month..now.end_of_month)

    @year = Date.today.year
    @month =Date.today.month

    #
    #  表示用配列を生成する　（予定がない部分は、id=0のMemoオブジェクト）
    #
    @prev_month_weeks = cal(@year,@month-1)
    @curr_month_weeks = cal(@year,@month)
    @next_month_weeks = cal(@year,@month+1)

    # すべての予定を取得する (一覧のため）
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
    @memo = Memo.new(:date=>params[:date])
  end

  # GET /memos/1/edit
  def edit
=begin
    day=params[:day]
    month=params[:month]
    year = params[:year]
    memos = Memo.where :date=> sprintf("%04d-%02d-%02d",year,month,day)
    if memos.empty? 
      @memo = Memo.new
      render "new"
    else
      @memo = memos[0]
    end
=end

  end

  # POST /memos
  # POST /memos.json
  def create
    @memo = Memo.new(memo_params)

      if @memo.save
        redirect_to  :action=>"index"

#        format.html { redirect_to @memo, notice: 'Memo was successfully created.' }
#        format.json { render :show, status: :created, location: @memo }
      else
        render :new 
      end
  end

  # PATCH/PUT /memos/1
  # PATCH/PUT /memos/1.json
  def update
      if @memo.update(memo_params)
        redirect_to  :action=>"index"
#        format.html { redirect_to @memo, notice: 'Memo was successfully updated.' }
#        format.json { render :show, status: :ok, location: @memo }
      else
        #format.html { render :edit }
        #format.json { render json: @memo.errors, status: :unprocessable_entity }
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
    #
    def cal(year, month, wday_start = 1)
      
      last_day = Date.new(year, month, -1).day
      wday = (Date.new(year, month, 1).wday - wday_start) % 7
      num_of_weeks = (wday + last_day + 6) / 7

      #
      #  カレンダー配列を作成する (上記のような配列）
      #
      weeks = (0 ... num_of_weeks).map do |i|
        day = i * 7 - wday + 1
        if day <= 0  # First week of the month.
          [nil] * wday + (1 .. 7 - wday).to_a
        elsif day + 7 > last_day  # Last week of the month.
          (day .. last_day).to_a
        else
          (day .. day + 6).to_a
        end
      end

      #
      #  Memoの多次元配列にマップする
      #
      weeks.each do |week|
        week.map! {|day| 
          memo=get_memo_by_date_fast(year,month, day)
        }
      end

    end

    #
    #  日付を指定してMemoを取り出す
    #  存在しなければ　新規でMemoを作成し id=0にする
    #
    def get_memo_by_date_fast(year, month, day)
      if day.nil?
        nil
      else
        yotei = find_memo sprintf("%04d-%02d-%02d",year,month,day)
        if yotei.nil?
          Memo.new(:date=> sprintf("%04d-%02d-%02d",year,month,day), :id=>0)
        else
          yotei
        end
      end
    end

    #
    #  日付をしていして　予定を取り出す
    #  (@yotei配列から）
    #
    def find_memo( date )
      @yotei.each do |y|
        if y.date.to_s == date
          return y
        end
      end
      return nil
    end

end
