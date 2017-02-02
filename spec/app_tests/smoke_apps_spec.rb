require 'rspec'
require_relative '../../libs/app_manager'

devices = nil
describe 'install application tests' do
  before :all do
    devices = AppManager.initial_devices_by_config
  end

  it 'Install from google play' do
    object = devices[1].install_app_from_google_play 'market://details?id=com.onlyoffice.documents'
    expect(true).to be_truthy
  end

  after :all do
    AppManager.disconnect_all
  end
end
