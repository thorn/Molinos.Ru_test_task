class Api::V1::ItemsController < Api::BaseController

  before_action :find_item, only: [:show, :destroy, :update]

  def index
    find_items
  end

  def show
  end

  def create
    build_item
    save_item || render_errors
  end

  def update
    update_item || render_errors
  end

  def destroy
    delete_item || render_errors
  end

    private

    def find_items
      @search = Item.includes(:category).order(created_at: :desc).search(params[:q])
      @items = @search.result
    end

    def find_item
      @item = Item.find(params[:id])
    end

    def build_item
      @item = Item.new(item_params)
    end

    def save_item
      @item.save
    end

    def update_item
      @item.update_attributes(item_params)
    end

    def delete_item
      @item.destroy
    end

    def render_errors
      errors = @item.errors.any? ? @item.errors : [ "unknown error" ]
      render json: { errors: errors }.to_json, status: :unprocessable_entity
    end

    def item_params
      params.require(:item).permit(:name, :parent_id)
    end

end
