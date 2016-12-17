#Glyptic Gems - Cucumber Gem Generation

## Description

Glyptic Gems is meant to be used in conjunction with cucumber to help generate gifs of test runs which can be embeded into reports

Curretly watir-webdriver and appium are the only supported drivers.
:appium
:watir

Backgrounds and scenario outlines are not fully supported

## Setup

Glyptic gifs requires rmagick which requires native imagemagic libraries.
Instructions to set this up on windows can be found at:

http://www.redmine.org/projects/redmine/wiki/HowTo_install_rmagick_gem_on_Windows

* Note: Be sure image magic is in your path.  If you continue to have issues installing rmagick then put the imagemagick folder in your ruby bin directory.

## Creating Gifs
 
In your cucumber hooks file add the following
```ruby
  AfterStep do |scenario|
    GlypticGifs.new.take_gif_frame(your_driver, :driver_type_symbol, png_collection_folder)\n
  end

  After do |scenario|
    GlypticGifs.new.create_gif(scenario, gif_location, png_location , @driver_holder.d, :appium)
  end
```

## Embdeding in Cucumber Reports
```ruby
 AfterStep do |scenario|
   GlypticGifs.new.take_gif_frame(your_driver, :driver_type_symbol, png_collection_folder)\n
 end
```
```ruby
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
 ```
## Warranty

This software is provided "as is" and without any express or implied
warranties, including, without limitation, the implied warranties of
merchantability and fitness for a particular purpose.