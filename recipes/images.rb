include_recipe 'docker-rails-neo4j::default'
node.default['docker']['image_cmd_timeout']   = 600

# Pull images from docker hub
execute 'docker pull debian'
execute 'docker pull dpisarewski/rails-neo4j-demo:latest'
execute 'docker pull tpires/neo4j'
execute 'docker pull dpisarewski/nginx-rails-proxy:latest'

# Pull images from docker hub using docker cookbook
=begin
docker_image 'debian' do
  action :pull_if_missing
end

docker_image 'dpisarewski/rails-neo4j-demo:latest' do
  action :pull_if_missing
end

docker_image 'tpires/neo4j' do
  action :pull_if_missing
end

docker_image 'dpisarewski/nginx-rails-proxy:latest' do
  action :pull_if_missing
end
=end


# Build image from github repository
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


# Load image from file
=begin
cookbook_file "#{Chef::Config[:file_cache_path]}/nginx-rails-proxy.tar" do
  source 'images/nginx-rails-proxy.tar'
end
execute "docker load -i #{Chef::Config[:file_cache_path]}/nginx-rails-proxy.tar"
=end
