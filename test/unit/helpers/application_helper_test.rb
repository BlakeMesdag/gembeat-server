require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  
  test "#vulnerable_icon should return the icon for an object that is #vulnerable? => true" do
    assert_equal "<i class=\"icon-remove\"></i>", vulnerable_icon(stub(vulnerable?: true))
  end
  
  test "#vulnerable_icon should return the icon for an object that is #vulnerable? => false" do
    assert_equal "<i class=\"icon-ok\"></i>", vulnerable_icon(stub(vulnerable?: false))
  end

  test "#vulnerable_class should return the class for an object that is #vulnerable? => true" do
    assert_equal "vulnerable", vulnerable_class(stub(vulnerable?: true))
  end
  
  test "#vulnerable_class should return the class for an object that is #vulnerable? => false" do
    assert_equal "not-vulnerable", vulnerable_class(stub(vulnerable?: false))
  end
  
end
