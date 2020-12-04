# Webpack Template

Basic webpack boilerplate with react. This branch also includes a dockerfile for building.

### Modifying

Clone this repo and modify the following files:

Replace public/logo-16.png with your own image

Change the title in /public/index.html to your site name

Put your website code in the components folder.

Change the name you want for your docker image in build.bash

The Dev server currently runs on localhost:4000 and has an api proxy `"/api": "http://localhost:4001",` so if you have a backend server it will direct it there.

### Usage

Option 1: Build Image

```
./build.bash local
```

Option 2: Build Image and run it

```
./build.bash local run
```

Option 3: Build Image and push to AWS

```
./build.bash push
```
