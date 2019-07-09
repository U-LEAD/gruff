require File.dirname(__FILE__) + '/base'

##
# Here's how to make a Speedometer graph:
#
#   g = Gruff::Speedometer.new
#   g.title = "Visual Speedometer Graph Test"
#   g.set_value(current_value, max_value, color, background_color)
#   g.write("test/output/speedometer_keynote.png")
#
# To control where the speedometer chart starts creating slices, use #zero_degree.

class Gruff::Speedometer < Gruff::Doughnut
  attr_reader :current_value
  attr_reader :max_value

  def initialize_ivars
    super

    @zero_degree = 180.0
  end

  def set_value(current_value, max_value, color, background_color)
    @current_value = current_value
    @max_value = max_value

    rest = max_value.zero? ? 1 : max_value - current_value

    data(:current, [current_value], color)
    data(:rest, [rest], background_color)
  end

  def slice_class
    SpeedometerSlice
  end

  def make_dougnut_hole
    @radius = @radius / 2.0
    @chart_degrees = zero_degree

    slice = PieSlice.new([nil, [1], '#FFFFFF '], {})
    slice.total = 1

    set_stroke_color(slice)
    set_fill_color
    set_stroke_width
    set_drawing_points_for(slice)
  end

  private

  class SpeedometerSlice < PieSlice
    def degrees
      @degrees ||= size * 180.0
    end
  end
end
