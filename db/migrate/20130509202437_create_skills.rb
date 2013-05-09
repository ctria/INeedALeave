class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.string :skill_type
      t.integer :min_coverage

      t.timestamps
    end
  end
end
