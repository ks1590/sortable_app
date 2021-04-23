class Calendar::BlogsController < ApplicationController
  before_action :set_blog, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  PRE = 10
  # GET /blogs or /blogs.json
  def index
    @events = Blog.all.joins(:payment)    
    @event = Blog.new
  end

  # GET /blogs/1 or /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @event = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs or /blogs.json
  def create    
    @event = current_user.blogs.build(blog_params)

    # @blog.save
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event }
        format.json { render :json, status: :created, location: @event }
        format.js { @status = "success" }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
        format.js { @status = "fail" }
      end
    end
  end

  def update
    @blogs = Blog.all.joins(:payment)
    @blogs = @blogs.joins(:category).order(created_at: :desc).page(params[:page]).per(PRE)
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
      @event = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:date, :payment_id, :category_id, :amount)
    end
end
