require 'rspec'
require_relative '../../libs/app_manager'

describe 'open application tests' do
  before :all do
    AppManager.initial_devices_by_config
  end

  it 'open app' do
    expect(true).to be_truthy
  end

  after :all do
    AppManager.disconnect_all
  end
end
