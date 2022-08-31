
const express = require("express");
const app = express();
const mongoose = require("mongoose");
const { MONGO_DB_CONFIG } = require("./config/app.config");
const errors = require("./middleware/errors.js");
const swaggerUi = require("swagger-ui-express"),
  swaggerDocument = require("./swagger.json");

mongoose.Promise = global.Promise;
mongoose
  .connect("mongodb://localhost/api-docs", {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(
    () => {
      console.log("Database Connected");
    },
    (error) => {
      console.log("Database can't be connected: " + error);
    }
  );

app.use(express.json()); //Inbuilt middleware function with express that will pass incoming json request
app.use("/uploads", express.static("uploads")); // static : Can be accessed through api links
app.use("/api", require("./routes/app.routes"));
app.use(errors.errorHandler);
app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerDocument));

app.listen(process.env.port || 4000, function () {
  console.log("Ready to Go!");
});
