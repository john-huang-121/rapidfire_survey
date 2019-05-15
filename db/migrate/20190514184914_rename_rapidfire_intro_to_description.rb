class RenameRapidfireIntroToDescription < ActiveRecord::Migration[5.2]
  def change
    rename_column :rapidfire_surveys, :introduction, :description
  end
end
