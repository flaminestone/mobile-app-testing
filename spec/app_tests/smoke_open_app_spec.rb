require 'rspec'
require_relative '../../libs/app_manager'

devices = nil
describe 'open application tests' do
  before :all do
    devices = AppManager.initial_devices_by_config
  end


  it 'open app :onlyoffice' do
    object = devices[1].run_app :onlyoffice
    expect(true).to be_truthy
  end

  after :all do
    AppManager.disconnect_all
  end
end
