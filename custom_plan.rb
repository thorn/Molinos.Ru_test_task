require 'zeus/rails'

class CustomPlan < Zeus::Rails
  def test
    # Reloading Factories
    Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
    require 'factory_girl'
    FactoryGirl.reload
    super
  end

end

Zeus.plan = CustomPlan.new
