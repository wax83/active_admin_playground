class Post < ActiveRecord::Base
  attr_accessible :title, :body, :user
  belongs_to :user
end
