class CreateDependencies < ActiveRecord::Migration
  def change
    create_table :dependencies do |t|
      t.integer :application_id
      t.string :name
      t.string :version
      t.integer :major_version
      t.integer :minor_version
      t.decimal :build

      t.timestamps
    end
  end
end
