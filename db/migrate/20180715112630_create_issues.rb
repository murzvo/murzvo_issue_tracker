# frozen_string_literal: true

class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.string  :name
      t.string  :description
      t.integer  :status, default: 0
      t.integer  :creator_id, index: true
      t.integer  :assignee_id, index: true

      t.timestamps
    end
  end
end
