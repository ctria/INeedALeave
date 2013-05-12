class CreateLeaveRequests < ActiveRecord::Migration
  def change
    create_table :leave_requests do |t|
      t.string :requestor
      t.date :date
      t.string :leave_type
      t.string :status

      t.timestamps
    end
  end
end
