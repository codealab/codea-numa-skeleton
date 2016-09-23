class Proposal < ActiveRecord::Base
  def send_to_codea
      api_token = Rails.application.secrets.codea_api_token
      url = "http://codea-codigox.herokuapp.com/api_create"
      params = {"api_token" => api_token,
                "proposal[name]"=> self.name,
                "proposal[avatar]" => self.avatar,
                "proposal[twitter_handle]" => self.twitter_handle}
      Net::HTTP.post_form(URI.parse(url), params)
  end

  def counter_codea
      api_token = Rails.application.secrets.codea_api_token
      url = "http://codea-codigox.herokuapp.com/api_counter"
      params = {"api_token" => api_token,
                "proposal[twitter_handle]" => self.twitter_handle}
      Net::HTTP.post_form(URI.parse(url), params)
  end

end
