require 'rspec'
require 'onlyoffice_api'
require_relative '../../../libs/app_manager'

current_device = 'nvidia_shild'
main_page = nil
folder_name = nil
describe 'open files' do
  before :all do
    current_device = AppManager.initial_device(current_device)
    user_data = AppManager.get_user_data(current_device.name)
    AppManager.delete_temp_data(current_device.ip, :onlyoffice)
    folder_name = AppManager.create_scr_result_folder(current_device.name)
    login_page = current_device.run_app(:onlyoffice)
    main_page = login_page.login(:portal_name => PortalData::PORTAL_NAME, :email => user_data['user_name'], :password => user_data['pwd'])
    OnlyOfficeApi.configure do |config|
      config.server = PortalData::FULL_PORTAL_NAME
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
      File.open(folder_name + '/table.txt', 'w'){ |file| file.write "base filename, last_filename \n" }
      File.open(folder_name + '/table.txt', 'a'){ |file| file.write "\n" }
      last_filename = Time.now.nsec
      create_file_table(filepath, last_filename, folder_name)
      AdbHelper.get_screenshot(current_device.ip, "#{folder_name}/#{last_filename}.png")
      expect(file_result).to be_truthy
    end
  end

  def create_file_table(base_filename, filename, folder_name)
    File.open(folder_name + '/table.txt', 'a'){ |file| file.write "#{base_filename}, #{filename} \n" }
  end

  after :each do
    AdbHelper.push_button(current_device.ip, :esc)
    sleep 1
    AdbHelper.push_button(current_device.ip, :esc)
    current_device.run_app(:onlyoffice)
  end

  after :all do
    AppManager.delete_temp_data(current_device.ip, :onlyoffice)
  end
end