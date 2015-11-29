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


