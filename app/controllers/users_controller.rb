class UsersController < ApplicationController
  def index
    @users = User.order("name desc")
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_url, :notice => "Successfully created user. #{undo_link}"
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    undo_link_update = view_context.link_to("undo", revert_version_update_path(@user.versions.scope.last), :method => :patch)
    if @user.update_attributes(user_params)
      redirect_to users_url, :notice => "Successfully updated user. #{undo_link_update}"
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    undo_link_delete = view_context.link_to("undo", revert_version_update_path(@user.versions.scope.last), :method => :delete)
    @user.destroy
    redirect_to users_url, :notice => "Successfully destroyed user. #{undo_link}"
  end
  
  private
  
  def undo_link
    view_context.link_to("undo", revert_version_create_path(@user.versions.scope.last), :method => :post)
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone)
  end
end
