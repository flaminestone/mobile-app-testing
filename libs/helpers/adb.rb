# class has methods for use adb utilit. Need to connect android devise for use
class Adb
  class << self
    def get_devises
      `adb devices 2<&1`
    end

    def get_state(id)
      `adb -s #{id} get-state 2<&1`
    end
  end
end