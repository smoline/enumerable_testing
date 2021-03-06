require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'lib/de_enumerable'
require_relative 'lib/book'

require_relative 'your_code_here'

describe "Enumerable" do
  before(:all) do
    @war_and_peace = Book.new("War and Peace", 1869, "Leo Tolstoy", 1225)
    @h2g2          = Book.new("The Hitchhiker's Guide to the Galaxy", 1979, "Douglas Adams", 224)
    @moby_dick     = Book.new("Moby Dick", 1851, "Herman Melville", 927)
    @pride         = Book.new("Pride and Prejudice", 1813, "Jane Austen", 432)

    @books = [@war_and_peace, @h2g2, @moby_dick, @pride]
    de_enumerable(@books)

    @reimplements_enumerable = ReimplementEnumerable.new(@books)
  end

  it "implements all? correctly when results are true" do

    results = @reimplements_enumerable.all? { |book| book.year > 1800 }

    assert_equal true, results
  end

  it "implements all? correctly when the results are false" do

    results = @reimplements_enumerable.all? { |book| book.year == 1800 }

    assert_equal false, results
  end

  it "implements count correctly" do

    results = @reimplements_enumerable.count { |book| book.page_count > 300 }

    assert_equal 3, results
  end

  it "implements count correctly" do

    results = @reimplements_enumerable.count { |book| book.page_count == 1225 }

    assert_equal 1, results
  end

  it "implements count correctly" do

    results = @reimplements_enumerable.count { |book| book.page_count > 3000 }

    assert_equal 0, results
  end

  it "implements find correctly when there is a match" do

    results = @reimplements_enumerable.find { |book| book.year > 1970 }

    assert_equal @h2g2, results
  end

  it "implements find correctly when there is not a match" do

    results = @reimplements_enumerable.find { |book| book.year < 1492 }

    assert_nil results
  end

  it "implements each_with_index correctly" do

    object_results = []
    index_results = []

    @reimplements_enumerable.each_with_index do |book, index|
      object_results << book
      index_results  << index
    end

    assert_equal [@war_and_peace, @h2g2, @moby_dick, @pride], object_results
    assert_equal [0, 1, 2, 3], index_results
  end

  it "implements drop correctly" do

    assert_equal [@moby_dick, @pride], @reimplements_enumerable.drop(2)
  end

  it "implements drop_while correctly" do

    results = @reimplements_enumerable.drop_while { |book| book.year < 1900 }

    assert_equal [@h2g2, @moby_dick, @pride], results
  end

  it "implements find index correctly when there is a match" do

    results = @reimplements_enumerable.find_index { |book| book.year == 1851 }

    assert_equal 2, results
  end

  it "implements find index correctly when there is no match" do

    results = @reimplements_enumerable.find_index { |book| book.year == 2017 }

    assert_nil @reimplements_enumerable.find { |book| book.year == 2017 }
  end

  it "implements include? correctly when there is a match" do

    results = @reimplements_enumerable.include?(@war_and_peace)

    assert_equal true, results
  end

  it "implements include? correctly when there is no match" do

    not_in_list = Book.new("A Brief History of Time", 1988, "Stephen Hawking", 256)

    results = @reimplements_enumerable.include?(@not_in_list)

    assert_equal false, results
  end

  it "implements map correctly" do

    results = [1869, 1979, 1851, 1813]

    assert_equal results, @reimplements_enumerable.map { |book| book.year }
  end

  it "implements max_by correctly" do

    results = @h2g2

    assert_equal results, @reimplements_enumerable.max_by { |book| book.year }
  end

  it "implements min_by correctly" do

    results = @pride

    assert_equal results, @reimplements_enumerable.min_by { |book| book.year }
  end

  it "implements reject correctly" do

    short_books = [@h2g2, @pride]

    assert_equal short_books, @reimplements_enumerable.reject { |book| book.page_count > 500 }
  end

  it "implements reverse_each correctly based on yield" do

    # Look to see that reverse_each yields each element in reverse order
    reversed_array = []
    @reimplements_enumerable.reverse_each { |book| reversed_array << book }

    expected_books_array = [@pride, @moby_dick, @h2g2, @war_and_peace]
    assert_equal expected_books_array, reversed_array
  end

  it "implements reverse_each correctly based on the RETURN value" do

    expected_books_array = [@pride, @moby_dick, @h2g2, @war_and_peace]

    # See that reverse_each returns the array reversed
    what_does_reverse_each_return = @reimplements_enumerable.reverse_each { |book| book }

    assert_equal expected_books_array, what_does_reverse_each_return
  end

  it "implements partition correctly" do

    results = [[@war_and_peace, @h2g2], [@moby_dick, @pride]]

    assert_equal results, @reimplements_enumerable.partition { |book| book.year > 1860 }
  end

  it "implements one? correctly when true" do

    assert_equal true, @reimplements_enumerable.one? { |book| book.page_count == 1225 }
  end

  it "implements one? correctly when false" do

    assert_equal false, @reimplements_enumerable.one? { |book| book.year == 1900 }
  end

  it "implements none? correctly when false" do

    assert_equal false, @reimplements_enumerable.none? { |book| book.page_count == 1225 }
  end

  it "implements none? correctly when true" do

    assert_equal true, @reimplements_enumerable.none? { |book| book.year == 1900 }
  end

  it "implements each_slice correctly" do
    skip
    results = [@war_and_peace, @h2g2] [@moby_dick, @pride]

    assert_equal results, @reimplements_enumerable.each_slice(2) { |book| p book }
  end
  # slice_before
end
