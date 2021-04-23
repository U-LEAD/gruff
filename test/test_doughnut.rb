# frozen_string_literal: true

require_relative 'gruff_test_case'

class TestGruffDoughnut < GruffTestCase
  def setup
    @datasets = [
      [:Darren, [25]],
      [:Chris, [80]],
      [:Egbert, [22]],
      [:Adam, [95]],
      [:Bill, [90]],
      ['Frank', [5]],
      ['Zero', [0]]
    ]
  end

  def test_doughnut_graph
    g = Gruff::Doughnut.new
    g.title = 'Visual Doughnut Graph Test'
    @datasets.each do |data|
      g.data(data[0], data[1])
    end

    # Default theme
    g.write('test/output/doughnut_keynote.png')
    assert_same_image('test/expected/doughnut_keynote.png', 'test/output/doughnut_keynote.png')
  end

  def test_doughnut_graph_greyscale
    g = Gruff::Doughnut.new
    g.title = 'Greyscale Doughnut Graph Test'
    g.theme = Gruff::Themes::GREYSCALE
    @datasets.each do |data|
      g.data(data[0], data[1])
    end

    # Default theme
    g.write('test/output/doughnut_grey.png')
    assert_same_image('test/expected/doughnut_grey.png', 'test/output/doughnut_grey.png')
  end

  def test_doughnut_graph_pastel
    g = Gruff::Doughnut.new
    g.theme = Gruff::Themes::PASTEL
    g.title = 'Pastel Doughnut Graph Test'
    @datasets.each do |data|
      g.data(data[0], data[1])
    end

    # Default theme
    g.write('test/output/doughnut_pastel.png')
    assert_same_image('test/expected/doughnut_pastel.png', 'test/output/doughnut_pastel.png')
  end

  def test_doughnut_graph_small
    g = Gruff::Doughnut.new(400)
    g.title = 'Visual Doughnut Graph Test Small'
    @datasets.each do |data|
      g.data(data[0], data[1])
    end

    # Default theme
    g.write('test/output/doughnut_keynote_small.png')
    assert_same_image('test/expected/doughnut_keynote_small.png', 'test/output/doughnut_keynote_small.png')
  end

  def test_doughnut_graph_nearly_equal
    g = Gruff::Doughnut.new
    g.title = 'Doughnut Graph Nearly Equal'

    g.data(:Blake, [41])
    g.data(:Aaron, [42])

    g.write('test/output/doughnut_nearly_equal.png')
    assert_same_image('test/expected/doughnut_nearly_equal.png', 'test/output/doughnut_nearly_equal.png')
  end

  def test_doughnut_graph_equal
    g = Gruff::Doughnut.new
    g.title = 'Doughnut Graph Equal'

    g.data(:Bert, [41])
    g.data(:Adam, [41])

    g.write('test/output/doughnut_equal.png')
    assert_same_image('test/expected/doughnut_equal.png', 'test/output/doughnut_equal.png')
  end

  def test_doughnut_graph_zero
    g = Gruff::Doughnut.new
    g.title = 'Doughnut Graph One Zero'

    g.data(:Bert, [0])
    g.data(:Adam, [1])

    g.write('test/output/doughnut_zero.png')
    assert_same_image('test/expected/doughnut_zero.png', 'test/output/doughnut_zero.png')
  end

  def test_doughnut_graph_one_val
    g = Gruff::Doughnut.new
    g.title = 'Doughnut Graph One Val'

    g.data(:Bert, 53)
    g.data(:Adam, 29)

    g.write('test/output/doughnut_one_val.png')
    assert_same_image('test/expected/doughnut_one_val.png', 'test/output/doughnut_one_val.png')
  end

  def test_no_data
    g = Gruff::Doughnut.new
    g.title = 'No Data'
    # Default theme
    g.write('test/output/doughnut_no_data.png')
    assert_same_image('test/expected/doughnut_no_data.png', 'test/output/doughnut_no_data.png')

    g = Gruff::Doughnut.new
    g.title = 'No Data Title'
    g.no_data_message = 'There is no data'
    g.write('test/output/doughnut_no_data_msg.png')
    assert_same_image('test/expected/doughnut_no_data_msg.png', 'test/output/doughnut_no_data_msg.png')

    g = Gruff::Doughnut.new
    g.data 'A', []
    g.data 'B', []
    g.write('test/output/doughnut_no_data_with_empty.png')
    assert_same_image('test/expected/doughnut_no_data_with_empty.png', 'test/output/doughnut_no_data_with_empty.png')
  end

  def test_wide
    g = setup_basic_graph('800x400')
    g.title = 'Wide Doughnut'
    g.write('test/output/doughnut_wide.png')
    assert_same_image('test/expected/doughnut_wide.png', 'test/output/doughnut_wide.png')
  end

  def test_label_size
    g = setup_basic_graph
    g.title = 'Doughnut With Small Legend'
    g.legend_font_size = 10
    g.write('test/output/doughnut_legend.png')
    assert_same_image('test/expected/doughnut_legend.png', 'test/output/doughnut_legend.png')

    g = setup_basic_graph(400)
    g.title = 'Small Doughnut With Small Legend'
    g.legend_font_size = 10
    g.write('test/output/doughnut_legend_small.png')
    assert_same_image('test/expected/doughnut_legend_small.png', 'test/output/doughnut_legend_small.png')
  end

  def test_tiny_simple_doughnut
    r = Random.new(297427)
    @datasets = (1..5).map { ['Auto', [r.rand(100)]] }

    g = setup_basic_graph 200
    g.hide_legend = true
    g.hide_title = true
    g.hide_line_numbers = true

    g.marker_font_size = 40.0
    g.minimum_value = 0.0

    write_test_file(g, 'doughnut_simple.png')
    assert_same_image('test/expected/doughnut_simple.png', 'test/output/doughnut_simple.png')
  end

  def test_doughnut_with_adjusted_text_offset_percentage
    g = setup_basic_graph
    g.title = 'Adjusted Text Offset Percentage'
    g.text_offset_percentage = 0.03
    g.write('test/output/doughnut_adjusted_text_offset_percentage.png')
    assert_same_image('test/expected/doughnut_adjusted_text_offset_percentage.png', 'test/output/doughnut_adjusted_text_offset_percentage.png')
  end

  def test_subclassed_doughnut_with_custom_labels
    CustomLabeledDoughnut.new(800).tap do |graph|
      graph.title = 'Subclassed Doughnut with Custom Lables'

      @datasets.map { |set| set << set.join(': ') }.each do |data|
        graph.data(data[0], data[1], label: data[2])
      end

      graph.write('test/output/doughnut_subclass_custom_labels.png')
      assert_same_image('test/expected/doughnut_subclass_custom_labels.png', 'test/output/doughnut_subclass_custom_labels.png')
    end
  end

protected

  def setup_basic_graph(size = 800)
    g = Gruff::Doughnut.new(size)
    g.title = 'My Graph Title'
    @datasets.each do |data|
      g.data(data[0], data[1])
    end

    g
  end

  # Example Gruff::Doughnut Subclass demonstrating custom labels
  class CustomLabeledDoughnut < Gruff::Doughnut
    def data(name, data_points = [], options = {})
      store.add(name, data_points, options[:color], options[:label])
    end

  private

    def slice_class
      CustomLabeledSlice
    end

    class CustomLabeledSlice < ::Gruff::Doughnut::PieSlice
      def label
        data_array.custom || super
      end
    end
  end
end
