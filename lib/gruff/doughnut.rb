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

  def draw
    hide_line_markers

    unless data_given?
      draw_no_data
      return
    end

    setup_data
    setup_drawing

    draw_legend
    draw_line_markers
    draw_axis_labels
    draw_title

    slices.each do |slice|
      next if slice.value == 0

      Gruff::Renderer::Ellipse.new(color: slice.color, width: radius/2.0)
                              .render(center_x, center_y, radius / 1.25, radius / 1.25, chart_degrees, chart_degrees + slice.degrees + 0.5)
      process_label_for slice
      update_chart_degrees_with slice.degrees
    end

    yield if block_given?
  end

end
