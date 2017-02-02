require 'rspec'
require_relative '../../libs/app_manager'

devices = nil
describe 'install application tests' do
  before :all do
    devices = AppManager.initial_devices_by_config
    AppManager.delete_temp_data( devices[3].ip, :google_chrome)
  end

  it 'Install from google play' do
    object = devices[1].install_app_from_google_play 'market://details?id=com.onlyoffice.documents'
    expect(true).to be_truthy
  end

  it 'Run Google Chrome' do
    google_chrome = devices[3].run_app :google_chrome
    google_chrome.go_to('google.ru')
    google_chrome.get_address_field.value
    expect(google_chrome.get_address_field.value.include?('https://www.google.ru')).to be_truthy
  end

  after :all do
    AppManager.disconnect_all
  end
end
