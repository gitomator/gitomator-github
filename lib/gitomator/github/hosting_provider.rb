require 'gitomator/github/base_hosting_provider'
require 'gitomator/model/hosting/repo'
require 'gitomator/model/hosting/team'

require 'gitomator/github/model/hosted_repo'
require 'gitomator/github/model/team'
require 'gitomator/github/model/pull_request'


module Gitomator
  module GitHub
    class HostingProvider < BaseHostingProvider


      # ---------------------- Static Factory Methods --------------------------

      #
      # @param config [Hash<String,Object>]
      # @return [Gitomator::GitHub::HostingProvider] GitHub hosting provider.
      #
      def self.from_config(config = {})
        return new(
          BaseHostingProvider.github_client_from_config(config),
          config['organization']
        )
      end



      # -------- Convert Sawyer::Resources to provider-agnostic objects --------

      # def as_team(team)
      #   return nil if team.nil?
      #   return Gitomator::Model::Hosting::Team.new(team.name,
      #       {
      #         id: team.id,
      #         org: (team.organization.nil? ? @org : team.organization.login)
      #       })
      # end

      # def as_repo(repo)
      #   return nil if repo.nil?
      #   return Gitomator::Model::Hosting::Repo.new(repo.name,
      #       repo.clone_url,
      #       {
      #         name: repo.name,
      #         description: repo.description,
      #         homepage: repo.homepage,
      #         private: repo.private?,
      #         has_issues: repo.has_issues,
      #         has_wiki: repo.has_wiki,
      #         has_downloads: repo.has_downloads,
      #         default_branch: repo.default_branch
      #       })
      # end

      # def as_repos(repos)
      #   return nil if repos.nil?
      #   repos.map {|resource| as_repo(resource) }
      # end

      def as_teams(teams)
        return nil if teams.nil?
        teams.map {|resource| as_team(resource) }
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
        Gitomator::GitHub::Model::HostedRepo.new(super)
      end

      def read_repo(name)
        Gitomator::GitHub::Model::HostedRepo.new(super)
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
          Gitomator::GitHub::Model::HostedRepo.new(super)
        end
      end


      def delete_repo(name)
        super(name)
      end


      def search_repos(query, opts = {})
        super(query, opts).map {|r| Gitomator::GitHub::Model::HostedRepo.new(r)}
      end



      #---------------------------- TEAMS ----------------------------------

      def create_team(name, opts = {})
        Gitomator::GitHub::Model::Team.new(super)
      end

      def read_team(name)
        Gitomator::GitHub::Model::Team.new(super)
      end

      #
      # opts:
      #  - :name (String)
      #  - :permission (String, one of 'pull', 'push' or 'admin')
      #
      def update_team(name, opts)
        Gitomator::GitHub::Model::Team.new(super)
      end

      def delete_team(name)
        super(name)
      end

      def search_teams(query, opts={})
        super(query, opts).map {|t| Gitomator::GitHub::Model::Team.new(t)}
      end


      #---------------------------------------------------------------------

      def create_pull_request(src, dst, opts = {})
        Gitomator::GitHub::Model::PullRequest.new(super, @gh)
      end

      def read_pull_request(base_repo, id)
        Gitomator::GitHub::Model::PullRequest.new(super, @gh)
      end

      def read_pull_requests(base_repo, opts={})
        super(base_repo, opts).map {|pr| Gitomator::GitHub::Model::PullRequest.new(pr, @gh)}
      end




    end
  end
end
