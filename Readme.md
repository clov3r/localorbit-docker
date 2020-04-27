Built following direction from https://thoughtbot.com/blog/rails-on-docker with modification.

## Install

Requires docker toolset. I used `brew install docker`.

• Source the LocalOrbit repo in `./rails`:

```
git clone git@github.com:LocalOrbit/localorbit.git ./rails
```

```
~/dev/localorbit  docker: [localorbit]  git:(upstream)
tree -L 1
.
├── .gitignore          # ./rails is ignored
├── Dockerfile
├── docker-compose.yml
└── rails               # some copy of git@github.com:LocalOrbit/localorbit.git
```

## Setup

• `docker-compose up` # builds and starts services, attaches to rails console output
• `docker-compose run web bundle exec rake db:setup db:seed:development` # Runs rake tasks to create and seed the database for use.

• `docker-machine ls` # get info about the virtual machine, such as ip address.

• You will need to setup up something similar to an /etc/hosts entry

```
192.168.X.X localtest.me
```

Then [Visit localtest.me:3000](http://localtest.me:3000)

## Use

Docker is configured to build a service container for the rails and provide two more services: postgres and a persistent busybox (ie minimal) image for caching package manager data. Not sure that the cache works as expected.

`docker-compose up -d` # -d for "detach" from the log console
`docker-compose build` # if you make updates to the docker config
`docker-compose start` # start services after building
`docker-compose stop` # bring down services. Rails doesn't handle it gracefully
`docker-compose ps` # inspect state of services
