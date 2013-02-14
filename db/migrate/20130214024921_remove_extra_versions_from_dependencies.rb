class RemoveExtraVersionsFromDependencies < ActiveRecord::Migration
  def up
    change_table(:dependencies) do |t|
      t.remove :major_version
      t.remove :minor_version
      t.remove :build
    end
  end

  def down
  end
end
