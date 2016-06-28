require 'rmagick'
require 'cucumber'
include Magick

##
#
# Main class of Glyptic Gifs
#

# = Setting up your project 
# 
# = Example
#
#   create_gif(sceanrio, './myproj/gifs', './myproj/pngs', @browser :watir)
class GlypticGifs
    @@scenario_index = 0

##
# This methods takes all of the png files from the parameter png_folder
# and stitches them together into a gif file abd saves it to the gif_location
#

    def create_gif(scenario, gif_location, png_folder, driver, driver_type)
        take_gif_frame(driver, driver_type, png_folder) if(scenario.failed?)
        # iOS takes 10 seconds to save an image.
        sleep 10
        dir_contents = Dir.glob("#{png_folder}/*.png").sort
        image_list = ImageList.new 
        img_index = 0
        num_of_images = dir_contents.size
        scenario_index = get_correct_scenario_index(scenario)
        scenario_array = scenario.feature.feature_elements[scenario_index.to_i].send(:raw_steps).to_a
        
        # Add the step description in red or green text to each image frame
        dir_contents.each do |file_name|
            step_name = scenario_array[img_index].name.to_s
            if (scenario.failed? && (num_of_images - 1 == img_index))
                add_text(file_name, "#{img_index+1}: #{step_name}", 'red')
            else
                add_text(file_name, "#{img_index+1}: #{step_name}", 'green')
            end
            image = Image.read("#{file_name}").first
            image_list << image
            img_index = img_index + 1
        end
        image_list.delay = 300 
        image_list.write(gif_location)
    end

##
# Takes a screenshot and saves it as a single frame for the gif
# in the png_folder location
#
    def take_gif_frame(driver, driver_type, png_folder)
        sleep 2
        @@scenario_index = 0 if @@scenario_index == nil
        screenshot_name = "%03d" % @@scenario_index
        screenshot_location = "#{png_folder}/#{screenshot_name}.png"
        if(driver_type == :watir)
            driver.screenshot.save screenshot_location
        elsif(driver_type == :appium)
            driver.screenshot(screenshot_location)
        end
        @@scenario_index = @@scenario_index + 1
    end

##
# Helper method to get the correct text to add to the png file
#
    def get_correct_scenario_index(scenario)
        expected_name = scenario.name
        number_of_sceanrios = scenario.feature.feature_elements.size
        found = false
        current_iteration = 0
        while(!found && number_of_sceanrios > current_iteration) do
            if expected_name == scenario.feature.feature_elements[current_iteration].name
                found = true
            else
                current_iteration = current_iteration + 1
            end
        end
        current_iteration
    end

##
# Adds given text to image
#
    def add_text(image_location, text, color)
        img = Magick::Image.read(image_location).first
        text_layer = Magick::Draw.new
        text_layer.font = 'Helvetica'
        text_layer.pointsize = 20
        text_layer.font_weight = 800
        text_layer.fill = 'black'
        text_layer.gravity = Magick::NorthWestGravity
        text_layer.annotate(img, 0, 0, 1, 0, text)
        text_layer.fill = color
        text_layer.annotate(img, 0, 0, 0, 0, text)
        img.write(image_location)
    end
end