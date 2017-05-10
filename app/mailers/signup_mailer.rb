class SignupMailer < ActionMailer::Base
  default :from => 'no-replay@app.net'
  layout 'mailer'

  def confirm_email(user)
    @user = user
    @confirmation_link = root_url

    mail({
      :to => user.email,
      :bcc => ['sign ups <sigup@app.net>'],
      :subject => 'confirmação'
    })

  end

end
