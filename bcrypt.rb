require 'bcrypt'

cost = BCrypt::Engine.cost

unencrypted_password = 'password'

password_digest = BCrypt::Password.create(unencrypted_password, cost: cost)

BCrypt::Password.new(password_digest) == unencrypted_password