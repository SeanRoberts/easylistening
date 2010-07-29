class Fixnum
  def to_mm_ss
    minutes, seconds = self / 60, self % 60
    seconds = "0" + seconds.to_s if seconds < 10
    return "#{minutes}:#{seconds}"
  end
end