import prisma from "../database/databaseORM.js";
import type { DDON_Request } from "../model/request.js";
import express from 'express';

export const getAllVocations = async (_req: DDON_Request, res: express.Response) => {
    try {
        const vocations = await prisma.vocation.findMany();
        res.status(200).json(vocations);
    } catch (e) {
        console.error(e);
        res.status(500).json({error: "Internal Server Error"});
    }
}

export const getVocationById = async (req: DDON_Request, res: express.Response) => {
    if (req.params.id === undefined) {
        res.status(400).json({error: "Bad Request"});
        return;
    }
    try {
        const vocation = await prisma.vocation.findUnique({
            where: {
                id: parseInt(req.params.id)
            }
        });
        if (vocation === null) {
            res.status(404).json({error: "Vocation not found"});
        } else {
            res.status(200).json(vocation);
        }
    } catch (e) {
        console.error(e);
        res.status(500).json({error: "Internal Server Error"});
    }
}

export const getVocationByName = async (req: DDON_Request, res: express.Response) => {
    if (req.params.name === undefined) {
        res.status(400).json({error: "Bad Request"});
        return;
    }
    try {
        const vocation = await prisma.vocation.findUnique({
            where: {
                name: req.params.name
            }
        });
        if (vocation === null) {
            res.status(404).json({error: "Vocation not found"});
        } else {
            res.status(200).json(vocation);
        }
    } catch (e) {
        console.error(e);
        res.status(500).json({error: "Internal Server Error"});
    }
}