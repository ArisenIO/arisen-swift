#
# Be sure to run `pod lib lint ArisenSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ArisenSwift'
  s.version          = '0.0.1'
  s.summary          = 'Arisen SDK for Swift - API for integrating with Arisen-based blockchains.'
  s.homepage         = 'https://github.com/ARISENIO/arisen-swift'
  s.license          = { :type => 'MIT', :text => <<-LICENSE
                           Copyright (c) 2017-2020 peepslabs and its contributors.  All rights reserved.
                         LICENSE
                       }
  s.author           = { 'Todd Bowden' => 'todd.bowden@peepslabs',
                         'Serguei Vinnitskii' => 'serguei.vinnitskii@peepslabs',
                         'Farid Rahmani' => 'farid.rahmani@peepslabs',
                         'Brandon Fancher' => 'brandon.fancher@peepslabs',
                         'Mark Johnson' => 'mark.johnson@peepslabs',
                         'Paul Kim' => 'paul.kim@peepslabs',
                         'Steve McCoole' => 'steve.mccoole@objectpartners.com',
                         'Ben Martell' => 'ben.martell@objectpartners.com' }

  s.source           = { :git => 'https://github.com/ARISENIO/arisen-swift.git', :tag => "v" + s.version.to_s }

  s.swift_version         = '5.0'
  s.ios.deployment_target = '11.0'

  s.source_files = 'ArisenSwift/**/*.swift'

  s.pod_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
						                'CLANG_ENABLE_MODULES' => 'YES',
						                'SWIFT_COMPILATION_MODE' => 'wholemodule',
						                'ENABLE_BITCODE' => 'YES' }

  s.ios.dependency 'BigInt', '~> 5.0'
  s.ios.dependency 'PromiseKit', '~> 6.8'
end