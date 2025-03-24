import prisma from "../database/databaseORM.js";
import { verifyToken } from "./jwtUtils.js";

export const Permission = {
    Admin: "Admin",
    Self: "Self"
};

export const authenticateToken = (req, res, next) => {
    const authHeader = req.headers.authorization;

    if (!authHeader) {
        return res.status(403).json({ message: "Token is required." });
    }

    const token = authHeader.split(" ")[1];

    try {
        const decoded = verifyToken(token);
        req.user = decoded;
        next();
    } catch (err) {
        return res.status(401).json({ message: "Invalid or expired token." });
    }
};

export const authenticateAdmin = async (req, res, next) => {
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
};