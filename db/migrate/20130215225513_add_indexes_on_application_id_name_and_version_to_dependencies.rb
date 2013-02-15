class AddIndexesOnApplicationIdNameAndVersionToDependencies < ActiveRecord::Migration
  def change
    add_index :dependencies, [:application_id, :name, :version]
    add_index :dependencies, [:name, :version]
    add_index :dependencies, [:version]
  end
end
