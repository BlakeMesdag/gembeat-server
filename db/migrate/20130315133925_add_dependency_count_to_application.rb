class AddDependencyCountToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :dependency_count, :integer, :null => false, :default => 0

    Application.all.each do |application|
      application.update_attribute(:dependency_count, application.dependencies.count)
    end
  end
end
