require 'test_helper'

class DependencyTest < ActiveSupport::TestCase
  def setup
    @application = applications(:gembeat)
    @dependency = dependencies(:gembeat_dependency)
  end

  test "dependencies must have unique names per application" do
    dependency = @application.dependencies.new(:name => @dependency.name, :version => "1.0.0")

    assert_equal false, dependency.valid?
    assert dependency.errors[:name].present?
  end

  test "dependencies dont need unique names on different applications" do
    application = Application.create(:name => "test", :description => "test description")

    assert_difference "Dependency.count", 1 do
      application.dependencies.create(:name => @dependency.name, :version => "1.0.0")
    end
  end

  test "dependencies ordered by name by default" do
    @application.dependencies.create(:name => "zebra", :version => "1.0.0")
    @application.dependencies.create(:name => "apple", :version => "1.0.0")

    assert_equal ["apple", "rails", "zebra"], @application.dependencies.pluck(:name)
  end

  test "dependencies require a name" do
    dependency = @application.dependencies.new(:version => "1.0.0")

    assert_equal false, dependency.valid?
    assert dependency.errors[:name].present?
  end

  test "dependencies require a version" do
    dependency = @application.dependencies.new(:name => "dwolla")

    assert_equal false, dependency.valid?
    assert dependency.errors[:version].present?
  end

  test "assess_vulnerabilities creates a vulnerability_assessment for applicable vulnerabilities" do
    assert_difference 'VulnerabilityAssessment.count', 1 do
      @dependency.assess_vulnerabilities
    end
  end

  test "vulnerable? returns true if vulnerable" do
    @dependency.vulnerability_assessments.create(vulnerability_id: vulnerabilities(:rails_old).id, vulnerable: true)
    assert_equal true, @dependency.vulnerable?
  end

  test "vulnerabilities are assessed on save if version is changed" do
    Dependency.any_instance.expects(:assess_vulnerabilities)

    @dependency.version = "3.2.13"
    @dependency.save
  end

  test "vulnerable? returns true if changing to a vulnerable version " do
    @dependency.update_attributes(version: "3.2.1.0")

    assert_equal true, @dependency.vulnerable?
  end

  test "vulnerable? returns false if changing to a safe version" do
    @dependency.update_attributes(version: "3.2.12")

    assert_equal false, @dependency.vulnerable?
  end
end
