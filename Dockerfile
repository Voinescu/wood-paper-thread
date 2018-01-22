FROM node:8

#RUN yarn config set registry https://registry.npmjs.org

COPY package.json /package.json

# Environment variable NODE_PATH puts the node_modules in the root of the container
# This way it doesn't get added "here", in the current working directory, which would make docker very slow
ENV NODE_PATH=/node_modules
ENV PATH=$PATH:/node_modules/.bin
# Install any needed packages
RUN yarn

# Set working directory to /app
WORKDIR /app
# Copy the current directory contents into the container at /app
ADD . /app

# Make port 80 available to the world outside this container
EXPOSE 3000
EXPOSE 35729

# Run the app when the container launches 
ENTRYPOINT ["/bin/bash", "/app/run.sh"]
CMD ["start"]
