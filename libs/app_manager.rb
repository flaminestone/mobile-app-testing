require_relative '../libs/android/android_parser'
require_relative '../libs/helpers/adb_helper'
require_relative '../libs/helpers/device'
require_relative '../libs/helpers/device_helper'
require 'json'
class AppManager
  def self.initial_devices_by_config(configure = 'configure.json')
    str = File.open(configure, &:read)
    devices = DeviceHelper.create_devices_by_config(JSON.parse(str))
    devices.each do |current_device|
      AdbHelper.connect(current_device)
    end
  end

  def self.disconnect_all
    AdbHelper.disconnect_all
  end
end
