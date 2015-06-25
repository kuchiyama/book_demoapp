# -*- coding: utf-8 -*-
# == Schema Information
#
# Table name: books
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  isbn       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Book do
  before { @book= Book.new(title: "本をめぐる物語 一冊の扉",isbn: "9784041012581")}
  it "have attribute" do
    expect(@book).to respond_to(:title)
    expect(@book).to respond_to(:isbn)
  end
  it{ expect(@book).to be_valid }
  describe "when title is not present" do
    before{ @book.title=""}
    it{ expect(@book).not_to be_valid }
  end
  describe "when isbn is not present" do
    before { @book.isbn=""}
    it{ expect(@book).to be_valid }
  end
  describe "when title is too long" do
    before { @book.title = "a" * 141 }
    it{ expect(@book).not_to be_valid }
  end
  describe "when isbn is too long" do
    before { @book.isbn = "1" * 14}
    it{ expect(@book).not_to be_valid }
  end
  describe "when isbn is wrong" do
    before { @book.isbn[-1]="9"}
    it{ expect(@book).not_to be_valid }
  end
  describe "when isbn begin with 'ISBN' and include '-'" do
    before { @book.isbn = "ISBN978-4-04-101258-1" }
    it{ expect(@book).to be_valid }
    its(:isbn){ expect(@book.isbn).to eq "9784041012581" }
  end
  describe "when isbn13 whose isbn10 is already taken" do
    before do
      book_with_same_isbn = @book.dup
      book_with_same_isbn.isbn = "4041012589"
      book_with_same_isbn.save
    end
    it{ expect(@book).not_to be_valid }
  end
  describe "when no isbn books" do
    before do
      @book.isbn = ""
      book_with_no_isbn = @book.dup
      book_with_no_isbn.save
    end
    it{ expect(@book).not_to be_valid }
  end
end
