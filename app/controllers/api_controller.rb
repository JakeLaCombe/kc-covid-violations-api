# frozen_string_literal: true

require 'net/http'
require 'uri'

class ApiController < ApplicationController
  def index; end

  def show
    case_id = params[:id]
    uri = URI.parse("http://city.kcmo.org/kc/ActionCenterRequest/CaseInfo.aspx?CaseID=#{case_id}")
    response = Net::HTTP.get_response(uri)
    render json: { data: Nokogiri::HTML(response.body).xpath('//div[@class="text-left"]')[0].inner_html }
  end
end
