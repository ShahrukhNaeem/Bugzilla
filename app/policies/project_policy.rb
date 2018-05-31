class ProjectPolicy < ApplicationPolicy

	def index?
		user.present? 
	end

	def create?
		user.present? && user.Manager?
	end

	def add_user?
		user.present? && user.Manager?
	end

	def new?
		user.present? && user.Manager?
	end

	def edit?
		user.present? && user.Manager?
	end

	def update?
		user.present? && user.Manager?
	end

	def destroy?
		user.present? && user.Manager?

	end

	def delete_project_user?
		user.present? && user.Manager?

	end

end