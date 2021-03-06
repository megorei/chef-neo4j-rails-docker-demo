include_recipe 'docker-rails-neo4j::default'
include_recipe 'docker-rails-neo4j::images'

execute 'docker run --name seeds --link neo4j:neo4j --rm=true dpisarewski/rails-neo4j-demo rake db:seed'

# Run rake task using docker cookbook
=begin
docker_container 'seeds' do
  remove_automatically true
  init_type false
  tty true
  image 'dpisarewski/rails-neo4j-demo'
  link 'neo4j:neo4j'
  command 'rake db:seed'
  action :run
end
=end
