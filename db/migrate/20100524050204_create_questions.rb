class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.integer :from
      t.integer :category
      t.string :url
      t.string :min_title
      t.text :max_title
      t.integer :sort_id
      t.boolean :is_display

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
