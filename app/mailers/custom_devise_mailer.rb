class CustomDeviseMailer < Devise::Mailer

  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def invitation_instructions(record, token, opts={})
    opts[:subject] = "#{Account.find(record.account_id).name} has invited you to their Team!"
    super
  end
end
