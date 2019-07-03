# Mashlib development project

This project is intended to ease the development setup for the mashlib project. It uses a subset of the functionality in [Lerna](https://lerna.js.org/) to bootstrap the various projects, but you cannot use it to manage multi-package repositories like you normally would want to with Lerna.

The NPM scripts are using bash scripts. These might not work if you're developing on a Windows machine. Let us know if you want support for this.

## First time setup

Run this the first time you setup your folder. By default this setups some repos for you:

-- List repos and what role they play

If you do changes to this repos you must confer to the project itself for any actual updates to the code that you want to commit.

```
git clone https://github.com/solid/mashlib-dev
cd mashlib-dev
npm i
npm run setup
``` 

## Add dependency

This clones and bootstraps the dependency you want to work with.

```
npm run add <name-of-repo> # Works for recognized repos
npm run add <name-of-repo> <git-url-of-repo> # Custom added repos
```

## Remove dependency

This removes the dependency itself and cleans up dependencies. Note that this takes the name of the folder, not the original URL of the project.

```
npm run delete <folder-name-of-repo>
```
