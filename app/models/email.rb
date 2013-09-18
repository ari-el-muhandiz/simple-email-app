require 'json'

class Email

  #class method
  def self.write_json_file(hash)
    File.open("email.json", "w") do |f|
      f << JSON.pretty_generate(hash)
    end
  end
  
  def read_json_file
    File.open("email.json", "a+") do |f|
      return JSON.parse(f.read)[:content.to_s] rescue ""
    end
  end
  
end
