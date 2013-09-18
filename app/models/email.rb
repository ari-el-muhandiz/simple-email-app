require 'json'

class Email
  include ActiveModel::Model

  attr_accessor :to, :subject, :cc, :content, :dynamic_params
  validates_presence_of :to
  validates_presence_of :content, :message => "upload email template first, 
                                               before sending an email"
  validates_format_of :to, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    :message => "email format is wrong"
  
  #class method
  def self.write_json_file(hash)
    File.open("email.json", "w") do |f|
      f << JSON.pretty_generate(hash)
    end
  end
  
  def self.build_dynamic_method params
    params.each do |method|
      define_method("#{method}="){ |param| instance_variable_set("@#{method}", param) }
      define_method(method){ instance_variable_get("@#{method}") }
    end
  end
  
  #instance method
  def initialize(attr={})
    #get the content first
    read_json_file
    if content
      @order = Order.new
      self.dynamic_params = @order.parse_parameter_in_file(self)
      #set the value for dynamic parameter, if content exist
      attr.each {|key, value| self.send("#{key}=", value) if key}
    end
  end

  def read_json_file
    File.open("email.json", "a+") do |f|
      @content = JSON.parse(f.read)[:content.to_s] rescue ""
    end
  end


  #Replace predefined variable with new variable that user has inputed
  def get_new_content
    dynamic_params.each do |p|
      @content.gsub!(/{#{Regexp.escape(p)}}/, self.send(p.to_sym)) if self.send(p.to_sym).present?
    end
  end

  
end
