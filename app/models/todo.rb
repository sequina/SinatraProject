class Todo < ActiveRecord::Base
  belongs_to :user
  validates :content, uniqueness: true

end
