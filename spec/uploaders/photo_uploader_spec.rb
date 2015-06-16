require 'rails_helper'

require 'carrierwave/test/matchers'

describe PhotoUploader do
  include ActionDispatch::TestProcess
  include CarrierWave::Test::Matchers

  before do
    @photo = FactoryGirl.create(:photo, image: fixture_file_upload('image.jpeg', 'image/jpeg', :binary))
    PhotoUploader.enable_processing = true
    @uploader = PhotoUploader.new(@photo, :image)

    File.open(File.join(ActionController::TestCase.fixture_path, 'image.jpeg')) do |f|
      @uploader.store!(f)
    end
  end

  after do
    PhotoUploader.enable_processing = false
    @uploader.remove!
  end

  context 'the thumb version' do
    it "should scale down a landscape image to be exactly 50 by 25 pixels" do
      expect(@uploader.thumb).to have_dimensions(50, 25)
    end
  end

  it "should make the image readable only to the owner and not executable" do
    expect(@uploader).to have_permissions(0777)
  end
end
