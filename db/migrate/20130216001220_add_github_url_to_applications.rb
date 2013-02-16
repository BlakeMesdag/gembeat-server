class AddGithubUrlToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :github_url, :string
  end
end
