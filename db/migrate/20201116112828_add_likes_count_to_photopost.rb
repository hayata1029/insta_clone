class AddLikesCountToPhotopost < ActiveRecord::Migration[5.2]
  class MigrationUser < ApplicationRecord
    self.table_name = :photoposts
  end
  
  # nullにfalseを設定したことと、defaultの値を設定した為changeではなくupとdownのメソッドを使用している
  
  def up
    _up
  rescue => e
    _down
    raise e
  end
  
  def down
    _down
  end
  
  private
  
    def _up
      MigrationUser.reset_column_information
      
      
      add_column :photoposts, :likes_count, :integer, null: false, default: 0 unless column_exists? :photoposts, :likes_count
    end
    
    def _down
      MigrationUser.reset_column_information
  
      remove_column :photoposts, :likes_count if column_exists? :photoposts, :likes_count
    end
end
