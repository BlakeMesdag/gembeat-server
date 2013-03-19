module ApplicationHelper
  
  def vulnerable_icon(obj)
    content_tag(:i, "", class: (obj.vulnerable? ? "icon-remove" : "icon-ok"))
  end
  
  def vulnerable_class(obj)
    obj.vulnerable? ? "vulnerable" : "not-vulnerable" 
  end
  
end
