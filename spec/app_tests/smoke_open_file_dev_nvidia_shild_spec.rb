require 'rspec'
require 'onlyoffice_api'
require_relative '../../libs/app_manager'

current_device = nil
main_page = nil
describe 'open files' do
  before :all do
    current_device = AppManager.initial_device('nvidia_shild')
    user_data = AppManager.get_user_data('nvidia_shild')
    AppManager.delete_temp_data(current_device.ip, :onlyoffice)
    login_page = current_device.run_app(:onlyoffice)
    main_page = login_page.login(:portal_name => 'mobile-test.teamlab.info', :email => user_data['user_name'], :password => user_data['pwd'])
    OnlyOfficeApi.configure do |config|
      config.server = 'https://mobile-test.teamlab.info'
      config.username = user_data['user_name']
      config.password = user_data['pwd']
    end
  end

  Dir['/media/flamine/BC64BA2564B9E276/files/DOCX/*'].each do |filepath|
    it "open file #{filepath}" do
      FileHelper.delete_all_files(OnlyOfficeApi)
      OnlyOfficeApi.files.upload_to_my_docs(filepath)
      main_page = main_page.update_file_list
      file_result = main_page.open_file_by_name(File.basename(filepath))
      File.open('table.txt', 'w'){ |file| file.write "base filename, last_filename \n" }

      last_filename = Time.now.nsec
      create_file_table(filepath, last_filename)
      AdbHelper.get_screenshot(current_device.ip, "/home/flamine/screen_shots_shild/#{last_filename}.png")
      expect(file_result).to be_truthy
    end
  end

  def create_file_table(base_filename, filename)
    File.open('table.txt', 'a'){ |file| file.write "#{base_filename}, #{filename}" }
  end

  after :each do
    AdbHelper.push_button(current_device.ip, :esc)
    sleep 1
    AdbHelper.push_button(current_device.ip, :esc)
    current_device.run_app(:onlyoffice)
  end

  after :all do
    AppManager.disconnect_all
    AppManager.delete_temp_data(current_device.ip, :onlyoffice)
  end
end