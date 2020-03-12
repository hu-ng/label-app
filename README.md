# README

# Setting up
- Run `bundle install` to grab Rails dependencies
- Run `npm install` to grab the Vue.js dependencies
- Run `rails s` in root directory to start Rails API
- Navigate to `label-vue` and run `npm run serve` to start Vue server

# Project description and assumptions

Stack used: Back-end API using **Rails**, Front-end using **Vue.js**

I assume that users would want to keep track of the addresses, parcels, and shipments they have created that are associated with their account. Because everyone would be using the same API I provided, I choose to add a database layer on top of using the unique identifers given by EasyPost. Every user would then have their own Address, Parcel, and Shipment objects, all of which has the appropriate relationships set up in the back-end. When an object is created, a call is made to EasyPost to create a corresponding object on their end, then the Rails client saves the returned `unique_id` to the database. To create a label, I have a dedicated `LabelController` configured to receive POST requests, which then uses the EasyPost client to generate a S3 link to the label.
