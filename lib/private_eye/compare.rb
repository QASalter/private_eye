require "image_size"
require "open3"
require "shellwords"

class PrivateEye::Compare
  attr_reader :test_data, :screen, :step_data, :title_of_test, :site, :name

  def initialize(test_data, step_data, name = nil)
    @test_data = test_data
    @step_data = step_data
    @screen = test_data.display_allocation.screen_id
    @title_of_test = step_data.title
    @site = test_data.site
    @name = name unless name.nil?
  end

  def run
    screenshot
    compare
    save_to_report
    passed?
  end

  def compare
    base = "public/screenshots/private_eye/#{site}/#{title_of_test}/base#{name}.png"
    compare = "public/screenshots/private_eye/#{site}/#{title_of_test}/compare#{name}.png"
    diff = base.gsub(/([a-zA-Z0-9]+).png$/, "diff#{name}.png")
    info = base.gsub(/([a-zA-Z0-9]+).png$/, "data#{name}.txt")
    compare_images(base, compare, diff, info)
  end

  def save_to_report
    path = "public/screenshots/#{test_data.id}/#{test_data.current_test}/private_eye/"
    FileUtils.mkdir_p(path)
    copy_from = "public/screenshots/private_eye/#{site}/#{title_of_test}/"
    FileUtils.cp_r(copy_from, path)
  end

  def passed?
    outcome = File.read("public/private_eye/#{site}/#{title_of_test}/data#{name}.txt").to_f
    if outcome < 5
      puts 'Images within tolerance'
      true
    elsif outcome > 5
      puts 'Images outside tolerance'
      false
    else
      puts 'Images invalid'
      false
    end
  end

  def screenshot
    `DISPLAY=:#{screen} import -window root "#{file_path}"`
  end

  def file_path
    base_path = "public/screenshots/private_eye/#{site}/#{title_of_test}/"
    if File.exist?(base_path + "/base#{name}.png")
      file_name = "compare#{name}.png"
    else
      FileUtils.mkdir_p(base_path)
      file_name = "base#{name}.png"
      puts 'No image found. Capturing base image now.'
    end

    base_path + file_name
  end

  def calculate_percentage(img_size, px_value, info)
    pixel_count = (px_value / img_size) * 100
    rounded = pixel_count.round(2)
    File.open(info, 'w') { |file| file.write(rounded) }
  end

  def compare_images(base, compare, output, info)
    cmdline = "compare -dissimilarity-threshold 1 -fuzz 20% -metric AE -highlight-color red #{base.shellescape} #{compare.shellescape} #{output.shellescape}"
    px_value = Open3.popen3(cmdline) { |_stdin, _stdout, stderr, _wait_thr| stderr.read }.to_f
    begin
      img_size = ImageSize.path(output).size.inject(:*)
      calculate_percentage(img_size, px_value, info)
    rescue
      File.open(info, 'w') { |file| file.write('invalid') } unless File.exist?(output)
    end
  end
end
