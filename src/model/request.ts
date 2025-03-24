import express from "express";
import type { Permission } from "./permission.js";
import type { int } from "./statistics.js";

export interface DDON_Request extends express.Request {
    user?: {
        userId: string;
        email: string;
    };
    perm?: Permission;
}