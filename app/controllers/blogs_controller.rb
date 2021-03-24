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
      c.chart(type: "bar")   
      c.lang(numericSymbols: "")
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
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
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
      params.require(:blog).permit(:title, :content, :payment_id, :category_id)
    end
end
