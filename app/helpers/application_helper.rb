module ApplicationHelper
  def has_username?(user)
    user&.username&.length&.positive?
  end
end
