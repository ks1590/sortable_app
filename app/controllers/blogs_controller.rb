class BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  PRE = 5
  # GET /blogs or /blogs.json
  def index
    @blogs = Blog.all.joins(:payment)
    @blogs = @blogs.joins(:category).order(created_at: :desc).page(params[:page]).per(PRE)
    @blog = Blog.new

    # (...データベースからのデータ取得処理...)
    # ダミーのデータを用意
    months = Category.pluck(:name)
    product_A_sales = [ 1000, 12000, 13000,
      1400, 12000, 50000 ]
    # グラフ（チャート）を作成 
    @chart = LazyHighCharts::HighChart.new("graph") do |c|
      c.title(text: "支出内訳")
      c.xAxis(categories: months)
      c.yAxis(min:0,title: {text: '円'})
      c.tooltip(valueSuffix: 'millions')
      c.series(name: "A", data: product_A_sales)
      # c.series({name: "A", y: 1000,name: "B", y: 1000})
      c.chart(type: "bar")
    end
  end

  def chart
    months = Category.pluck(:name)
    product_A_sales = [ 1000, 12000, 13000,
      1400, 12000, 50000 ]
    # グラフ（チャート）を作成 
    # @chart = LazyHighCharts::HighChart.new("graph") do |c|
    #   c.title(text: "支出内訳")
    #   c.xAxis(categories: months)
    #   c.yAxis(min:0,title: {text: '円'})
    #   c.tooltip(valueSuffix: 'millions')
    #   c.series(name: "A", data: product_A_sales)
    #   # c.series({name: "A", y: 1000,name: "B", y: 1000})
    #   c.chart(type: "bar")
    #   c.lang({numericSymbols: nil})
    # end

    @chart_column = LazyHighCharts::HighChart.new("graph") do |c|
      c.title(text: "4-9月売上")
      # X軸の名称を設定 '月'
      c.xAxis(categories: months, title: {text: '月'})       # Y軸の名称を設定 '円'
      c.yAxis(title: {text: '円'})
      c.series(name: "A", data: product_A_sales)
      # c.series(name: "B", data: product_B_sales)
      # 判例を右側に配置
      c.legend(align: 'right', verticalAlign: 'top', 
      x: -100, y: 180, layout: 'vertical')      
      c.chart(type: "column")
    end

    category = Category.pluck(:name)
    @chart_pie = LazyHighCharts::HighChart.new("graph") do |c|
      c.title(text: "製品別上期売上")
      c.series({
        colorByPoint: true,
        # ここでは各月の売上額合計をグラフの値とする
        data: [{
        name: category[0],
        y: 1000
        }, {
        name: category[1],
        y: 3500
        }, {
        name: category[2], 
        y: 2000
        }, {
        name: category[3], 
        y: 2500
        }, {
        name: category[4], 
        y: 4500
        }]
      })
      c.plotOptions(pie: {
        allowPointSelect: true,
        cursor: 'pointer',
        dataLabels: {
          enabled: true,
          format: '{point.name}: {point.percentage:.1f} %',
        }
      })
      # グラフの種類として「パイチャート」を指定
      c.chart(type: "pie")
    end

    @chart_pie2 = LazyHighCharts::HighChart.new("graph") do |c|
      c.title(text: "製品別上期売上")
      c.series({
        colorByPoint: true,
        # ここでは各月の売上額合計をグラフの値とする
        data: [{
        name: category[0],
        y: 1000
        }, {
        name: category[1],
        y: 500
        }, {
        name: category[2], 
        y: 2000
        }, {
        name: category[3], 
        y: 2500
        }, {
        name: category[4], 
        y: 500
        }]
      })
      c.plotOptions(pie: {
        allowPointSelect: true,
        cursor: 'pointer',
        dataLabels: {
          enabled: true,
          format: '{point.name}: {point.percentage:.1f} %',
        }
      })
      # グラフの種類として「パイチャート」を指定
      c.chart(type: "pie")
    end

    @chart_pie3 = LazyHighCharts::HighChart.new("graph") do |c|
      c.title(text: "製品別上期売上")
      c.series({
        colorByPoint: true,
        # ここでは各月の売上額合計をグラフの値とする
        data: [{
        name: category[0],
        y: 1000
        }, {
        name: category[1],
        y: 500
        }, {
        name: category[2], 
        y: 2000
        }, {
        name: category[3], 
        y: 2500
        }, {
        name: category[4], 
        y: 500
        }]
      })
      c.plotOptions(pie: {
        allowPointSelect: true,
        cursor: 'pointer',
        dataLabels: {
          enabled: true,
          format: '{point.name}: {point.percentage:.1f} %',
        }
      })
      # グラフの種類として「パイチャート」を指定
      c.chart(type: "pie")
    end
  end

  # GET /blogs/1 or /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs or /blogs.json
  def create
    @blogs = Blog.all.joins(:payment)
    @blogs = @blogs.joins(:category).order(created_at: :desc).page(params[:page]).per(PRE)
    @blog = current_user.blogs.build(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog }
        format.json { render :show, status: :created, location: @blog }
        format.js { @status = "success" }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
        format.js { @status = "fail" }
      end
    end
  end

  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    @blogs = Blog.all.joins(:payment)
    @blogs = @blogs.joins(:category).order(created_at: :desc).page(params[:page]).per(PRE)
    @blog = current_user.blogs.build(blog_params)
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog }
        format.json { render :show, status: :ok, location: @blog }
        format.js { @status = "success" }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
        format.js { @status = "fail" }
      end
    end
  end

  # DELETE /blogs/1 or /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:date, :payment_id, :category_id, :amount)
    end
end
