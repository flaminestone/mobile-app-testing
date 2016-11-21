require_relative '../libs/android/android_parser'
require_relative '../libs/helpers/adb/adb_helper'
require_relative '../libs/helpers/device/device'
require_relative '../libs/helpers/device/device_helper'
require_relative '../libs/helpers/FileHelper'
require_relative '../libs/helpers/LoggerHelper'
require_relative 'portal_data'
require 'json'
class AppManager
  # method will connect to all devices from configure.json and return array of devices [Device] objects
  def self.initial_devices_by_config(configure = 'configure.json')
    str = File.open(configure, &:read)
    devices = DeviceHelper.create_devices_by_config(JSON.parse(str))
    devices.map do |current_device|
      AdbHelper.connect(current_device)
    end
  end

  # method initial device object
  # @param device_name [String] is a name of device. See configure.json
  def self.initial_device(device_name)
    str = File.open('configure.json', &:read)
    if JSON.parse(str).key?(device_name)
      JSON.parse(str)[device_name]
      devices = DeviceHelper.create_devices_by_config({device_name => JSON.parse(str)[device_name]}).first
      AdbHelper.connect(devices)
    else
      raise "Device #{device_name} is not found"
    end
    devices
  end

  # Get user data for device.
  # @param device_name [String] is a name of device. See configure.json
  def self.get_user_data(device_name)
    str = File.open('configure.json', &:read)
    if JSON.parse(str).key?(device_name)
      user_data = JSON.parse(str)[device_name]['user_data']
    else
      raise "Device #{device_name} is not found"
    end
    user_data
  end

  # disconnect from all devices
  def self.disconnect_all
    AdbHelper.disconnect_all
  end

  # delete all cashed and saved data from app by device ip
  def self.delete_temp_data(ip, app)
    AdbHelper.delete_app_data(ip, app)
  end

  def self.create_scr_result_folder(folder_name)
    folder_name = 'screens/' + folder_name + "_" + Time.now.strftime('%d_%b_%Y_%H:%M:%S')
    FileUtils.mkdir_p(folder_name)
    folder_name
  end
end
