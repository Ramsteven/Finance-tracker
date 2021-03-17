class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @stocks = @user.stocks
  end

  def my_portfolio
    @user = current_user
    @stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def search_friend
     if params[:friend].present?
      @friend = User.search(params[:friend])
      @friend = current_user.except_current_user(@friend)
      if @friend
        respond_to do |format|
          format.js { render partial: 'users/friend_result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Couldn't find user"
          format.js { render partial: 'users/friend_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a user name or email to search"
        format.js { render partial: 'users/friend_result' }
      end
    end

    end
end
