import { Router } from 'express';

const router = Router();

const v1Router = Router();

router.use('/v1', v1Router);

export default router;