const express = require("express");
const { createServer } = require("http");
const socket = require("socket.io");

const app = express();
const httpServer = createServer(app);
const io = new socket.listen(httpServer);

app.route("/").get((req, res) => {
    res.json("Hey there!!! This is Code with Tito for NodeJS.");
});

io.on("connection", (user) => {
    console.log(user.id, " connected successfully.");

    io.on("disconnect", () => {
        console.log(user.id, "is disconnected.");
    });
});

httpServer.listen(3000);