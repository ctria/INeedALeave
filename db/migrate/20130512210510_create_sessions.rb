class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :email
      t.string :session_hash

      t.timestamps
    end
  end
end
