module ApplicationHelper
  
  def current_class?(link_path)
    return current_page?(link_path) ? 'active' : ''    
  end
end
