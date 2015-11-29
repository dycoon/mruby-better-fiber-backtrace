
def f_func
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

assert('mruby-better-fiber-backtrace') do

  begin
    f_func
  rescue => e
    backtrace = e.backtrace.join("\n")
    assert_true(backtrace.include?("f_func"))
  end

end
