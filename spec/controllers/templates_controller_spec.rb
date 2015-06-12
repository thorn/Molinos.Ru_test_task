require 'rails_helper'

describe TemplatesController do
  render_views

  it 'renders test template' do
    get :show, controller_name: :test, id: :test
    expect(response.body).to match(/test template/)
  end
end
