require 'rubygems'
require 'sinatra'
require 'twilio-ruby'
require 'sanitize'

get '/ring' do
    response = Twilio::TwiML::VoiceResponse.new
    # response.gather(action: '/verify', method: 'POST', num_digits: 3, timeout: 3) do |gather|
    #     gather
    #     .say(message: 'Please enter the pass code')
    # end
    response.say(message:'Door is unlocking.')
    response.play(digits: '9')
    send_sms('james')
    response.to_s
end
post '/verify' do
    digits = Sanitize.clean(params['Digits'])
    response = Twilio::TwiML::VoiceResponse.new
    if digits == "222"
        response.say(message:'Door is unlocking.')
        response.play(digits: '9')
        send_sms('james')
    else
        response.say(message:'Incorrect code good bye')
        send_sms('fail')
    end
    response.to_s
end

def send_sms(who)
    account_sid = ENV['ACCOUNT_SID']
    auth_token = ENV['AUTH_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    if who == 'james'
        message = @client.messages.create(from: ENV['TWILIO_NUM'], body: 'Someone just entered', to: ENV['JAMES_NUM'])
    else
        message = @client.messages.create(from: ENV['TWILIO_NUM'], body: 'Door failure', to: ENV['JAMES_NUM'])
    end
    puts message.sid
end
