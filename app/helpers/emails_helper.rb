module EmailsHelper
  def check_content(content)
    case content
    when ""
      return %Q[ You don't have any template email in file system. 
        Please upload it through button below]
    else
      return %Q[ You have already uploaded email template. You can send email now] 
    end
  end
end
