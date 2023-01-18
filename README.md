# Simple Errors
A simple error page handler for traefik.

This is a docker container designed to handle errors for traefik to prevent the basic '404 page not found' page.

Setup out the box to be configured as a lower priority route for traefik so you can deploy and forget.

## Environment variables
- `HOME_URL` - This is used to set the link for the 'Go Home' button on the error page.
