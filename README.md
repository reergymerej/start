# Start

It's fun to make lots of projects.  The more you do it, the more you start to
tailor them.  This tools will allow you to

* easily customize your projects
* easily create new instances of projects

There are a _lot_ of options for how you may create a project.  Instead of
dictating some type of hierarchy, keep a single list of templates.  Allow a way
to clone an existing setup.

## Use Case

I have template projects for:

* node-jest
* react-jest
* node-tape
* elm
* elm-watch
* elixir
* phoenix

I want to start a new project to work on Node with Tape.

```sh
start node-tape hello-app
# creates a new project `hello-app` based on the `node-tape` template
```

I decide to start using willy instead.

```sh
start template node-tape node-willy
# creates a new template `node-willy` based on the `node-tape` template
```



## Details



This is all very Git-y.  Let's just lean on Git initially.


When creating a new template, we need to git init.

When creating a template, PROJECT_NAME indicates what to replace when creating
a new instance.



## Future Options

* Configurations should be stored in `~/.startrc`.  This will tell us where
  templates are stored.

* Good UX: https://codeburst.io/13-tips-tricks-for-writing-shell-scripts-with-awesome-ux-19a525ae05ae

* Post-clone setup instructions (ex: yarn install)

* Retain ref to template project so clones can pull in changes later.


```sh
start update node-jest .
# update the `node-jest` template to match the current dir
```

```sh
start list
# list templates
```
