require 'spec_helper'

describe Book do

  describe 'search', vcr: {cassette_name: 'Book'} do

    let(:books) do 
      query = 'The Great Gatsby'
      Book.search(query) { GoogleBooks.search(query, { page: 1 }) }
    end

    it 'returns array' do
      books.should be_an(Array)
    end

    it "returnss count items" do
      books.size.should == 5
    end

    it "returns a title" do
      books.first.title.should == 'The Great Gatsby'
    end

    it "returns an authors" do
      books.first.authors.should == "F.Scott Fitzgerald"
    end

    it "returns image link" do
      image_link = "http://bks2.books.google.com/books?id=JgxOs2GX86AC&printsec=frontcover&img=1&zoom=1&edge=none&source=gbs_api"
      books.first.image_link.should == image_link
    end

    it "returns page count" do
      books.first.page_count.should == 154
    end
  end
end