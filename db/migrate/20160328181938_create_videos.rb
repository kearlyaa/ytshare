class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.string :watch_id
      t.timestamps
    end
  end
end
