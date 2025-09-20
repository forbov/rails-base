Warden::Strategies.add(:password_authenticatable) do
  def valid?
    params['user'] && params['user']['email'].present? && params['user']['password'].present?
  end

  def authenticate!
    user = User.find_for_database_authentication(email: params['user']['email'])
    if user&.valid_password?(params['user']['password'])
      success!(user)
    else
      fail!('Invalid email or password')
    end
  end
end