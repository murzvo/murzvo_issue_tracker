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
    if @user.regular?
      issue.creator_id == @user.id || issue.assignee_id == @user.id
    else
      true
    end
  end

  def assign?(issue, assignee_id)
    return assignee_id == issue.creator_id if @user.regular? || @user.manager?
    false
  end

  def unassign?(issue)
    issue.assigned? && @user.id == issue.assignee_id
  end

  def change_status?(issue)
    @user.id == issue.assignee_id && @user.manager?
  end
end
