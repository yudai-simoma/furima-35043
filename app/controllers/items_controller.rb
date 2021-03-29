class ItemsController < ApplicationController
  
  def index
  end

  def new
    @item = Itme.new
  end

  def create

  end
end

private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end