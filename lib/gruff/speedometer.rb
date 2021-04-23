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

class Gruff::Speedometer < Gruff::Pie
  LABELS_MARGIN = 20.0

  attr_reader :current_value
  attr_reader :max_value

  def set_value(current_value, max_value, color, background_color)
    @current_value = current_value
    @max_value = max_value

    rest = max_value.zero? ? 1 : max_value - current_value

    data(:current, [current_value], color)
    data(:rest, [rest], background_color)
  end


  def draw
    hide_line_markers

    if @max_value.nil?
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

      Gruff::Renderer::Ellipse.new(color: slice.color, width: radius/1.5)
                              .render(center_x, center_y, radius*2.0, radius*2.0, chart_degrees, chart_degrees + slice.degrees + 0.5)
      update_chart_degrees_with slice.degrees
    end
    draw_label(center_x-radius*2, center_y+LABELS_MARGIN, '0')
    draw_label(center_x+radius*2, center_y+LABELS_MARGIN, @max_value.to_s)

    old_size = @marker_font_size
    @marker_font_size = @marker_font_size*2
    draw_label(center_x, center_y-radius/2.0, @current_value.nil? ? 'N/A' : @current_value.to_s)
    @marker_font_size = old_size
    yield if block_given?
  end

  private

  def initialize_ivars
    super
    @zero_degree = 180.0
  end

  def slices
    @slices ||= begin
      slices = store.data.select{|d| ['current', 'rest'].include?(d.label)}.map do |data|
        SpeedoSlice.new(data, options)
      end

      total = slices.sum(&:value).to_f
      slices.each { |slice| slice.total = total }
    end
  end

  def center_y
    @center_y ||= @graph_top + graph_height - LABELS_MARGIN
  end

  class SpeedoSlice < PieSlice
    def degrees
      @degrees ||= size * 180.0
    end
  end



end
