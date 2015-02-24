include_recipe 'docker-rails-neo4j::default'
node.default['docker']['image_cmd_timeout']   = 600

=begin
git "#{Chef::Config[:file_cache_path]}/web" do
  repository 'https://github.com/megorei/rails-neo4j-demo'
  action :export
end

docker_image 'web' do
  source "#{Chef::Config[:file_cache_path]}/web"
  action :build
end
=end

docker_image 'dpisarewski/rails-neo4j-demo' do
  action :pull_if_missing
end

docker_image 'tpires/neo4j' do
  action :pull_if_missing
end

docker_image 'dpisarewski/nginx-rails-proxy' do
  action :pull_if_missing
end