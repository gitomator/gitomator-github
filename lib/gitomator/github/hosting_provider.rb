require 'gitomator/github/base_hosting_provider'
require 'gitomator/model/hosting/repo'
require 'gitomator/model/hosting/team'

module Gitomator
  module GitHub
    class HostingProvider < BaseHostingProvider


      # ---------------------- Static Factory Methods --------------------------

      class << self
        private :new
      end

      def self.with_access_token(access_token, opts = {})
        raise "Access token is nil/empty" if access_token.nil? || access_token.empty?
        new( opts.merge({:access_token => access_token}) )
      end

      def self.with_username_and_password(user, pass, opts = {})
        raise "Username is nil/empty" if user.nil? || user.empty?
        raise "Password is nil/empty" if pass.nil? || pass.empty?
        new( opts.merge({:login => user, :password => pass}) )
      end

      def self.with_client_id_and_secret(client_id, client_secret, opts = {})
        raise "Client id is nil/empty" if client_id.nil? || client_id.empty?
        raise "Client seceret is nil/empty" if client_secret.nil? || client_secret.empty?
        new( opts.merge({:client_id => client_id, :client_secret => client_secret}) )
      end

      # ---------------------- Static Factory Methods --------------------------


      # -------- Convert Sawyer::Resources to provider-agnostic objects --------

      def as_team(team)
        return nil if team.nil?
        return Gitomator::Model::Hosting::Team.new(team.name,
            {
              id: team.id,
              org: (team.organization.nil? ? @org : team.organization.login)
            })
      end

      def as_repo(repo)
        return nil if repo.nil?
        return Gitomator::Model::Hosting::Repo.new(repo.name,
            repo.clone_url,
            {
              name: repo.name,
              description: repo.description,
              homepage: repo.homepage,
              private: repo.private?,
              has_issues: repo.has_issues,
              has_wiki: repo.has_wiki,
              has_downloads: repo.has_downloads,
              default_branch: repo.default_branch
            })
      end

      #-------------------------------------------------------------------------


      #---------------------------- REPO ---------------------------------------

      #
      # opts:
      #   :auto_init (Boolean)
      #   :private (Boolean)
      #   :has_issues (Boolean)
      #   :has_wiki (Boolean)
      #   :has_download(Boolean)
      #
      def create_repo(name, opts = {})
        as_repo super(name, opts)
      end

      def read_repo(name)
        as_repo super(name)
      end

      #
      # opts:
      #   :name [String] — Name of the repo
      #   :description [String] — Description of the repo
      #   :homepage [String] — Home page of the repo
      #   :private [String] — true makes the repository private, and false makes it public.
      #   :has_issues [String] — true enables issues for this repo, false disables issues.
      #   :has_wiki [String] — true enables wiki for this repo, false disables wiki.
      #   :has_downloads [String] — true enables downloads for this repo, false disables downloads.
      #   :default_branch [String] — Update the default branch for this repository.
      #
      def update_repo(name, opts = {})
        unless opts.empty?
          as_repo super(name, opts)
        end
      end


      def delete_repo(name)
        super(name)
      end



      #---------------------------- TEAMS ----------------------------------

      def create_team(name, opts = {})
          as_team super(name, opts)
      end

      def read_team(name)
        as_team super(name)
      end

      #
      # opts:
      #  - :name (String)
      #  - :permission (String, one of 'pull', 'push' or 'admin')
      #
      def update_team(name, opts)
        as_team super(name, opts)
      end

      def delete_team(name)
        super(name)
      end


      #---------------------------------------------------------------------


    end
  end
end
