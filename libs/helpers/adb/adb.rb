# class has methods for use adb utilit. Need to connect android devise for use
require 'onlyoffice_logger_helper/logger_helper'
class Adb
  class << self
    def get_devises
      command = 'adb devices 2<&1'
      OnlyofficeLoggerHelper.log("Run adb command #{command}", 33)
      `#{command}`
    end

    def get_state(id)
      command = "adb -s #{id} get-state 2<&1"
      OnlyofficeLoggerHelper.log("Run adb command #{command}", 33)
      `#{command}`
    end

    def get_wlan_data(id)
      command = "adb -s #{id} shell ip -f inet addr show wlan0 2<&1"
      OnlyofficeLoggerHelper.log("Run adb command #{command}", 33)
      `#{command}`
    end

    def connect(id, ip)
      command = "adb -s #{id} connect #{ip} 2<&1"
      OnlyofficeLoggerHelper.log("Run adb command #{command}", 33)
      `#{command}`
    end

    def disconnect(id)
      command = "adb disconnect #{id} 2<&1"
      OnlyofficeLoggerHelper.log("Run adb command #{command}", 33)
      `#{command}`
    end

    def disconnect_all
      command = "adb disconnect 2<&1"
      OnlyofficeLoggerHelper.log("Run adb command #{command}", 33)
      `#{command}`
    end

    def set_port(id, port = '5555')
      command = "adb -s #{id} tcpip #{port} 2<&1"
      OnlyofficeLoggerHelper.log("Run adb command #{command}", 33)
      OnlyofficeLoggerHelper.log("Sleep 3 for reboot tcp", 33)
      sleep 3 # need to reboot tcp
      `#{command}`
    end

    def shell_start_by_ip(ip, command, key = 'a')
      if command == 'com.onlyoffice.documents/.activities.MainActivity'
          command = '"com.onlyoffice.documents/com.onlyoffice.documents.activities.MainActivity" -a android.intent.action.MAIN -c android.intent.category.LAUNCHER'
      end
      command_for_run = "adb -s #{ip} shell am start -#{key} #{command} 2<&1"
      OnlyofficeLoggerHelper.log("Run adb command #{command_for_run}", 33)
      `#{command_for_run}`
    end

    def pull(ip, pull_from, pull_to)
      command = "adb -s #{ip} pull #{pull_from} #{pull_to} 2<&1"
      OnlyofficeLoggerHelper.log("Run adb command #{command}", 33)
      `#{command}`
    end

    def dump(ip, save_to)
      command = "adb -s #{ip} pull $(adb -s #{ip}  shell uiautomator dump | grep -oP '[^ ]+.xml') #{save_to}.xml 2<&1"
      OnlyofficeLoggerHelper.log("Run adb command #{command}", 33)
      `#{command}`
    end

    def click(ip, x, y)
      command = "adb -s #{ip} shell input tap #{x} #{y} 2<&1"
      OnlyofficeLoggerHelper.log("Run adb command #{command}", 33)
      `#{command}`
    end

    def input_text(ip, text)
      command = "adb -s #{ip} shell input text #{text} 2<&1"
      OnlyofficeLoggerHelper.log("Run adb command #{command}", 33)
      `#{command}`
    end

    def push_button(ip, button_key)
      command = "adb -s #{ip} shell input keyevent #{button_key} 2<&1"
      OnlyofficeLoggerHelper.log("Run adb command #{command}", 33)
      `#{command}`
    end

    def hide_keyboard(ip)
      command = "adb -s #{ip} shell input keyevent 111 2<&1"
      OnlyofficeLoggerHelper.log("Run adb command #{command}", 33)
      `#{command}`
    end

    def delete_app_data(ip, package_name)
      command = "adb -s #{ip} shell pm clear #{package_name}"
      OnlyofficeLoggerHelper.log("Run adb command #{command}", 33)
      `#{command}`
    end

    def screen_swipe(ip, x1, y1, x2, y2)
      command = "adb -s #{ip} shell input touchscreen swipe #{x1} #{y1} #{x2} #{y2} 2<&1"
      OnlyofficeLoggerHelper.log("Run adb command #{command}", 33)
      `#{command}`
    end

    def set_shell_commands(ip, command)
      command = "adb -s #{ip} shell #{command} 2<&1"
      OnlyofficeLoggerHelper.log("Run adb command #{command}", 33)
      `#{command}`
    end

    def get_active_windows_data(ip)
      command = "adb -s #{ip} shell dumpsys window windows | grep -E 'mCurrentFocus|mFocusedApp' 2<&1"
      OnlyofficeLoggerHelper.log("Run adb command #{command}", 33)
      `#{command}`
    end

    def get_screenshot(ip, path)
      command = "adb -s #{ip} shell screencap -p \"/sdcard/screenshot.png\""
      OnlyofficeLoggerHelper.log("Run adb command #{command}", 33)
      `#{command}`
      command = "adb -s #{ip} pull /sdcard/screenshot.png #{path}"
      OnlyofficeLoggerHelper.log("Run adb command #{command}", 33)
      `#{command}`
    end
  end
end