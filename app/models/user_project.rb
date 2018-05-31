class UserProject < ApplicationRecord
	belongs_to :user, required: false
  belongs_to :project, required: false

   # validates_presence_of :user
   # validates_presence_of :project
end