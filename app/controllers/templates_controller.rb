class TemplatesController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    render template: '/templates/' + params[:controller_name] + '/' + params[:id], layout: false
  end
end
