class Bug < ApplicationRecord
	belongs_to :user
	belongs_to :project

	has_one :assigned_to, primary_key: "developer_id", class_name:"User", foreign_key: "id"


	validates :title, presence: true, uniqueness: true
	validates :status, presence: true
	validates :bug_type, presence: true

	mount_uploader :screenshot, ImageUploader

end
