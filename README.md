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

You can also use remote projects via symbolic links.

```sh
ln -s git@github.com:kondor6c/go.git ~/.start-project/templates/go
```




### New Projects

```sh
start-project new-idea some-cool-template
# creates a new project `new-idea` based on `some-cool-template`
```



```sh
start-project --version
# prints version
```


## Installation

```sh
curl -o- https://raw.githubusercontent.com/reergymerej/start/master/install.sh | bash
```

t
### Dependencies

* [Ag](https://github.com/ggreer/the_silver_searcher)
* [Git](https://git-scm.com/)
