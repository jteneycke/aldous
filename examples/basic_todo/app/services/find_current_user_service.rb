class FindCurrentUserService < Aldous::Service
  attr_reader :session

  def initialize(session)
    @session = session
  end

  def raisable_error
    Aldous::Errors::UserError
  end

  def default_result_data
    {user: nil}
  end

  def perform
    user_id = session[:user_id]
    if user_id
      user = User.where(id: user_id).first
      if user
        Result::Success.new(user: user)
      else
        Result::Failure.new
      end
    else
      Result::Failure.new
    end
  end
end
