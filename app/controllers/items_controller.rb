class ItemsController < Api::BaseController

  before_action :find_item, only: [:show, :destroy, :update]

  def index
    find_items
  end

  def show
  end

    private

    def find_items
      @search = Item.includes(:category).order(created_at: :desc).search(params[:q])
      @items = @search.result
    end

    def find_item
      @item = Item.friendly.find(params[:id])
    end

end
