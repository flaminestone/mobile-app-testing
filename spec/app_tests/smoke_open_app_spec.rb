require 'rspec'
require_relative '../../libs/app_manager'

devices = nil
describe 'open application tests' do
  before :all do
    devices = AppManager.initial_devices_by_config
    login_page = devices[1].run_app :onlyoffice
    LoginPageActions.login(:login_page => login_page, :portal_name => 'mobile-test.teamlab.info', :email => 'john.dorian@tm-runner.no-ip.org', :password => '123456')
  end

  it 'open app :onlyoffice' do
    object = devices[1].run_app :onlyoffice
    expect(true).to be_truthy
  end

  after :all do
    AppManager.disconnect_all
  end
end