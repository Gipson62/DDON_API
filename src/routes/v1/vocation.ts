import Router from "express-promise-router";
import { 
    getAllVocations, 
    getVocationById, 
    getVocationByName 
} from "../../controller/vocation.js";

const router = Router();

router.get('/', getAllVocations);
router.get('/:id', getVocationById);
router.get('/name/:name', getVocationByName);

export default router;