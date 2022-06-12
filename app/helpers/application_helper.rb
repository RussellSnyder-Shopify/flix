module ApplicationHelper
  include Pagy::Frontend
  
  def has_username?(user)
    user&.username&.length&.positive?
  end
end
