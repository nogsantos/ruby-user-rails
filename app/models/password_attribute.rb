require 'bcrypt'
module PasswordAttribute

  # Read the :password attribute as a new BCrypt::Password.
  # Return the BCrypt::Password.
  def password
    BCrypt::Password.new(password_before_type_cast)
  rescue => e
    e
  end

  # Write the :password attribute as a new BCrypt::Password.
  def password=(plain_text)
    write_attribute(:password,BCrypt::Password.create(plain_text))
  rescue => e
    e
  end
end