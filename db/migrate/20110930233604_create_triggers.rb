class CreateTriggers < ActiveRecord::Migration
  def change
    create_table :triggers do |t|
      t.string :description

      t.timestamps
    end
  end
end
