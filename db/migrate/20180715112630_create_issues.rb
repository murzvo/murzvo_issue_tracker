class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.string  :name
      t.string  :description
      t.integer  :status, default: 0
      t.integer  :creator_id, default: 0, index: true
      t.integer  :assignee_id, default: 0, index: true

      t.timestamps
    end
  end
end
