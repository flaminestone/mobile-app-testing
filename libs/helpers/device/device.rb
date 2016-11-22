# this class is abstraction for device.
require_relative '../../../libs/helpers/device/device_actions'
class Device
  include DeviceActions
  attr_accessor :serial_number, :status, :name, :ip, :user_data

  def initialize(*args)
    @serial_number = args.first[:serial_number]
    @status = args.first[:status] || :none
    @name = args.first[:name]
    @ip = args.first[:ip]
  end
end
