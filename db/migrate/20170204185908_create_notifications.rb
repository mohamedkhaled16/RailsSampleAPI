class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.text :token
      t.text :other

      t.timestamps
    end
  end
end
