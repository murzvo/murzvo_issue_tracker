# frozen_string_literal: true

class Issue < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true

  enum status: %i[pending in_progress resolved]

  validates_presence_of :name

  scope :user_issues, lambda { |user|
    if user.regular?
      includes(:creator, :assignee)
        .where('creator_id == :user_id OR assignee_id == :user_id', user_id: user.id)
        .order(created_at: :desc)
    else
      includes(:creator, :assignee).all
    end
  }

  def assigned?
    assignee_id.present?
  end
end
