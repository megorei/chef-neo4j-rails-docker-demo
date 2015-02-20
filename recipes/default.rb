include_recipe 'docker'

docker_image 'web' do
  source 'https://github.com/megorei/rails-neo4j-demo'
  action :build_if_missing
end

docker_image 'tpires/neo4j' do
  action :pull_if_missing
end

docker_container 'neo4j' do
  image 'tpires/neo4j'
  detach true
  port '7474:7474'
  volume '/var/lib/neo4j/data'
end

docker_container do
  image 'web'
  link 'neo4j:neo4j'
  entrypoint 'rake db:seed'
end

docker_container 'web' do
  image 'web'
  detach true
  port '3000:3000'
  link 'neo4j:neo4j'
end