require 'rspec'
require_relative '../../libs/app_manager'

describe 'open application tests' do
  before :all do
    AppManager.initial_devices_by_config
  end

  it 'open app' do
  end

  after :all
    AppManager.disconnect_all do
  end
end
