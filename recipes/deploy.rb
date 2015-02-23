include_recipe 'docker-rails-neo4j::default'
include_recipe 'docker-rails-neo4j::images'

docker_container 'neo4j' do
  image 'tpires/neo4j'
  port '7474:7474'
  volume '/var/lib/neo4j/data'
end

docker_container 'web' do
  image 'dpisarewski/rails-neo4j-demo'
  detach true
  port '3000:3000'
  link 'neo4j:neo4j'
end