module Gitomator
  module GitHub
    module Model
      class Team


        #
        # @param gh_team [Sawyer::Resource]
        #
        def initialize(gh_team)
          @r = gh_team
        end


        def name
          @r.name
        end


      end
    end
  end
end
