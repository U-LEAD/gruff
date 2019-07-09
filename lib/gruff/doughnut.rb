require File.dirname(__FILE__) + '/base'

##
# Here's how to make a Doughnut graph:
#
#   g = Gruff::Doughnut.new
#   g.title = "Visual Doughnut Graph Test"
#   g.data 'Fries', 20
#   g.data 'Hamburgers', 50
#   g.write("test/output/doughnut_keynote.png")
#
# To control where the doughnut chart starts creating slices, use #zero_degree.

class Gruff::Doughnut < Gruff::Pie
  private

  def draw
    super do
      make_dougnut_hole

      yield if block_given?
    end
  end

  def make_dougnut_hole
    @radius = @radius / 2.0
    @chart_degrees = zero_degree

    slice = slice_class.new([nil, [1], '#FFFFFF '], {})
    slice.total = 1

    set_stroke_color(slice)
    set_fill_color
    set_stroke_width
    set_drawing_points_for(slice)
  end
end
