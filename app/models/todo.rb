class Todo < ActiveRecord::Base
  belongs_to :user
  validates :email, uniqueness: true

end
