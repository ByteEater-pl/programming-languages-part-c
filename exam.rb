# This programme demonstrates that in Dan Grossman's (University of Washington) MOOC "Programming Languages, Part C" at Coursera (https://www.coursera.org/learn/programming-languages-part-c) the "Actual Final Exam" has a question to which two answers are correct despite there being supposed to be just one.

# code from question 11 (referenced in the next one)
class A
  def initialize a
    @arr = a
  end
  def get i
    @arr[i]
  end
  def sum
    @arr.inject(0) {|acc,x| acc + x}
  end
end

class B < A
  def initialize a
    super
    @ans = false
  end
  def sum
    if !@ans
      @ans = @arr.inject(0) {|acc,x| acc + x}
    end
    @ans
  end
end

# Question 12: "This problem uses the code in the previous problem.  Class A and class B are not equivalent.  In particular, there are ways to fill in the ... in the code below so that s3\verb|s3|s3 and s4\verb|s4|s4 hold different numbers.  Which change would make the two classes equivalent?"
# Possible answers (exactly one to be selected):
# TBD (It says "Correct" in "View Feedback", but the answers aren't shown. To see them again I have to wait 22 hours, only then can I "retake" the exam.)
v = [4,19,74]
a = A.new v
b = B.new v
s1 = a.sum
s2 = b.sum
# here was "..."
# My first thought was that different results could be obtained by redefining `inject` in `Enumerable` (or `Array`, that's a later thought). I gave that answer (TBD) without testing (which is allowed) and got 96% – this was the only answer marked wrong, worth 4 points of 100.
Array.define_method(:inject) { |_| 0 }
# So, I decided to test it before submitting my next attempt (after waiting at least the required 22 hours). And sure enough, it works. I thought which of the other answers was deemed correct instead by the author (probably Dan Grossman himself). I figured it was TBD and I was correct, as commenting the line above and uncommenting below can show.
#v << 1
# There's a nit that the course uses really old Ruby. It's not specified for the exam, but the two earlier programming assignments present a choice to submit a solution in Ruby 2.0, 2.1, 2.2 or 2.3. In those versions `define_method` was private. However, unlike in languages which IMO do the right thing, privacy in Ruby isn't a hard guarantee and can be easily defeated with `send`, thus:
#Array.send(:define_method, :inject) { |_| 0 }
s3 = a.sum
s4 = b.sum
p [s3, s4] # added by me for debugging
