class MemosController < ApplicationController
  before_action :set_memo, only: [:show, :update, :destroy]
  before_action :set_title


  @title="Memos"

  # 定期的に保存する
  #   javascriptから定期的に呼び出す 
  #  (_form.html.erb)
  def periodic_save
    memo=Memo.find(params[:id])
    memo.assign_attributes(:body=>params[:body],:body2=>params[:body2],:body3=>params[:body3],:body4=>params[:body4], :body5=>params[:body5])


    # 保存できたらOK
    if memo.save
      #render :text=>"OK" 
      #render :text=> Time.now.to_s #calc_jisseki(params[:body])
      render :text=>"OK" #calc_jisseki([params[:body],params[:body2],params[:body3]])
    else
      render :text =>"NG"
    end
  end

  def calc_jisseki(bodies)
      # 実績の文字列を切り出す
      arr = []
      bodies.each do |str|
        task_name = (str.scan(/<TASK (.*)>/)[0][0])
        task_time = (str.scan(/\(実(.*).*\)/)[0][0])

        #arr << sprintf("%s",hoge") # sprintf("(%s->%s) ",task_name, ask_time)

        #arr << (str.scan /.*\(実(.*).*\)/)
      end
      return  "testing..."
  end



  # GET /memos
  # GET /memos.json
  def index
    @title = "Cal" 
    #
    # 　複数のカレンダーを表示できるようにする
    #
    @year = Date.today.year
    @yotei = Memo.all
    @month_weeks_arr = []
    @month_start = 1
    @month_end =  12
    (@month_start..@month_end).each do |m|
      @month_weeks_arr << cal(2016,m)
    end

    @capsel_start_dates = Capsel.all.map{ |c| c.start }
    
    @capsel_stay_dates =[]
    Capsel.all.each do  |c|
      (c.start..c.end-1).each do  |d|
        @capsel_stay_dates << d
      end
    end

    # すべての予定を取得する (一覧のため）
    @memos = Memo.order("updated_at DESC")
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

    prep_edit

    @memo.save

    # 編集状態で開く
    redirect_to edit_memo_path(@memo)
  end



  # GET /memos/1/edit
  def edit
    @title = "memo"

    @memo = Memo.find(params[:id])

    prep_edit
    @memo.save

  end


  def filter_out_OK ( str)
    # OKから始まる行を排除する
    str.gsub(/^OK.*$\n/,'')
  end

  # POST /memos
  # POST /memos.json
  def create
    @memo = Memo.new(memo_params)

      if @memo.save
        #redirect_to  :action=>"index"
        render :edit

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
         #redirect_to  :action=>"index"
         render :edit
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
      params.require(:memo).permit(:id, :date, :body, :body2, :body3, :body4, :body5)
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
        yotei = _find_memo sprintf("%04d-%02d-%02d",year,month,day)
        if yotei.nil?
          Memo.new(:date=> sprintf("%04d-%02d-%02d",year,month,day), :id=>0)
        else
          yotei
        end
      end
    end
    def get_memo_by_date_fast_obj( date )
      get_memo_by_date_fast( date.year, date.month, date.day ) 
    end
    #
    #  日付を指定して　予定を取り出す
    #  (@yotei配列から）
    #
    def _find_memo( date )
      @yotei.each do |y|
        if y.date.to_s == date
          return y
        end
      end
      return nil
    end

  def set_title
    @title = "Memos"
  end

  def prep_edit
    # 全ての予定を取得
    @yotei = Memo.all
    # 前日のMemo取得
    @prev_day_memo = get_memo_by_date_fast_obj @memo.date-1
    # 翌日のMemo取得
    @next_day_memo = get_memo_by_date_fast_obj @memo.date+1

    # コピー要求があり
    if params[:copy]=="YES" 
      # 前日のbodyをコピーする
      @memo.body   = @memo.body.to_s
      @memo.body  += filter_out_OK @prev_day_memo.body.to_s 
      
      @memo.body2  = @memo.body2.to_s
      @memo.body2 += filter_out_OK @prev_day_memo.body2.to_s

      @memo.body3  = @memo.body3.to_s
      @memo.body3 += filter_out_OK @prev_day_memo.body3.to_s

      @memo.body4  = @memo.body4.to_s
      @memo.body4 += filter_out_OK @prev_day_memo.body4.to_s

      @memo.body5  = @memo.body5.to_s
      @memo.body5 += filter_out_OK @prev_day_memo.body5.to_s
    end
  end

end
