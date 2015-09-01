#!/usr/bin/env ruby

require 'sensu-handler'
require 'json'
require 'erubis'

class Pushbullet < Sensu::Handler
  PUSHBULLET_API_URL = 'https://api.pushbullet.com/v2/pushes'

  option :json_config,
         description: 'Configuration name',
         short: '-j JSONCONFIG',
         long: '--json JSONCONFIG',
         default: 'pushbullet'

  def get_setting(name)
    settings[config[:json_config]][name]
  end

  def api_key
    get_setting('api_key')
  end

  def device_id
    get_setting('device_id')
  end

  def incident_key
    @event['client']['name'] + '/' + @event['check']['name']
  end

  def handle
    description = @event['notification'] || @event["check"]["output"]
    post_data(incident_key, description)
  end

  def post_data(incident_key, description)
    uri = URI(PUSHBULLET_API_URL)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    req = Net::HTTP::Post.new("#{uri.path}?#{uri.query}")
    req.basic_auth(api_key, '')
    req.set_form_data(payload(incident_key, description))

    response = http.request(req)
    verify_response(response)
  end

  def verify_response(response)
    case response
    when Net::HTTPSuccess
      true
    else
      fail response.error!
    end
  end

  def payload(title, body)
    title = 'Sensu Alert: %s' % [ title ]
    {
      'device_iden' => device_id,
      'type'        => 'note',
      'title'       => title,
      'body'        => body
    }
  end
end
