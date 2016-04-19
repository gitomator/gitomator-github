module Gitomator
  module GitHub
    module Model
      class HostedRepo


        #
        # @param gh_repo [Sawyer::Resource]
        #
        def initialize(gh_repo)
          @r = gh_repo
        end


        def name
          @r.name
        end

        def full_name
          @r.full_name
        end

        def url
          @r.clone_url
        end


      end
    end
  end
end
