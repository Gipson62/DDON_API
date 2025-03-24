import 'dotenv/config';
import pg from 'pg';

export const pgPool = new pg.Pool({
    host: process.env.HOSTDB,
    user: process.env.USERDB,
    password: process.env.PASSWORDDB,
    //database: process.env.DBNAME,
    port: 5432,
});

export const pool = {
    connect: async () => {
        try {
            const client = await pgPool.connect();
            return {
                query : async (query: pg.QueryArrayConfig<any>, params: any): Promise<pg.QueryArrayResult<any[]>> => {
                    try {
                        return await client.query(query, params);
                    } catch (e) {
                        console.error(e);
                        throw e;
                    }
                },
                release : (): void => {
                    return client.release();
                }
            };
        } catch (e){
            console.error(e);
            throw e;
        }
    },
    query: async (query: any, params: any): Promise<pg.QueryArrayResult<any[]>> => {
        try {
            return await pgPool.query(query, params);
        } catch (e) {
            console.error(e);
            throw e;
        }
    },
    end : (): Promise<void> => {
        return pgPool.end();
    }
};

process.on('exit', () => {
    pgPool.end().then(() => console.log('pool closed'));
});