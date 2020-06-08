require 'spec_helper'
require 'ostruct'

RSpec.describe MailAllowed do
  subject(:mail_allowed) do
    described_class.new(%w(john@example.com eric@example.com @example2.com),
                        'terry@example.com')
  end

  it 'is compatible with Mail interceptors' do
    expect(mail_allowed).to respond_to(:delivering_email)
  end

  it 'removes recipients from an email using allowed addresses' do
    email = OpenStruct.new(
      to: %w(john@example.com graham@example.com)
    )
    expect { mail_allowed.delivering_email(email) }
      .to change { email.to }.to(%w(john@example.com))
  end

  it 'leaves recipients with an allowed domain' do
    email = OpenStruct.new(
      to: %w(matt@example2.com matt@example.com)
    )
    expect { mail_allowed.delivering_email(email) }
      .to change { email.to }.to(%w(matt@example2.com))
  end

  it 'will send the email to the fallback when no recipients remain' do
    email = OpenStruct.new(to: ['graham@example.com'])
    expect { mail_allowed.delivering_email(email) }
      .to change { email.to }.to(['terry@example.com'])
  end
end
