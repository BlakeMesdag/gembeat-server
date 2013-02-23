class AddTitleToVulnerabilities < ActiveRecord::Migration
  def change
    add_column :vulnerabilities, :title, :string
  end
end
