# Use a lightweight Node.js image
FROM node:alpine

# Set the working directory
WORKDIR /usr/app

# Install PM2 globally
RUN npm install --global pm2

# Copy only the package.json and yarn.lock files to optimize caching
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install --production --frozen-lockfile

# Copy the rest of the files
COPY . .

# Expose the listening port
EXPOSE 3000

# Run the app with PM2
CMD ["pm2-runtime", "start", "npm", "--", "start"]
