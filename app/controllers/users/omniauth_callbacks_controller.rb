class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.find_for_google_oauth2(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      if session[:return_to]
        sign_in @user
        redirect_to session[:return_to]
        session[:return_to] = nil
      else
        sign_in_and_redirect @user, event: :authentication
      end
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      redirect_to new_user_session_url, alert: @user.errors
    end
  end
end
