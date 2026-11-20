# Project 08 – Build and Run Docker App Locally

## Goal
Practice container deployment by writing a Dockerfile and running an app inside a Docker container on my local machine.

## Files
- `app.py` – a small Python web server (standard library only) that shows a page with the container ID
- `Dockerfile` – builds the image from `python:3.12-slim`, copies `app.py`, exposes port 8080 and runs the app

## Steps
1. Checked Docker is installed: `docker --version`
2. Built the image: `docker build -t capstone-p8-app .`
3. Checked the image: `docker images`
4. Ran the container: `docker run -d -p 8080:8080 --name p8-container capstone-p8-app`
5. Checked it is running: `docker ps`
6. Tested it: `curl http://localhost:8080` and opened it in the browser

## Result
The app runs at `http://localhost:8080`. The page shows Container ID `b30c4b62ee02`, which matches the ID in `docker ps`, so the page is served from inside the container.

## Screenshots
App in the browser:
docker ps and curl output:
