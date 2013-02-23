class ImportRubySecVulnerabilities < ActiveRecord::Migration
  def up
    vulnerability_data_dir = File.expand_path("#{Rails.root}/db/data")
    Dir.foreach(vulnerability_data_dir) do |vulnerability_dir|
      next if vulnerability_dir =~ /^[.]/
      Dir.foreach("#{vulnerability_data_dir}/#{vulnerability_dir}") do |file|
        next if file =~ /^[.]/
        puts "Importing #{vulnerability_data_dir}/#{vulnerability_dir}/#{file}"
        vulnerability = YAML.load(File.read("#{vulnerability_data_dir}/#{vulnerability_dir}/#{file}"))

        Vulnerability.create!(dependency_name: vulnerability["gem"],
          identifier: vulnerability["cve"],
          url: vulnerability["url"],
          description: vulnerability["description"],
          title: vulnerability["title"],
          versions: vulnerability["patched_versions"])
      end
    end
  end

  def down
  end
end
