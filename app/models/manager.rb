require 'uri'

class Manager < CouchRest::Model::Base
  # TODO: add attributes, etc: 'property :url, String'
  timestamps!
  proxied_by :customer
end