# Docker Image
This image is for developing in **VSCODE** with 
  - Node JS
  - TypeScript
  - Angular
  - Cordova
  - Ionic

On the following platforms
- Android

## How to use it?
1. Install the vscode extension https://github.com/Microsoft/vscode-remote-release
2. Create a .devcontainer folder in your project root in VSCODE
3. Create a Dockerfile with the following content
   ```docker
   FROM fluxter/vscode-cordova:latest
   ```
4. Create a devcontainer.json with the following content
   ```json
    // For format details, see https://aka.ms/vscode-remote/devcontainer.json or this file's README at:
    // https://github.com/microsoft/vscode-dev-containers/tree/v0.101.1/containers/typescript-node-12
    {
        "name": "Fluxter NodeJS / TypeScript / Ionic / Cordova",
        "dockerFile": "Dockerfile",

        // Set *default* container specific settings.json values on container create.
        "settings": { 
            "terminal.integrated.shell.linux": "/bin/bash"
        },

        // Add the IDs of extensions you want installed when the container is created.
        "extensions": []

        // Use 'forwardPorts' to make a list of ports inside the container available locally.
        // "forwardPorts": [],

        // Use 'postCreateCommand' to run commands after the container is created.
        // "postCreateCommand": "",

        // Uncomment to connect as a non-root user. See https://aka.ms/vscode-remote/containers/non-root.
        // "remoteUser": "node"
    }
    ```

