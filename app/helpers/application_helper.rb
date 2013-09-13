module ApplicationHelper
  def flash_message
    flash.inject('') do |message, element|
      message = message + (content_tag :div, element.last.html_safe, :class=> "message", 
        :id => "flash_#{element.first}") if (element.last.is_a?(String))
      message.html_safe
    end
  end
end
