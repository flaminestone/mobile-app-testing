require_relative '../libs/android/android_parser'
require_relative '../libs/helpers/adb/adb_helper'
require_relative '../libs/helpers/device/device'
require_relative '../libs/helpers/device/device_helper'
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

  # disconnect from all devices
  def self.disconnect_all
    AdbHelper.disconnect_all
  end
end
