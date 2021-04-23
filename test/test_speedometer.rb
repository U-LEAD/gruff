# frozen_string_literal: true

require_relative 'gruff_test_case'

class TestGruffSpeedometer < GruffTestCase
  def setup
  end

  def test_speedometer_graph
    g = Gruff::Speedometer.new
    g.title = 'Visual Speedometer Graph Test'
    g.set_value(7, 12, '#4FBDDD', '#BDC4CC')

    # Default theme
    g.write('test/output/speedometer_keynote.png')
    assert_same_image('test/expected/speedometer_keynote.png', 'test/output/speedometer_keynote.png')
  end

  def test_speedometer_graph_greyscale
    g = Gruff::Speedometer.new
    g.title = 'Greyscale Speedometer Graph Test'
    g.theme = Gruff::Themes::GREYSCALE
    g.set_value(7, 12, '#4FBDDD', '#BDC4CC')

    # Default theme
    g.write('test/output/speedometer_grey.png')
    assert_same_image('test/expected/speedometer_grey.png', 'test/output/speedometer_grey.png')
  end

  def test_speedometer_graph_pastel
    g = Gruff::Speedometer.new
    g.theme = Gruff::Themes::PASTEL
    g.title = 'Pastel Speedometer Graph Test'
    g.set_value(7, 12, '#4FBDDD', '#BDC4CC')

    # Default theme
    g.write('test/output/speedometer_pastel.png')
    assert_same_image('test/expected/speedometer_pastel.png', 'test/output/speedometer_pastel.png')
  end

  def test_speedometer_graph_small
    g = Gruff::Speedometer.new(400)
    g.title = 'Visual Speedometer Graph Test Small'
    g.set_value(7, 12, '#4FBDDD', '#BDC4CC')

    # Default theme
    g.write('test/output/speedometer_keynote_small.png')
    assert_same_image('test/expected/speedometer_keynote_small.png', 'test/output/speedometer_keynote_small.png')
  end

  def test_speedometer_graph_nearly_equal
    g = Gruff::Speedometer.new
    g.title = 'Speedometer Graph Nearly Equal'
    g.set_value(7, 12, '#4FBDDD', '#BDC4CC')

    g.write('test/output/speedometer_nearly_equal.png')
    assert_same_image('test/expected/speedometer_nearly_equal.png', 'test/output/speedometer_nearly_equal.png')
  end

  def test_speedometer_graph_equal
    g = Gruff::Speedometer.new
    g.title = 'Speedometer Graph Equal'
    g.set_value(7, 12, '#4FBDDD', '#BDC4CC')

    g.write('test/output/speedometer_equal.png')
    assert_same_image('test/expected/speedometer_equal.png', 'test/output/speedometer_equal.png')
  end

  def test_speedometer_graph_zero
    g = Gruff::Speedometer.new
    g.title = 'Speedometer Graph One Zero'
    g.set_value(7, 12, '#4FBDDD', '#BDC4CC')

    g.write('test/output/speedometer_zero.png')
    assert_same_image('test/expected/speedometer_zero.png', 'test/output/speedometer_zero.png')
  end

  def test_speedometer_graph_one_val
    g = Gruff::Speedometer.new
    g.title = 'Speedometer Graph One Val'
    g.set_value(7, 12, '#4FBDDD', '#BDC4CC')

    g.write('test/output/speedometer_one_val.png')
    assert_same_image('test/expected/speedometer_one_val.png', 'test/output/speedometer_one_val.png')
  end

  def test_no_data
    g = Gruff::Speedometer.new
    g.title = 'No Data'
    # Default theme
    g.write('test/output/speedometer_no_data.png')
    assert_same_image('test/expected/speedometer_no_data.png', 'test/output/speedometer_no_data.png')

    g = Gruff::Speedometer.new
    g.title = 'No Data Title'
    g.no_data_message = 'There is no data'
    g.write('test/output/speedometer_no_data_msg.png')
    assert_same_image('test/expected/speedometer_no_data_msg.png', 'test/output/speedometer_no_data_msg.png')

    g = Gruff::Speedometer.new
    g.data 'A', []
    g.data 'B', []
    g.write('test/output/speedometer_no_data_with_empty.png')
    assert_same_image('test/expected/speedometer_no_data_with_empty.png', 'test/output/speedometer_no_data_with_empty.png')
  end

  def test_wide
    g = setup_basic_graph('800x400')
    g.title = 'Wide Speedometer'
    g.write('test/output/speedometer_wide.png')
    g.set_value(7, 12, '#4FBDDD', '#BDC4CC')
    assert_same_image('test/expected/speedometer_wide.png', 'test/output/speedometer_wide.png')
  end

  def test_label_size
    g = setup_basic_graph
    g.title = 'Speedometer With Small Legend'
    g.legend_font_size = 10
    g.write('test/output/speedometer_legend.png')
    assert_same_image('test/expected/speedometer_legend.png', 'test/output/speedometer_legend.png')

    g = setup_basic_graph(400)
    g.title = 'Small Speedometer With Small Legend'
    g.legend_font_size = 10
    g.write('test/output/speedometer_legend_small.png')
    assert_same_image('test/expected/speedometer_legend_small.png', 'test/output/speedometer_legend_small.png')
  end

  def test_tiny_simple_speedometer
    r = Random.new(297427)
    g = setup_basic_graph 200
    g.hide_legend = true
    g.hide_title = true
    g.hide_line_numbers = true

    g.marker_font_size = 40.0
    g.minimum_value = 0.0
    g.set_value(7, 12, '#4FBDDD', '#BDC4CC')

    write_test_file(g, 'speedometer_simple.png')
    assert_same_image('test/expected/speedometer_simple.png', 'test/output/speedometer_simple.png')
  end

  def test_speedometer_with_adjusted_text_offset_percentage
    g = setup_basic_graph
    g.title = 'Adjusted Text Offset Percentage'
    g.text_offset_percentage = 0.03
    g.write('test/output/speedometer_adjusted_text_offset_percentage.png')
    assert_same_image('test/expected/speedometer_adjusted_text_offset_percentage.png', 'test/output/speedometer_adjusted_text_offset_percentage.png')
  end

  def test_subclassed_speedometer_with_custom_labels
    CustomLabeledSpeedometer.new(800).tap do |graph|
      graph.title = 'Subclassed Speedometer with Custom Lables'

      @datasets.map { |set| set << set.join(': ') }.each do |data|
        graph.data(data[0], data[1], label: data[2])
      end
      graph.set_value(7, 12, '#4FBDDD', '#BDC4CC')

      graph.write('test/output/speedometer_subclass_custom_labels.png')
      assert_same_image('test/expected/speedometer_subclass_custom_labels.png', 'test/output/speedometer_subclass_custom_labels.png')
    end
  end

protected

  def setup_basic_graph(size = 800)
    g = Gruff::Speedometer.new(size)
    g.title = 'My Graph Title'
    g.set_value(7, 12, '#4FBDDD', '#BDC4CC')
    g
  end

  # Example Gruff::Speedometer Subclass demonstrating custom labels
  class CustomLabeledSpeedometer < Gruff::Speedometer
    def data(name, data_points = [], options = {})
      store.add(name, data_points, options[:color], options[:label])
    end

  private

    def slice_class
      CustomLabeledSlice
    end

    class CustomLabeledSlice < ::Gruff::Speedometer::PieSlice
      def label
        data_array.custom || super
      end
    end
  end
end
