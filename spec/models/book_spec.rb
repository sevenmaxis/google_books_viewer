require 'spec_helper'

describe Book do

  describe 'search', vcr: {cassette_name: 'Book'} do

    let(:query) { 'The Great Gatsby' }

    before(:each) do
      Rails.cache.clear
      @books, @total_count = Book.search(query) do 
        GoogleBooks.search(query, { page: 1 })
      end
    end

    it 'returns array' do
      @books.should be_an(Array)
    end

    it "returns total count" do
      @total_count.should == 523
    end

    it "returns count items" do
      @books.size.should == 5
    end

    it "returns a title" do
      @books.first.title.should == 'The Great Gatsby'
    end

    it "returns an authors" do
      @books.first.authors.should == "F.Scott Fitzgerald"
    end

    it "returns image link" do
      image_link = "http://bks2.books.google.com/books?id=JgxOs2GX86AC&printsec=frontcover&img=1&zoom=1&edge=none&source=gbs_api"
      @books.first.image_link.should == image_link
    end

    it "returns page count" do
      @books.first.page_count.should == 154
    end

    it "should use cache" do
      GoogleBooks.should_not_receive(:search)
      Book.search(query)
    end
  end
end