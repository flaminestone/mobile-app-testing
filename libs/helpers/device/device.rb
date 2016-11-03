# this class is abstraction for device.
class Device
  attr_accessor :serial_number, :status, :name, :ip

  def initialize(*args)
    @serial_number = args.first[:serial_number]
    @status = args.first[:status] || :none
    @name = args.first[:name]
    @ip = args.first[:ip]
  end
end
