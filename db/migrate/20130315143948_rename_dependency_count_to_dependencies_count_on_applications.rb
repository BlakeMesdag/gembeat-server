class RenameDependencyCountToDependenciesCountOnApplications < ActiveRecord::Migration
  def up
    rename_column :applications, :dependency_count, :dependencies_count
  end

  def down
    rename_column :applications, :dependencies_count, :dependency_count
  end
end
