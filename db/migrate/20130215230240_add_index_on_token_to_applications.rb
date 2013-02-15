class AddIndexOnTokenToApplications < ActiveRecord::Migration
  def change
    add_index :applications, :token
  end
end
