# Start

This tools will allow you to

* create project templates
* create new instances of projects based on templates

```sh
start-project hello-app node-tape
# creates a new project `hello-app` based on the `node-tape` template
```




## Creating Templates

* Create a Git project in `~/.start-project/templates/`.
* Add `PROJECT_NAME` anywhere you want the new project's name to go.



## Using Templates

```sh
start-project new-idea some-cool-template
# creates a new project `new-idea` based on `some-cool-template`
```


## Installation


/usr/local/bin/




---

## Future Options

* Configurations should be stored in `~/.start-project/config`.

* Good UX: https://codeburst.io/13-tips-tricks-for-writing-shell-scripts-with-awesome-ux-19a525ae05ae

* Post-clone setup instructions (ex: yarn install)

* Retain ref to template project so clones can pull in changes later.


```sh
start-project update node-jest .
# update the `node-jest` template to match the current dir
```

```sh
start-project list
# list templates
```

```sh
start-project template node-tape node-willy
# creates a new template `node-willy` based on the `node-tape` template
```
