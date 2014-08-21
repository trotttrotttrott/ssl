module SSLHelpers
  class OpenSSL
    include Chef::Mixin::ShellOut

    attr_reader :node

    def initialize(node)
      @node = node
    end

    def local_tar_file
      File.join(Chef::Config[:file_cache_path], tar_file_name)
    end

    def remote_tar_file
      File.join(config['mirror'], tar_file_name)
    end

    def source_directory
      File.join(Chef::Config[:file_cache_path], source_directory_name)
    end

    def tar_file_checksum
      Digest::SHA1.hexdigest(File.read(local_tar_file))
    end

    def configured_checksum
      config['sha1']
    end

    def version_installed?
      current_version == config['version']
    end

    private

    def config
      node['ssl']['openssl']
    end

    def current_version
      shell_out('openssl version').stdout.split[1]
    end

    def source_directory_name
      "openssl-#{config['version']}"
    end

    def tar_file_name
      "#{source_directory_name}.tar.gz"
    end
  end
end
