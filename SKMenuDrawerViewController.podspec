Pod::Spec.new do |spec|
  spec.name = 'SKMenuDrawerViewController'
  spec.version = '0.0.4'
  spec.license = 'MIT'
  spec.summary = 'A simple side menu view controller.'
  spec.homepage = 'https://github.com/skladek/SKMenuDrawerViewController'
  spec.authors = { 'Sean Kladek' => 'skladek@gmail.com' }
  spec.source = { :git => 'https://github.com/skladek/SKMenuDrawerViewController.git', :tag => spec.version }
  spec.ios.deployment_target = '9.0'
  spec.source_files = 'Source/*.swift'
end
