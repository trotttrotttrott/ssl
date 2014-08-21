include_recipe 'build-essential'

helper = SSLHelpers::OpenSSL.new(node)

remote_file helper.local_tar_file do
  source helper.remote_tar_file
  checksum helper.configured_checksum
end

ruby_block 'verify openssl checksum' do
  block do
    if helper.configured_checksum != helper.tar_file_checksum
      message = "Your configured checksum (#{helper.configured_checksum})"
      message << " does not match the checksum for #{helper.local_tar_file} (#{helper.tar_file_checksum})."
      raise message
    end
  end
end

execute 'untar openssl' do
  command "tar -xf #{helper.local_tar_file}"
  cwd Chef::Config[:file_cache_path]
  not_if { ::File.directory?(helper.source_directory) }
end

execute 'configure openssl' do
  command './config --prefix=/usr'
  cwd helper.source_directory
  not_if { helper.version_installed? }
end

execute 'make openssl' do
  command 'make'
  cwd helper.source_directory
  not_if { helper.version_installed? }
end

execute 'install openssl' do
  command 'make install'
  cwd helper.source_directory
  not_if { helper.version_installed? }
end
