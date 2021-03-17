class FriendshipsController < ApplicationController
  def create
    friend = User.find(params[:friend])
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:notice] = "following user"
      redirect_to my_friends_path
    else
      flash[:alert] = "There was something wrong with the tracking request"
      redirect_to my_friends_path
    end
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "Stopped following"
    redirect_to my_friends_path

  end
end
