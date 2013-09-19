class Order
  include ActiveModel::Model

  PARAMS = %w[ name address date ]

  attr_accessor :to, :subject, :cc, :content, :name, :address, :date

  validates_presence_of :to
  validates_format_of :to, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    :message => "email format is wrong"
  validates_presence_of :content, :message => "upload email template first, 
                                               before sending an email"
  #instance method
  def initialize(attr={})
    #get the content first from email template
    @content = Email.new.read_json_file
    
    #set the value for predefined variable
    attr.each {|key, value| self.send("#{key}=", value) if key} unless attr.blank?
  end 

  #Replace predefined variable with new variable that user has inputed
  def get_new_content
    PARAMS.each do |p|
      content.gsub!(/{#{Regexp.escape(p)}}/, self.send(p.to_sym)) if self.send(p.to_sym).present?
    end
  end
end
