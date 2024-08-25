# Geolocation API

## Overview

This project is a Ruby on Rails application containerized with Docker. Follow the steps below to set up and run the application on your local machine.

## Prerequisites

- **Docker**: [Install Docker](https://docs.docker.com/get-docker/)
- **Docker Compose**: [Install Docker Compose](https://docs.docker.com/compose/install/)
- **Ipstack Access Key**: Register on [Ipstack](https://ipstack.com/) and get access key to use

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/FrancoRodriguez/geolocation-api.git
cd geolocation-api
```

### 2. Create .env file:
- **Environment Variables**: Configuration can be managed via environment variables. Ensure you have a .env file in the root directory with the necessary environment variables. Example .env file:

```env
IPSTACK_ACCESS_KEY=<ipstack_access_key>
API_KEY=1298ndsi912n319hd9w1092sn912

RAILS_ENV=production
POSTGRES_USER=franco.rodriguez
DATABASE_HOST=geolocation-api-db
DATABASE_PORT=5432
POSTGRES_PASSWORD=password
RAILS_SECRET=ed8b2812aa947301e4e40a408e7b42122eea2e7b1415f7f0ee6712a8f6a44fc45bc9034519761e1f439f7784a2e93b273dfa5afba52eddd55fd2fec3581fe6e3
```

- **Database Configuration**: The database configuration is located in config/database.yml. Make sure it aligns with the environment variables in your .env file.
- **Ipstack access key**: copy and paste the access key from ipstack website
- **API KEY**: This key is needed to authenticate endpoints with this app

### 3. Build the Docker Images
Build the Docker images for the application and its dependencies using:

```bash
docker-compose build
```

### 4. Start the Application
Start the application and its service with:

```bash
docker-compose up
```

You can then access the application at http://localhost:3000.

### 5. Running Tests
To run tests, use the following command:

```bash
docker-compose run api rspec
```

### 6. Running Rubocop
To run rubocop, use the following command:

```bash
docker-compose run api rubocop
```

### 7. Stopping the Application
To stop the running application and services, use:

```bash
docker-compose down
```

## Troubleshooting
 - **Database Issues**: Ensure the database container is running properly. Verify your config/database.yml and .env file for correct configuration.
 - **Port Conflicts**: If port 3000 is already in use, you may need to change the port mapping in the docker-compose.yml file. For example:
```yaml
ports:
- "3001:3000"
```
 - **Permission Errors**: If you encounter permission errors, make sure the files and directories in your project have the correct permissions and ownership.

## API Testing with Postman

The Postman collection for testing the API is stored in the `docs/postman` directory.

### Importing the Collection

1. Open Postman.
2. Click on **Import** in the top-left corner.
3. Select the `docs/postman/Geolocations_API.postman_collection.json` file from this repository.
4. The collection will now be available in Postman for testing.