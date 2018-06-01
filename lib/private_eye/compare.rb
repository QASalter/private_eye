require "image_size"
require "open3"
require "shellwords"

class PrivateEye::Compare
  attr_reader :test_data, :screen, :step_data, :title_of_test, :site, :name

  def initialize(test_data, step_data, name: nil)
    @test_data = test_data
    @step_data = step_data
    @screen = test_data.display_allocation.screen_id
    @title_of_test = step_data.title
    @site = test_data.site
    @name = name.prepend('(') << ')' unless name.nil?
  end

  def run
    screenshot
    compare
    passed?
  end

  def compare
    base = "test_library/private_eye/#{site}/#{title_of_test}/base#{name}.png"
    compare = "test_library/private_eye/#{site}/#{title_of_test}/compare#{name}.png"
    diff = base.gsub(/([a-zA-Z0-9]+).png$/, "diff.png#{name}")
    info = base.gsub(/([a-zA-Z0-9]+).png$/, "data.txt#{name}")
    compare_images(base, compare, diff, info)
  end

  def passed?
    outcome = File.read("test_library/private_eye/#{site}/#{title_of_test}/data.txt").to_f
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
    base_path = "test_library/private_eye/#{site}/#{title_of_test}/"

    if File.exist?(base_path + '/base.png')
      name = 'compare.png'
    else
      FileUtils.mkdir_p(base_path)
      name = 'base.png'
      puts 'No image found. Capturing base image now.'
    end

    base_path + name
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
