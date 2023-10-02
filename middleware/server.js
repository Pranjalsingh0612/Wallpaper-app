const express = require("express");
const app = express();

//create middleware
const logger=(req,res,next)=>{
    //any logic
    console.log("AM a logger middleware");
};

//use middleware
app.use(logger);

//Home route
app.get("/",(req,res)=>{
    res.send("Hello world");
});

//login route
app.post("/login",(req,res)=>{
    res.send("Login successful");
});

//@Role:Authenticated user
//create post request
app.post("/create-post",(req,res)=>{
    res.json({
        message: "Post Created",
    });
});

//@Role: Public use
//Fetch all posts
app.get("/posts",(req,res)=>{
    res.json({
        message:"Posts Fetched",
    });
});

//@Role: Admin
//Delete post
app.delete("/posts",(req,res)=>{
    res.json({
        message:"Post Deleted",
    });
});

//start server
app.listen(9000,console.log("Server is running on port 9000"))
