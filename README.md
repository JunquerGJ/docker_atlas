# docker_atlas

It is necessary to add the following secrets to the swarm. Secrets are created with the command `docker secret create secretName secretFile`.
An easy option is to create txt files for each secret and delete them once the secrets are loaded and the deployment is done. If you do this, **remove these files once the deployment is done**.

* **CRYPTOCERT**: cert.pem
* **CRYPTOKEY**: key.pem
* **DATABASE_URL**: It has to be an enviroment variable when the *front* service is launched. `DATABASE_URL=postgresql://$(cat dbUser.txt):$(cat dbUserPass.txt)@db:5432/$(cat dbName.txt)?schema=public` 
* **JWT_SECRET**: It will be the secret used to sign the JWT tokens. Should be long enough to avoid brute force attacks against the JWT tokens.
* **PORT**: The port where the backend is goint to run. Set it to 5000. `echo 5000 | docker secret create PORT -`
* **PW_KEYGENERATOR**: Use to encrypt user passwords.
* **TOKEN_DURATION**: Identifies the expiration time on or after which the JWT MUST NOT be accepted for processing.
* **dbName**: Name of the atlas database.
* **dbRootPass**: administration password. 
* **dbRootUser**: administration user.
* **dbUser**: user used by the backend to connect to the database.
* **dbUserPass**: password used by the backend to connect to the database.

Once the secrets are loaded, the following command should start the whole ecosystem.
`docker stack deploy --compose-file=docker-compose.yml prod`
