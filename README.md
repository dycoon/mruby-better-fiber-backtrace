# mruby-better-fiber-backtrace

```
def f
  begin
    fb = Fiber.new do
      Fiber.yield
      raise "ttt"
    end
    fb.resume
    fb.resume
  rescue => e
    raise e
  end
end

begin
  f
rescue => e
  puts "e.backtrace"
  puts "#{e.backtrace.map{|v| "  " + v}.join("\n")}"
end

```

This code outputs followin on mruby.

```
e.backtrace
  ../../sample.rb:18

```

Pointing call of backtrace...

use [mruby-ruby-like-backtrace](https://github.com/dycoon/mruby-ruby-like-backtrace)

```
e.backtrace
  /work/small_repos/mruby-better-fiber-backtrace/tmp/mruby/build/mrbgems/mruby-ruby-like-backtrace/mrblib/ruby_like_backtrace.rb:19:in Exception.initialize
  sample.rb:5
```

It does not show where resume is called.

useing this mrbgems, get following.

```
e.backtrace
  /work/small_repos/mruby-better-fiber-backtrace/tmp/mruby/build/mrbgems/mruby-ruby-like-backtrace/mrblib/ruby_like_backtrace.rb:19:in Exception.initialize
  sample.rb:5
  /work/small_repos/mruby-better-fiber-backtrace/tmp/mruby/build/mrbgems/mruby-ruby-like-backtrace/mrblib/ruby_like_backtrace.rb:19:in Exception.initialize
  /work/small_repos/mruby-better-fiber-backtrace/mrblib/better_fiber_backtrace.rb:16:in Fiber.resume
  sample.rb:8:in Object.f
  sample.rb:15
```

It shows where resume is called.
