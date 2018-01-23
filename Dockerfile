FROM node:8

RUN yarn config set registry https://registry.npmjs.org

COPY yarn.lock /yarn.lock
COPY .npmrc /.npmrc
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

# Make port 3000 available to the world outside this container
EXPOSE 3000

#WebSocket is set up by exposing port 35729 - as soon as a file is changed it sends a signal to the browser to tell it to reload
EXPOSE 35729

# Run the app when the container launches 
ENTRYPOINT ["/bin/bash", "/app/run.sh"]
CMD ["start"]
