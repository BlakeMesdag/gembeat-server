class CreateVulnerabilities < ActiveRecord::Migration
  def change
    create_table :vulnerabilities do |t|
      t.string :dependency_name
      t.string :identifier
      t.string :url
      t.text :description
      t.text :metadata

      t.timestamps
    end
  end
end
