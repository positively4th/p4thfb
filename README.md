#p4thfb

## Description

A soccer analytics framework. Including:
1. A JSON import tool, parsing json data into predictable database relations (p4thfb_import).
2. A backend api for working with detailed event data (p4thfb_api).
3. A framework for creating features and models for analyzing event data (p4thfb_api).
4. A web based app for viewing event data and results from models for analyzing event data (p4thfb_app).

## How to run and develop

### Prerequisites

* [docker](https://www.docker.com/) 
* [git](https://git-scm.com/)
* [make](https://www.gnu.org/software/make/)
 

### Set up a running environment

1. Create a p4thfb dedicated data folder with full path `${P4THFB_DATA_DIR}`.
2. Create an empty source folder `${P4THFB_DIR}`.
3. Clone this repo into the source folder: Run `git clone https://github.com/positively4th/p4thfb.git ${P4THFB_DIR}`.
4. Create the env file from the exmaple: Run `cp ${P4THFB_DIR}/.env.example ${P4THFB_DIR}/.env`.
5. Set the correct data dir path: Edit `${P4THFB_DIR}/.env` and set `DATA_VOLUME` to your value of `${P4THFB_DATA_DIR}`.
6. Start the necessary containers: Run `(cd ${P4THFB_DIR} && make docker-start)`. (If all goes well http://localhost/ shows an empty list of matches.)
7. Attach to the import container: In a new terminal, run `(cd ${P4THFB_DIR} && make docker-import-shell)`.
8. Download the StatsBomb Open Data zip file: Run `make import-downloadstatsbomb`.
9. Import one or more matches from the downloaded StatsBomb Open Data zip file: Run `make import-importstatsbomb`.

Visit http://localhost and enjoy.

### Set up a development environment

1. Follow steps 1 to 4 in the Set up a running environment instructions.
2. To setup the sub modules and start the postgres container: Run `(cd ${P4THFB_DIR} && make docker-dev-start)`.
3. To start the p4thfb_api submodule (on port 3000), run `(cd ${P4THFB_DIR}/p4thfb_api && make dev-run_v2)`
4. To start the p4thfb_app submodule (on port 8080), run `(cd ${P4THFB_DIR}/p4thfb_app && make dev-run)`

At this stage the api and app is running. Unless data has already been downloaded, run `(cd ${P4THFB_DIR}/p4thfb_import && import-downloadstatsbomb)` once, to download the StatsBomb Open data. Then run `(cd ${P4THFB_DIR}/p4thfb_import && import-importstatsbomb)` as needed, to import specific matches to the database.

Visit http://localhost:8080 and verify that it is working.

To start develop open p4thfb_api, p4thfb_app and/or p4thfb_import folders in your favorite ide and get going.


### Comments

This is a hobby project that has grown way beyound my spare time constraint. The code is full of expremental approaches, like mixins using `As(...)` instead of classes, separation of searching (using the database) and fetching (using stores), and more. A bonus if anybody else wants to work on it.
