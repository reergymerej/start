# start-project

Allows you to quickly create new projects based off local templates.


```sh
start-project hello-app node-tape
# creates a new project `hello-app` based on the `node-tape` template
```



## Usage

### Templates

* Create a Git project in `~/.start-project/templates/`.
* Add `PROJECT_NAME` anywhere you want the new project's name to go.




### New Projects

```sh
start-project new-idea some-cool-template
# creates a new project `new-idea` based on `some-cool-template`
```


## Installation

```sh
git clone git@github.com:reergymerej/start.git start-project
cp start-project/main.sh /usr/local/bin/start-project
rm -rf start-project
```


### Dependencies

* [Ag](https://github.com/ggreer/the_silver_searcher)
* [Git](https://git-scm.com/)





## Future Options

* Configurations should be stored in `~/.start-project/config`.

* Good UX: https://codeburst.io/13-tips-tricks-for-writing-shell-scripts-with-awesome-ux-19a525ae05ae

* Post-clone setup instructions (ex: yarn install)

* Retain ref to template project so clones can pull in changes later.

* Ag alternatives, sed?


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
