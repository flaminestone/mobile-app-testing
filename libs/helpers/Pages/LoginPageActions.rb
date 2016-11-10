require_relative '../../../libs/android/android_page_structure/android_page/OnlyofficeLoginPage'
require_relative '../../../libs/helpers/adb/adb_helper'
class LoginPageActions
  class << self
    def login(*args)
      login_page = args.first[:login_page]
      AdbHelper.click(login_page.ip, args.first[:login_page].structure.portal_address_field.coordinate.first)
      AdbHelper.hide_keybord(login_page.ip)
      AdbHelper.input_text(login_page.ip, args.first[:portal_name] )

      AdbHelper.click(login_page.ip, args.first[:login_page].structure.email_field.coordinate.first)
      AdbHelper.hide_keybord(login_page.ip)
      AdbHelper.input_text(login_page.ip, args.first[:email] )

      AdbHelper.click(login_page.ip, args.first[:login_page].structure.password_field.coordinate.first)
      AdbHelper.hide_keybord(login_page.ip)
      AdbHelper.input_text(login_page.ip, args.first[:password])
      AdbHelper.click(login_page.ip, args.first[:login_page].structure.login_button.coordinate.first)
      sleep 3
    end
  end
end