const router = require('express').Router();
const userModel= require('./../models/user_model');
const bcrypt=require('bcrypt');

router.post("/createaccount", async function(req, res){
    const userData=req.body;
    //Encrypt the password
    const password = userData.password;
    const salt=await bcrypt.genSalt(10);
    const hashedPassword=await bcrypt.hash(password,salt);

    userData.password=hashedPassword;



    const newUser= new userModel(userData);
    await newUser.save(function(err){
        if(err){
            res.json({success: false, error: err});
            return;
        }
        res.json({success: true, data: newUser});
    });
});

module.exports = router;