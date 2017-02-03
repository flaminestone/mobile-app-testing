require 'rspec'
require_relative '../../libs/app_manager'

devices = nil
google_chrome = nil
test_example = nil
describe 'install application tests' do
  before :all do
    devices = AppManager.initial_devices_by_config
    AppManager.delete_temp_data( devices[0].ip, :google_chrome)
    google_chrome = devices[0].run_app :google_chrome
    test_example = google_chrome.go_to(:doc_linux_test_example)
  end

  describe 'DE' do
    it 'Open DE editors' do
      test_example.create_document.click
      expect(google_chrome.get_address_field.value.nil?).to be_falsey
    end
  end

  describe 'SE' do

  end

  describe 'PE' do

  end

  after :all do
    AppManager.disconnect_all
  end
end
