require "parallel"
require "image_size"
require "open3"


class PrivateEye::Compare
  attr_reader :test_data, :screen, :step_data

  def initialize(test_data, step_data)
    @test_data = test_data
    @step_data = step_data
    @screen = test_data.display_allocation.screen_id
  end

  def compare
  binding.pry
  screenshot
  # take screenshot
  # compare
  return pass
  end

  def screenshot
    spawn("DISPLAY=:#{screen} import -window root #{file_path}")
  end

  def file_path
    base_path = "test_library/private_eye/#{site}/#{title_of_test}"
    FileUtils.mkdir_p(base_path) unless File.exist?(base_path + '/base.png')


    site = test_data.site
    title_of_test = step_data.title

    file_path = "test_library/private_eye/#{site}/#{title_of_test}/#{name}.png"
  end
end
#PrivateEye::Compare.new(ReportData.base[:report], Step.find_by_title('We load the kiosk start screen ?(.*)')).compare
