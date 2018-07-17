# frozen_string_literal: true

module PolicyHelper
  def policy
    @policy ||= policy_class.new(current_user)
  end

  def forbidden!
    error!('You have not enough rights to proceed this action', 403)
  end

  private

  def policy_class
    raise 'You need to specify Policy class to be able to use this helper'
  end
end
