class Api::V1::CategoriesController < Api::BaseController

  before_action :find_category, only: [:show, :destroy, :update]

  def index
    find_root_categories
  end

  def show
  end

  def create
    build_category
    save_category || render_errors
  end

  def update
    update_category || render_errors
  end

  def destroy
    delete_category || render_errors
  end

    private

    def find_root_categories
      @categories = Category.roots.order(created_at: :desc)
    end

    def find_category
      @category = Category.find(params[:id])
    end

    def build_category
      @category = Category.new(category_params)
    end

    def save_category
      @category.save
    end

    def update_category
      @category.update_attributes(category_params)
    end

    def delete_category
      @category.destroy
    end

    def render_errors
      errors = @category.errors.any? ? @category.errors : [ "unknown error" ]
      render json: { errors: errors }.to_json, status: :unprocessable_entity
    end

    def category_params
      params.require(:category).permit(:name, :parent_id)
    end

end
