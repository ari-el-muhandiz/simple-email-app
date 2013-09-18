class Order
  
  attr_accessor :params

  #Read Json file and parse the content and build setter and getter
  def parse_parameter_in_file(email)
    return unless email.instance_of? Email
    self.params = (email.content).scan(/{.+}/).map{|s| s.gsub(/{/, '').gsub(/}/, '')}
    Email.build_dynamic_method(params)
  end
end
