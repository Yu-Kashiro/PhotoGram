class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :display_name, null: false
      t.text :introduction
      t.timestamps
    end
  end
end
