# Use an official Node.js runtime as the base image
FROM node:14

# Create and set the working directory
WORKDIR /app

# Copy the package.json and install dependencies
COPY package.json .
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose port 3000
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
