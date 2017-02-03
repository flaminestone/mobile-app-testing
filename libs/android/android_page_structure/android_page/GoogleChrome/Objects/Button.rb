require_relative '../../../../../../libs/android/android_page_structure/common_parser/common_data/Element'
require_relative '../../../../../../libs/helpers/device/device'

class Button < Element
  def initialize(*args)
    super
    @xpath = args.first[:xpath]
    @parant = args.first[:parant]
    @ip = @parant.ip
  end

  def click
    unless visible?
      screen_swipe_for_find_button
    end
    AdbHelper.click(@ip, @coordinats.first)
  end

  def visible?
    @page = @parant.get_dump('main_page').xmlobj
    @coordinats = to_coord(@page.xpath(@xpath + '/@bounds').to_s.split(/\D/))
    !@coordinats.nil?
  end

  def screen_swipe_for_find_button
    page_size = to_coord(@page.xpath('//*[@resource-id="android:id/content"]/@bounds').to_s.split(/\D/)).last
    coord_1 = Coordinates.new("#{page_size.x.to_i/2}", "#{page_size.y.to_i*0.75}")
    coord_2 = Coordinates.new("#{page_size.x.to_i/2}", "#{page_size.y.to_i*0.25}")
    10.times do
      if visible?
        return
      else
        AdbHelper.screen_swipe(@ip, coord_1, coord_2)
      end
    end
  end
end