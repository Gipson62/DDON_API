import express from "express";
import {default as Router} from "./routes/index.js";
import internalIp from 'internal-ip';

const internalIP = internalIp.v4.sync();

const app = express();
const port = 3001;

app.use(express.json());
app.use(Router);
if (internalIP === undefined) 
    console.log("Internal IP not found");
else
    app.listen(port, internalIP, () => {
        console.log(`Example app listening at adress: http://${internalIP}:${port}`);
    });