
class Exception
  def _add_backtrace(following_backtrace)
    @stored_backtrace += following_backtrace
  end
end

class Fiber
  alias_method :old_better_fiber_backtrace_add_backtrace_resume, :resume

  def resume
    begin
      self.old_better_fiber_backtrace_add_backtrace_resume
    rescue => e
      begin
        raise ""
      rescue => eb
        fiber_backtrace = eb.backtrace#[1..-1]
        e._add_backtrace(fiber_backtrace);
        raise e
      end
    end
  end
end


