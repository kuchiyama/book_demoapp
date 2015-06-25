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

class Book < ActiveRecord::Base
  attr_accessible :isbn, :title
  validates :title,  presence: true, length: { maximum: 140 }
  validates :isbn, isbn_format: true, uniqueness: true, allow_blank: true

  def isbn=(unencrypted_isbn)
     write_attribute(:isbn, isbn_unify(unencrypted_isbn)) unless unencrypted_isbn.blank?
  end
#  private
    def isbn_unify(isbn)
      lisbn = Lisbn.new(isbn)
      if lisbn.valid?
        lisbn.isbn13
      else
        isbn
      end
    end

end
