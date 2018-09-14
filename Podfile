platform :ios, '9.0'

use_frameworks!
inhibit_all_warnings!

target 'SKMenuDrawerViewController' do
	project 'SKMenuDrawerViewController.xcodeproj'
	pod 'SwiftLint', '= 0.23.1'
end

target 'SKMenuDrawerViewControllerTests' do
	workspace 'SKMenuDrawerViewController.xcworkspace'
	project 'SKMenuDrawerViewController.xcodeproj'
	pod 'Nimble', '= 7.3.0'
	pod 'Quick', '= 1.3.1'
end

target 'SampleApp' do
	project 'SampleApp/SampleApp.xcodeproj'
	pod 'SKTableViewDataSource', '= 2.0.0'
end