require 'mail_allowed/version'

# Filter mails with a specific allowed e-mail addresses and only leaves
# those in the 'to'.
class MailAllowed
  attr_reader :allowed_addresses, :fallback

  # @param [Array<String>, #include?] allowed_addresses
  # @param [String] fallback
  def initialize(allowed_addresses, fallback = nil)
    @allowed_addresses = allowed_addresses
    @fallback = fallback
  end

  def delivering_email(mail)
    mail.to = mail.to.select { |recipient| allowed?(recipient) }
    mail.to = [fallback] unless mail.to.any?
  end

  private

  def allowed?(recipient)
    allowed_addresses.any? do |address|
      if address.start_with?('@')
        recipient.end_with?(address)
      else
        address == recipient
      end
    end
  end
end
