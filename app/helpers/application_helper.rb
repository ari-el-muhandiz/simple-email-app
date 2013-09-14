module ApplicationHelper
  def flash_message
    flash.inject('') do |message, element|
      message = message + (content_tag :div, :class => "message alert", 
                           :id => "flash_#{element.first}" do
                              concat(content_tag(:div, element.last)) 
                              concat("<a class='close' data-dismiss='alert' href='#'>&times;</a>".html_safe)
        end) if (element.last.is_a?(String))
      message.html_safe
    end
  end

  def validation_message(obj)
    messages = obj.errors.full_messages
    return if messages.blank?
    msg = "<div class='field_with_errors'>"
    obj.errors.full_messages.inject(msg) do |msg, element|
      msg = msg + element.downcase
      msg << '</div'
      msg.html_safe
    end
  end
end
