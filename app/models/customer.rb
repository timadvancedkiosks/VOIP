# Proxy model class
# Add proxy_for for each model

class Customer < CouchRest::Model::Base

  property :secret, String
  timestamps!

  validates :secret, presence: true, uniqueness: true

  proxy_database_method :secret
  proxy_for :managers

  view_by :secret

  def manager
    result = self.managers.first
    if result.nil?
      # TODO: create default settings
      result = self.managers.new
      result.save
    end
    result
  end
end