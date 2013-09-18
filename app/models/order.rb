class Order
  include ActiveModel::Model

  attr_accessor :to, :subject, :cc, :content, :dynamic_params

  validates_presence_of :to
  validates_format_of :to, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    :message => "email format is wrong"
  validates_presence_of :content, :message => "upload email template first, 
                                               before sending an email"
  #class method
  def self.build_dynamic_method params
    params.each do |method|
      define_method("#{method}="){ |param| instance_variable_set("@#{method}", param) }
      define_method(method){ instance_variable_get("@#{method}") }
    end
  end

  #instance method
  def initialize(attr={})
    #get the content first from email template
    @content = Email.new.read_json_file
    if content
      parse_parameter_in_file
      #set the value for dynamic parameter, if content exist     
      attr.each {|key, value| self.send("#{key}=", value) if key}
    end
  end 

  #Read Json file and parse the content and build setter and getter
  def parse_parameter_in_file
    @dynamic_params = content.scan(/{.+}/).map{|s| s.gsub(/{/, '').gsub(/}/, '')}
    Order.build_dynamic_method(dynamic_params)
  end
  
  #Replace predefined variable with new variable that user has inputed
  def get_new_content
    dynamic_params.each do |p|
      content.gsub!(/{#{Regexp.escape(p)}}/, self.send(p.to_sym)) if self.send(p.to_sym).present?
    end
  end
end