class Admin::UsersController < ApplicationController
  include UsersHelper
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: %i[ show edit update destroy ]

  def index
    if administrator
      @users = User.all.includes(:tasks) 
    else
      redirect_to tasks_path, notice: "管理者以外はアクセスできません"
    end
  end


  def new
    if administrator
      @user = User.new 
    else
      redirect_to tasks_path, notice: "管理者しかアクセスできません"
    end
  end


  def show
    redirect_to tasks_path unless accessible_user
  end


  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
  if administrator
    @user = User.new(user_params) 
  else
    redirect_to tasks_path, notice: "管理者しかアクセスできません"
  end

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_user_url(@user), notice: "ユーザーの更新に成功しました" }
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
        format.html { redirect_to user_url(@user), notice: "ユーザーの更新に成功しました" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    if administrator 
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: "ユーザーの削除に成功しました." }
        format.json { head :no_content }
      end
    else
      redirect_to tasks_path, notice: "管理者しかアクセスできません"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
  def user_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end