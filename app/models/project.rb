# my comment
class Project < ApplicationRecord
  has_many  :user_projects
	has_many  :users ,  through:  :user_projects  ,  dependent:  :destroy
	 	has_many :bugs, dependent: :destroy
	 	validates :name, presence: true
	 	accepts_nested_attributes_for :user_projects
end