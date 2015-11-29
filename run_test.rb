#!/usr/bin/env ruby
#
# mrbgems test runner
#
# Copyright (c) 2014 Internet Initiative Japan Inc.
# from https://github.com/iij/mruby-iijson/blob/7be4b2017d9db8c697f72b39a6afb7fddceec434/run_test.rb
#

if __FILE__ == $0
  repository, dir = 'https://github.com/mruby/mruby.git', 'tmp/mruby'
  build_args = ARGV

  if ARGV[0] == "example"
    system("tmp/mruby/bin/mruby sample.rb")
    exit
  end

  Dir.mkdir 'tmp'  unless File.exist?('tmp')
  unless File.exist?(dir)
    system "git clone #{repository} #{dir}"
  end

  if ARGV[0] == "example_without_this"
    Dir.chdir dir
    build_args = []
    system(
      "ruby minirake #{build_args.join(' ')}"
    )
    system("bin/mruby ../../sample.rb")
  else
    Dir.chdir dir
    system(
      { "MRUBY_CONFIG" => "../../#{File.basename(__FILE__)}" },
      "ruby minirake #{build_args.join(' ')}"
    )
  end

  exit
end

MRuby::Build.new do |conf|
  if ENV['VisualStudioVersion'] || ENV['VSINSTALLDIR']
    toolchain :visualcpp
  else
    toolchain :gcc
  end
  enable_debug
  conf.enable_bintest
  conf.enable_test
  conf.gembox 'default'

  conf.gem :github => 'dycoon/mruby-ruby-like-backtrace'
  #conf.gem File.expand_path(File.dirname(__FILE__))
end
