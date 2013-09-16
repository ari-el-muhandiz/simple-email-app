module ApplicationHelper
  def flash_message
    flash.inject('') do |message, element|
      message = message + (content_tag :div, :class => "message alert flash_#{element.first}" do
                              concat(content_tag(:div, element.last)) 
                              concat("<a class='close' data-dismiss='alert' href='#'>&times;</a>".html_safe)
        end) if (element.last.is_a?(String))
      message.html_safe
    end
  end

  def validation_message(obj, key)
    messages = obj.errors.messages[key]
    return if messages.blank?
    msg = "<div class='validation_error'>"
    val_msg = messages.inject(msg) do |msg, element|
      msg = msg + element.downcase
      msg << "&nbsp;&nbsp;&nbsp;"
    end << "</div>"
    val_msg.html_safe
  end
  
  def modal_box(id, title, button_title, &content)
    modal = %Q[<div id="#{id}" class="modal hide fade" tabindex="-1" \ 
    role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close modal-close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">#{title}</h3>
  </div>
    #{yield if block_given?}

</div>].html_safe
  end

end
