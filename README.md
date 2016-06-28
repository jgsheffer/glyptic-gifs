#Glyptic Gems - Cucumber Gem Generation

## Description

Glyptic Gems is meant to be used in conjunction with cucumber to help generate gifs of test runs which can be embeded into reports

Curretly watir-webdriver and appium are the only supported drivers.
:appium
:watir

Backgrounds and scenario outlines are not fully supported

## Creating Gifs
 
In your cucumber hooks file add the following
  AfterStep do |scenario|
    GlypticGifs.new.take_gif_frame(your_driver, :driver_type_symbol, png_collection_folder)\n
  end

  After do |scenario|
    GlypticGifs.new.create_gif(scenario, gif_location, png_location , @driver_holder.d, :appium)
  end


## Embdeding in Cucumber Reports
test
 AfterStep do |scenario|
   GlypticGifs.new.take_gif_frame(your_driver, :driver_type_symbol, png_collection_folder)\n
 end

 After do |scenario|
  timestamp = Time.now.to_s.gsub(/:/, '-')
  gif_location = Dir.pwd+"/"+ENV['FT_TARGET']+"/test-reports/screenshots/"+timestamp+'.gif'
  png_location = Dir.pwd+"/test-reports/screenshots/tmp"
  GlypticGifs.new.create_gif(scenario, gif_location, png_location , driver, :appium)
  gif_location = "./screenshots/"+timestamp+'.gif'
  if scenario.failed?
      puts "See gif for failure ::" + gif_location+'<br><a href="'+gif_location+'"><img width="200" src="'+gif_location+'"/></a>'
  else
      puts "See gif for success ::" + gif_location+'<br><a href="'+gif_location+'"><img width="200" src="'+gif_location+'"/></a>'
  end
 end
## Warranty

This software is provided "as is" and without any express or implied
warranties, including, without limitation, the implied warranties of
merchantability and fitness for a particular purpose.