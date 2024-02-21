
# ----------- BUILDER PHASE -----------
FROM node:16-alpine as builder
WORKDIR '/app'
# Install dependencies
COPY package.json .
RUN npm install --verbose
# Copy over our code
COPY . .
# Start the build
RUN npm run build
# Stuff will now get built into ./build ...

# ----------- RUN PHASE -----------

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# Note: Default command will already start ngninx for us.