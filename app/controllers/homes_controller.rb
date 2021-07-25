class HomesController < ApplicationController
  before_action :authenticate_customer!, except:[:top, :about ]

  def top
    @items = Item.all
  end

  def about
  end

end
