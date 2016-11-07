# this class is abstraction for device.
require_relative '../../../libs/helpers/adb/adb_helper'
require_relative '../../../libs/helpers/device/device_actions'
require_relative '../../../libs/android/android_parser'
class Device
  include DeviceActions
  include AndroidParser
  attr_accessor :serial_number, :status, :name, :ip

  def initialize(*args)
    @serial_number = args.first[:serial_number]
    @status = args.first[:status] || :none
    @name = args.first[:name]
    @ip = args.first[:ip]
  end
end
