class UsersController < ApplicationController
  include UsersHelper
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    redirect_to tasks_path unless accessible_user
  end

  # GET /users/new
  def new
    @user = User.new 
  end



  # POST /users or /users.json
  def create
    @user = User.new(user_params) 

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "登録に成功しました" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_user_url(@user), notice: "ユーザーの更新に成功しました" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
 


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id]) 
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end
  
end
