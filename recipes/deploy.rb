include_recipe 'docker-rails-neo4j::default'
include_recipe 'docker-rails-neo4j::images'

def run(command)
  execute "#{command}; true"
end

# Start containers
run 'docker run --name data -v /var/lib/neo4j/data -v /var/log/nginx -v /usr/src/app/log debian'

run 'docker stop neo4j web nginx'
run 'docker rm   neo4j web nginx'

execute 'docker run -d --restart=always -p 7474:7474 --name neo4j --volumes-from data tpires/neo4j'
execute 'docker run -d --restart=always -p 3000:3000 --name web   --volumes-from data --link neo4j:neo4j dpisarewski/rails-neo4j-demo'
execute 'docker run -d --restart=always -p 80:80     --name nginx --volumes-from data --volumes-from web --link web:web dpisarewski/nginx-rails-proxy'

# Run containers using docker cookbook
=begin
docker_container 'debian' do
  container_name 'data'
  volume '/var/lib/neo4j/data'
  volume '/var/log/nginx'
  volume '/usr/src/app/log'
end

docker_container 'tpires/neo4j' do
  container_name 'neo4j'
  detach true
  port '7474:7474'
  volumes_from 'data'
end

docker_container 'dpisarewski/rails-neo4j-demo' do
  container_name 'web'
  detach true
  port '3000:3000'
  link 'neo4j:neo4j'
  volume '/usr/src/app/public'
end

docker_container 'dpisarewski/nginx-rails-proxy' do
  container_name 'nginx'
  detach true
  port '80:80'
  link 'web:web'
  volumes_from 'data'
  volumes_from 'web'
end
=end
