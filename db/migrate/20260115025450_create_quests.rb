class CreateQuests < ActiveRecord::Migration[8.1]
  def change
    create_table :quests do |t|
      t.string :name
      t.text :body
      t.boolean :is_done, default: false

      t.timestamps
    end
  end
end
