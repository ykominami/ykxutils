require 'rubyXL'

module Ykxutils
  class Xlsx
    def initialize( input_file: nil, output_file: nil )
      @input_file = input_file
      @output_file = output_file
    end

    def create_workbook
      @workbook = RubyXL::Workbook.new
    end

    def create_worksheet
      @worksheet = @workbook.worksheets[0] # Returns first worksheet
    end

    def array_to_xlsx( array )
      create_workbook
      create_worksheet

      array.each_with_index do |row, row_index|
        row.each_with_index do |col, col_index|
          @worksheet.add_cell(row_index, col_index, array[row_index][col_index])
        end
      end
      @workbook.write(@output_file)
    end

    def test_output
      workbook = RubyXL::Workbook.new
      worksheet = workbook.worksheets[0] # Returns first worksheet
      0.upto(10).each do |y|
        0.upto(10).each do |x|
          worksheet.add_cell(y, x, y * x) 
          # cell = worksheet[y][x]
          # cell.value = x * y
        end
      end
      workbook.write(@output_file)
    end
  end
end