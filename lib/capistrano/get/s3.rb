require "capistrano/get/s3/version"
require "capistrano/recipes/deploy/scm/base"
require "fog"
require "tempfile"

module Capistrano
  module Deploy
    module SCM
      class S3 < Base

        default_command = "tar xvfh"

        def head
          configuration[:branch] || "current"
        end

        def query_revision(revision)
          return revision
        end

        def checkout(revision, destination)
          tmp = Tempfile.new('capistrano-s3')

          connection = Fog::Storage.new({
            :provider => configuration[:provider] || "AWS",
            :aws_access_key_id => configuration[:aws_access_key_id],
            :aws_secret_access_key => configuration[:aws_secret_access_key]
          })
          bucket = connection.directories.get(configuration[:bucket])
          file = bucket.files.get(configuration[:filename])
          tmp.write(file.body)
          tar = command

          execute = "mkdir -p #{destination} && #{tar} #{tmp.path} -C #{destination}"

          execute

        end
      end
    end
  end
end
