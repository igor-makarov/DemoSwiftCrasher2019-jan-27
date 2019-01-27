require 'yaml'

project.name = 'DemoCrasher2019-jan-27'

project.all_configurations.each do |configuration|
  configuration.settings['SWIFT_VERSION'] = '5'
end

application_for :ios, '10.0' do |target|
  target.name = 'DemoCrasher2019-jan-27'
  target.all_configurations.each do |config|
    config.product_bundle_identifier = 'com.igor.democrasher2019-jan-27'
  end

  unit_tests_for target
end

project.after_save do
  system "rm -rf \"#{project.name}.xcodeproj/xcshareddata/xcschemes\""
end
