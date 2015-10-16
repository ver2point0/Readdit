class User < ActiveRecord::Base

    before_save :capitalize_name
    before_save :downcase_email
    
    NAME_REGEX = /\A[A-Z][a-z]*\b/
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
    validates :name, 
              length: { minimum: 1, maximum: 100 }, 
              presence: true,
              format: { with: NAME_REGEX }
    
    validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
    validates :password, length: { minimum: 6 }, allow_blank: true
    
    validates :email,
              presence: true,
              uniqueness: { case_sensitive: false },
              length: { minimum: 3, maximum: 100 },
              format: { with: EMAIL_REGEX }
              
    has_secure_password
    
    def capitalize_name
      self.name = (name.split.each { |n| n.capitalize!}).join(" ")
    end
    
    def downcase_email
      self.email = email.downcase
    end
    
end
