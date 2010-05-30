class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.integer :from
      t.integer :category
      t.string :url
      t.string :original_url
      t.string :min_title
      t.text :max_title
      t.integer :sort_id,   :default=>1
      t.boolean :is_display,:default=>true

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
