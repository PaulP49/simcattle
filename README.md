# Simulator "SimCattle"

This simulator software is used to simulate farm animal location models.
It uses the software "SmartSPEC" internally to generate new locations using provided ground truth data.

SmartSPEC:
https://github.com/andrewgchio/SmartSPEC/ 

## Requirements
- docker
- docker-compose
- make


## Installation & Start
Run `make up` to install all components and start the simulator. Initially it can take a few minutes for all services to be up and running. Verify all services are started by running `docker ps`, which should list all services defined in `docker-compose.yml`.

`make up` starts the MySQL instance and stores some default settings and ground truth data in it. Parallely all backend services are compiled and started, as well as the Web UI. Future runs of `make up` just start the existing services.

## Usage of Web UI
After starting the simulator, the Web UI is available at http://localhost:8080/.

## Usage of REST API
If you want to use the REST API directly without the Web UI, run the endpoints using the `.http` files in the `http` folder of the respective service. Every service, which offers endpoints, has a `http` folder.

`.http` files are supported by Visual Studio Code to run REST API requests. You can use other software as well to execute the REST API.

## Use Different Training Data
By default, ground truth data from a previous WeideInsight project is used as training data for Scenario-Learning. If you want to use different data refer to `docs/data-extraction.md`, which lists down the steps to convert and store data.

## Stop Simulator & Exit
Run `make stop` to stop the simulator. This action does not delete any data.

## Uninstallation & Reset
Run `make destroy` to remove all data, containers and images of the project.

Afterward you can run `make up` again to start from scratch.

## Debugging
Run `make logs` to see all logs from all services or `make logs s=<some-service>` for the logs of a specific service. The names of the services can be found in `docker-compose.yml`.
