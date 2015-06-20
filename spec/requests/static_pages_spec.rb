require 'spec_helper'

describe "StaticPages" do
  
  describe "Home page" do
    before { visit root_path }
    it "have h1" do
      expect(page).to have_selector('h1',text: 'Book DemoApp')
    end
    it "have title " do
      expect(page).to have_selector('title', text: 'Book DemoApp')
    end
  end

end
