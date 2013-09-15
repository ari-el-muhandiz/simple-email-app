class Email
  include ActiveModel::Model

  attr_accessor :to, :subject, :cc, :name, :day, :date, :time, :address
  validates_presence_of :to
  validates_format_of :to, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    :message => "email format is wrong"
  
  def initialize(attr={})
    attr.each {|key, value| self.send("#{key}=", value) if key}
  end
  
end
