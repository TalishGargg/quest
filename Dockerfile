# Use the official Node.js image from the Docker Hub, version 10
FROM node:10

# Set an environment variable
ENV SECRET_WORD="SOCK_PUPPET"

# Copy the Quest application files into the Docker image
COPY ./quest/ /

# Grant execution permissions to all scripts in the /bin directory
RUN chmod +x /bin/*

# Install the required npm packages
RUN npm install

# Expose port 3000 for the application
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
