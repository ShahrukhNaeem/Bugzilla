class BugPolicy < ApplicationPolicy

	def index?
		user.present? 
	end

	def destroy?
		user.present? && !user.Developer?
	end

	def assign_bug?
		user.present? && user.Developer?
	end

	def resolved_bug?
		user.present? && user.Developer?
	end

	def edit?
		user.present? && !user.Developer?
	end

	def new?
		user.present? && user.QA?
	end

	def update?
		user.present? && user.Manager?
	end

	def create?
		user.present? && user.QA? 
	end
end