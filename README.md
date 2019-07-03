# Mashlib development project

This project is intended to ease the development setup for the mashlib project. It uses a subset of the functionality in [Lerna](https://lerna.js.org/) to bootstrap the various projects, but you cannot use it to manage multi-package repositories like you normally would want to with Lerna.

The NPM scripts are using bash scripts. These might not work if you're developing on a Windows machine. Let us know if you want support for this.

## First time setup

```
git clone https://github.com/solid/mashlib-dev
cd mashlib-dev
npm i
``` 

Run this the first time you setup your folder. By default this setups some repos for you:

- [mashlib](https://github.com/solid/mashlib/): the glue that puts everything together
- [node-solid-server](https://github.com/solid/node-solid-server): the server that allows you to test your changes
- [solid-panes](https://github.com/solid/solid-panes): the part that handles everything reg panes
- [solid-ui](https://github.com/solid/solid-ui): a lot of reusable code for solid-panes and the various pane-repos 

Any changes you do in this projects needs to committed to their original repos and eventually pushed manually to NPM (this is the part of Lerna that we do not use for this project).

You can start your server and test out your code with:

```
npm start
```

Do note that some projects require you to build a package before you can see changes, so check the various package.json files to see which scripts are available. You can usually do `npm run build`, and some also supports `npm run watch` which builds a new version each time you do a local change.

## Add dependency

You can add other projects to your workspaces to do local changes. We've mapped most projects that are related to mashlib for you, so you can simply do:

```
npm run add <name-of-repo>
```

For the projects that we haven't mapped you need to manually give the URL to the Git repo.

```
npm run add <name-of-repo> <git-url-of-repo>
```

## Remove dependency

This removes the dependency itself and cleans up dependencies.

```
npm run delete <name-of-repo>
```
