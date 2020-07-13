# Mashlib development project

This project is intended to ease the development setup for the mashlib project, aka Solid data browser.

It allows you to install automatically several of the component repositories of the mashlib system, and coordinate their development.

It uses a subset of the functionality in [Lerna](https://lerna.js.org/) to bootstrap the various projects. Do note that you cannot use it to manage multi-package repositories like you normally would want to with Lerna.

The NPM scripts are using bash scripts. These might not work if you're developing on a Windows machine. Let us know if you want support for this.

Many of the repositories used in this project uses [Node Version Manager](https://github.com/nvm-sh/nvm) to maintain the Node version used to build the project. Be sure to have it installed.

## First time setup

```
git clone https://github.com/inrupt/mashlib-dev
cd mashlib-dev
npm run setup
``` 

Run this the first time you setup your folder. By default this sets up some repos for you:

- [mashlib](https://github.com/solid/mashlib/): the glue that puts everything together
- [node-solid-server](https://github.com/solid/node-solid-server): the server that allows you to test your changes
- [solid-panes](https://github.com/solid/solid-panes): the part that handles everything reg panes
- [solid-ui](https://github.com/solid/solid-ui): a lot of reusable code for solid-panes and the various pane-repos 

Any changes you do in this projects need to be committed to their original repos and eventually be pushed to NPM manually (this is the part of Lerna that we do not use for this project).

You can start your server and test out your code with:

```
npm start
```

Some projects require you to build a package before you can see changes, so check the various package.json files to see which scripts are available. You can usually do `npm run build`, and some also supports `npm run watch` which builds a new version each time you do a local change.

## Debugging solid-panes
Mashlib-dev is a powerful setup for developing the full stack, from rdflib, to solid-ui, to solid-panes, to mashlib, to node-solid-server. If you are just developing a pane then you will probably find the [Solid Pane Tester](https://github.com/solid/solid-panes#development) more useful. There, you will be able to see the effect of your changes in 5 seconds, whereas a full recompile in mashlib-dev takes more like 5 minutes. You can also just run the pane tester within mashlib-dev, at worspaces/solid-panes/dev/.

## Debugging solid-ui
To debug solid-ui, you can combine the solid-ui to solid-panes link with the Pane Tester. For instance when debugging code from solid-ui that affects the Sharing pane, you might run `npm start` to set the links between the workspaces, then run `npm run watch` in the solid-ui workspace and use the [Solid Pane Tester](https://github.com/solid/solid-panes#development) in the solid-panes workspace, with the Sharing pane in workspaces/solid-panes/dev/pane/, to see how your edits in solid-ui affect the Sharing pane.

## Debugging rdflib
Run:
```sh
npm run add rdflib
cd workspaces/rdflib
npm install
npm run build:esm
cd ../..
npm start
[Ctrl+C]
cd workspaces/solid-ui
npm run build-lib
```

In another terminal window, run `cd workspaces/solid-panes/dev/ ; npx webpack-dev-server`.

Edit `workspaces/solid-panes/dev/pane/` to have the pane you want to debug.
Open http://localhost:9000 and run `renderPane('http://example.com/#me')` in the console to check
if your setup works.
Then, under `workspaces/rdflib`, make your change, for instance add a console.log somewhere. It
should then be enough to run `npm run watch` in `workspaces/rdflib` to make your changes in
rdflib appear in the browser.

You can also combine this with `cd workspaces/solid-ui ; npm run watch` so that you can combine
edits in rdflib with edits in solid-ui, but if you're only editing rdflib, the
`npm run watch` in `workspaces/rdflib` should be enough.

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

## Troubleshooting

If you for some reason aren't able to get your setup working, you should double-check that Lerna actually manages to bootstrap the repositories. One way of doing this is to check node_modules in one of them and verify that the dependency that should be bootstrapped is actually a symlink to the corresponding repository (e.g. check that `workspaces/mashlib/node_modules/solid-ui` links to `workspaces/solid-ui` ). If it doesn't, it is usually because of different version (e.g. mashlib expects a newer version of solid-ui than the one you have locally). Make sure that these are aligned, then bootstrap again by running `npm start` or do it manually with `npx lerna bootstrap` (must be run in the root of the mashlib-dev repo).
