class RenameColumnWatchId < ActiveRecord::Migration
  def change
    rename_column :videos, :watch_id, :url
  end
end
