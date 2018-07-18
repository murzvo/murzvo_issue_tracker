# frozen_string_literal: true

class IssuesPolicy
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def modify?(issue)
    issue.creator_id == @user.id || issue.assignee_id == @user.id
  end

  def delete?(issue)
    issue.creator_id == @user.id
  end

  def show?(issue)
    if user.regular?
      issue.creator_id == @user.id || issue.assignee_id == @user.id
    else
      true
    end
  end

  def assign?(issue, assignee_id)
    @user.manager? && !issue.assigned? && @user.id == assignee_id
  end

  def unassign?(issue)
    @user.manager? && issue.assigned? && @user.id == issue.assignee_id
  end

  def change_status?(issue)
    @user.id == issue.assignee_id && @user.manager?
  end
end