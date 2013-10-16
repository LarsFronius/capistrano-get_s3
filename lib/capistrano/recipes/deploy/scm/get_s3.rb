require "capistrano/recipes/deploy/scm/base"
require "fog"
require "tempfile"

module Capistrano
  module Deploy
    module SCM
      class GetS3 < Base

        default_command = "tar xvfh"

        def head
          configuration[:branch] || "current"
        end

        def query_revision(revision)
          return revision
        end

        def checkout(revision, destination)

          tar = command

          execute = []
          execute << "tmpdir=`mktemp -dt deploy.XXXXXXXX`"
          execute << "cfgfile=`mktemp -t cfg.XXXXXXXX`"
          s3cmd.split("\n").each do |s3string|
            execute << printf_to_cfg(s3string)
          end
          execute << "mkdir -p #{destination}"
          execute << "s3cmd -c $cfgfile get s3://#{configuration[:bucket]}/#{configuration[:filename]} $tmpdir/#{configuration[:filename]}"
          execute << "tar xvfh $tmpdir/#{configuration[:filename]} -C #{destination}"
          execute << "rm -rf $tmpdir $cfgfile"

          execute.join(' && ')

        end

        def printf_to_cfg(s3_cld)
          return 'printf "%b\n" "' + s3_cld + '" >> $cfgfile'
        end

        def s3cmd
          "[default]
access_key = #{configuration[:aws_access_key_id]}
bucket_location = #{configuration[:bucket_region] || "EU"}
cloudfront_host = cloudfront.amazonaws.com
cloudfront_resource = /2010-07-15/distribution
default_mime_type = binary/octet-stream
delete_removed = False
dry_run = False
encoding = UTF-8
encrypt = False
follow_symlinks = False
force = False
get_continue = False
gpg_command = /usr/bin/gpg
gpg_decrypt = %(gpg_command)s -d --verbose --no-use-agent --batch --yes --passphrase-fd %(passphrase_fd)s -o %(output_file)s %(input_file)s
gpg_encrypt = %(gpg_command)s -c --verbose --no-use-agent --batch --yes --passphrase-fd %(passphrase_fd)s -o %(output_file)s %(input_file)s
gpg_passphrase =
guess_mime_type = True
host_base = s3.amazonaws.com
host_bucket = %(bucket)s.s3.amazonaws.com
human_readable_sizes = False
list_md5 = False
log_target_prefix =
preserve_attrs = True
progress_meter = True
proxy_host =
proxy_port = 0
recursive = False
recv_chunk = 4096
reduced_redundancy = False
secret_key = #{configuration[:aws_secret_access_key]}
send_chunk = 4096
simpledb_host = sdb.amazonaws.com
skip_existing = False
socket_timeout = 10
urlencoding_mode = normal
use_https = True
verbosity = WARNING"
        end
      end
    end
  end
end
