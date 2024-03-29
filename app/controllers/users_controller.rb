class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  def show
    @user = User.find(params[:id])
  end
   def index
     
     puts "in users index method>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
     @users = User.paginate(:page => params[:page], :per_page => 1)
     #@users = User.find(:all, :condition => ['id LIKE?'] , params[:user][:search])
  end
  def new
    puts "in new method>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    @user = User.new
  end
    def create
    puts params[:user][:search]
    #@us = User.find_by_name(params[:user][:search])
    @us = User.where(name: params[:user][:search]).select(:id)
    @us.each do |f|
     puts f.name
     end 
    puts "in create method>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> "
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
   def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
   
 private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
     # redirect_to(root_path) unless current_user(@user)
    end
end
