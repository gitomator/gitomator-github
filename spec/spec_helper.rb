require 'gitomator/github/hosting_provider'


def create_hosting_service(provider_name)
  access_token = ENV['GITHUB_TEST_ACCESS_TOKEN']
  raise "Please set the environment variable GITHUB_TEST_ACCESS_TOKEN" if access_token.nil?
  github_org   = ENV['GITHUB_TEST_ORG']
  raise "Please set the environment variable GITHUB_TEST_ORG" if access_token.nil?

  provider = Gitomator::GitHub::HostingProvider.with_access_token(access_token, {org: github_org})
  return Gitomator::Service::Hosting::Service.new (provider)
end
