const {Schema, model} = require('mongoose');

//Schema defines all user fields since it is the user model
const userSchema=new Schema({
    userid: {type: String, unique: true},
    fullname: {type: String, trim:true},
    email: {type: String, unique: true,
        validate: {
            validator: (value) => {
              const re =
                /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
              return value.match(re);
            },
            message: "Please enter a valid email address",
          },},
    phone: {type: String, unique: true},
    password: {type: String},
    address: {type: String, default:""},
    country: {type: String, default:""},
    city: {type: String, default:""},
    pincode: {type: String, default:""},
    addedon: {type: Date, default: Date.now}
});


//Model
const userModel= model("User", userSchema);

module.exports = userModel;