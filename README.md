# docker-rails-neo4j-cookbook

## Installation

    bundle install

## Usage

Bootstrap server:

    knife solo prepare root@virtualbox

Install cookbooks and put them into the repo

    berks install & berks vendor

Deploy application:

    knife solo cook -V root@virtualbox attributes/deploy.json

Run db seeds:

    knife solo cook -V root@virtualbox attributes/seeds.json

