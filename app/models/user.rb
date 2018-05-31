class User < ApplicationRecord
	
  has_many :bugs, dependent: :destroy
	has_many :resolved_bugs, :foreign_key => "developer_id", :class_name => "Bug"

	has_many :user_projects, dependent: :destroy
	has_many :projects, through: :user_projects

	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def Manager?
    user_type == "Manager"
  end

  def Developer?
    user_type == "Developer"
  end

  def QA?
    user_type == "QA"
  end

end
