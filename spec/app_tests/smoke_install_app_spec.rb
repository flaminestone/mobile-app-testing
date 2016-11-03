require 'rspec'
require_relative '../../libs/app_manager'

devices = nil
describe 'install application tests' do
  before :all do
    devices = AppManager.initial_devices_by_config
  end

  it 'Install from google play' do
    expect(true).to be_truthy
  end

  after :all do
    AppManager.disconnect_all
  end
end
