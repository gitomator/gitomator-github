require 'gitomator/service/hosting/service'
require 'gitomator/github/hosting_provider'


def create_hosting_service_from_environment_variables()
  ['GITHUB_TEST_ACCESS_TOKEN', 'GITHUB_TEST_ORG'].each do |var|
    raise "Please set the #{var} environment variable." if ENV[var].nil?
  end

  Gitomator::Service::Hosting::Service.new(
    Gitomator::GitHub::HostingProvider.from_config({
        :access_token => ENV['GITHUB_TEST_ACCESS_TOKEN'],
        :organization => ENV['GITHUB_TEST_ORG']
    })
  )
end
