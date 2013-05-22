require 'spec_helper'

describe BooksController, vcr: { cassette_name: 'Book' } do

  let(:query) { 'The Great Gatsby' }
  let(:page) { 5 }

  before(:each) { $redis.keys.each { |k| $redis.del k } }
    
  describe "GET index" do

    it "assigns all books as @books" do
      get :index, :query => query, :page => page
      assigns(:books).should be_an(Array)
    end

    it "calls GoogleBooks wraper library" do
      result = double.as_null_object
      GoogleBooks.should_receive(:search).with(query, {:page=>page}).and_return(result)
      get :index, :query => query, :page => page
    end
  end

  describe "performance", :performance => true do

    before { require 'benchmark' }

    it 'takes time' do
      count = 5000
      time = Benchmark.realtime {
        count.times { get :index, :query => query, :page => page }
      }
      puts "\n" + "-"*50
      puts "it took #{time} seconds to make #{count} requests"
      puts "-"*50
      time.should < 30
    end
  end
end


