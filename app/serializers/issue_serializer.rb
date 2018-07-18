# frozen_string_literal: true

class IssueSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :status, :created_at

  belongs_to :creator
  belongs_to :assignee
end
