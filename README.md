# ruby-scaffolding
In my everyday job function writing command line utilities and microservices occupies large portion of work time. This utility is to create working skeleton of [thor](http://whatisthor.com/) based CLI tools and [grape](https://github.com/ruby-grape/grape) + [rack](https://rack.github.io/) based microservice.

Each created skeleton has documentation related to barebone pieces provided in skeleton and entry points to write useful unitility as soon as possible.

### Install
Make sure your version manager pointing to desired ruby 
```
git clone git@github.com:valmikroy/ruby-scaffolding.git

bundle install


./bin/scaffold 
Commands:
  scaffold cli NAME           # Initialize a new CLI project
  scaffold help [COMMAND]     # Describe available commands or one specific command
  scaffold microservice NAME  # Initialize a new microservice skeleton based on rack + grape
  scaffold simplecli NAME     # Initialize a new Simple CLI skeleton
  scaffold version            # Display version

Options:
  [--verbose], [--no-verbose]  

```

### Usage
- Simple single file ruby cli `./bin/scaffold simplecli blah` should create dir `../rubycli-blah`.
- Full fledge ruby cli project `./bin/scaffold cli bla1h` should create dir `../rubycli-bla1h`.
- For quick microservice project `./bin/scaffold microservice blah` should create dir `../rubymicroservice-blah`

`README.md` inside each skeleton structure should provide you more documentation about further usage.
