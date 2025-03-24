import prisma from "../database/databaseORM.js";
import { Permission } from "../model/permission.js";
import type { DDON_Request } from "../model/request.js";
import { verifyToken } from "./jwtUtils.js";
import express from "express";

export const authenticateToken = (req: DDON_Request, res: express.Response, next: () => any) => {
    const authHeader = req.headers.authorization;

    if (!authHeader) {
        return res.status(403).json({ message: "Token is required." });
    }

    const token = authHeader.split(" ")[1];
    if (!token) 
        return res.status(403).json({ message: "Token is required." });

    try {
        const decoded = verifyToken(token);
        req.user = decoded;
        next();
    } catch (err) {
        return res.status(401).json({ message: "Invalid or expired token." });
    }
};

// Admins don't exist in the database yet
/*export const authenticateAdmin = async (req: DDON_Request, res: express.Response, next: () => any) => {
    if (!req.user)
        return res.status(403).json({ message: "Token is required." });
    
    try {
        const admin = await prisma.admin.findUnique({
            where: {
                email: req.user.email
            }
        });
        if (admin) {
            req.perm = Permission.Admin;
        } else {
            req.perm = Permission.Self;
        }
        next();
    } catch (err) {
        console.log(err);
    }
};*/