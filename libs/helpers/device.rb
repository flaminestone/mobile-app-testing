# this class is abstraction for device.
class Device
  attr_accessor :serial_number, :status

  def initialize(serial_number)
    @serial_number = serial_number
    @status = :none
  end
end