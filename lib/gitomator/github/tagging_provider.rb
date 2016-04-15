require 'gitomator/github/base_hosting_provider'
require 'gitomator/model/hosting/repo'
require 'gitomator/model/hosting/team'

module Gitomator
  module GitHub
    class TaggingProvider < BaseHostingProvider


      def initialize(octokit_client)
        @gh = octokit_client
      end


      def add_tags(repo_full_name, issue_or_pr_id, *tags)
        @gh.add_labels_to_an_issue(repo_full_name, issue_or_pr_id, tags)
                .map { |r| r.to_h }  # Make the result a regular Ruby Hash
      end

      def remove_tag(repo_full_name, id_or_name, tag)
        @gh.remove_label(repo_full_name, id_or_name, tag)
                .map { |r| r.to_h }  # Make the result a regular Ruby Hash
      end


      #
      # @return Enumerable of object identifiers.
      #
      def search(repo_full_name, label)
        if query.is_a? String
          q = "repo:#{repo_full_name} type:issue|pr label:\"#{label}\""
          @gh.search_issues(q)
            .items.map {|item| item.number}  # Make the result an array of issue/or id's
        else
          raise "Unimplemented! Search only supports a single tag at the moment."
        end

      end


      def metadata(repo_full_name, tag=nil)
        if tag
          begin
            # Return metadata (Hash<Symbol,String>)
            @gh.label(repo_full_name, tag).to_h
          rescue Octokit::NotFound
            return nil
          end

        else
          # Return Hash<String,Hash<Symbol,String>>, mapping tags to their metadata
          @gh.labels(repo_full_name).map {|r| [r.name, r]}.to_h
        end
      end



      def set_metadata(repo_full_name, tag, metadata)
        color = metadata[:color] || metadata['color']
        raise "The only supported metadata property is 'color'" if color.nil?
        # TODO: Validate the color string (6-char-long Hex string. Any other formats supproted by GitHub?)

        if metadata(repo_full_name, tag).nil?
          @gh.add_label(repo, tag, color).to_h
        else
          @gh.update_label(repo_full_name, tag, {:color => color}).to_h
        end

      end


    end
  end
end
