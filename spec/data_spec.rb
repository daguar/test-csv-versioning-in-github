require 'spec_helper'
require 'csv'

RSpec.describe "The data" do
  let(:path_to_data) { File.expand_path("../../data.csv", __FILE__) }

  let(:required_column_order) do
    path_to_column_order_file = File.expand_path("../columns.csv", __FILE__)
    raw_file_data = File.open(path_to_column_order_file, &:readline)
    CSV.parse_line(raw_file_data)
  end

  let(:column_that_rows_should_be_ordered_by) do
    path_to_column_order_file = File.expand_path("../order_by_column_name.csv", __FILE__)
    raw_file_data = File.open(path_to_column_order_file, &:readline)
    CSV.parse_line(raw_file_data)[0]
  end

  it "has column headers in the correct order" do
    raw_file_data = File.open(path_to_data, &:readline)
    data_column_order = CSV.parse_line(raw_file_data)
    expect(data_column_order).to eq(required_column_order)
  end

  it "has rows ordered by the correct column" do
    column_sym = column_that_rows_should_be_ordered_by.to_sym
    data = CSV.table(path_to_data)
    current_order_of_the_data = data.map { |row| row[column_sym] }
    expect(current_order_of_the_data).to eq(current_order_of_the_data.sort)
  end
end
