import { Router } from 'express';
import { default as v1VocationRouter } from './v1/vocation.js';

const router = Router();

const v1Router = Router();

v1Router.use('/vocation', v1VocationRouter);

router.use('/v1', v1Router);

export default router;