import { readFileSync } from "node:fs";
import { pool } from "../../database/database.js";
import type { Vocation } from "../../model/vocation.js";

const requests = readFileSync(
    './src/scripts/SQL/initDB.sql',
    {encoding: "utf-8"}
);

const vocations: Vocation[] = JSON.parse(readFileSync(
    './src/scripts/SQL/vocations.json',
    {encoding: "utf-8"}
))


try {
    await pool.query(requests, []);
    
    const query = `
        INSERT INTO vocation (id, name, description, main_weapon, sub_weapon) 
        VALUES ${vocations.map((vocation, i) => `(${i}, '${vocation.name}', '${vocation.description}', ${0}, ${null})`).join(", ")}
    `;
    console.log("QUERY: ", query);

    await pool.query(query, []);
    const res = await pool.query("SELECT * FROM vocation", []);
    console.log(res.rows);
    console.log("done");
} catch (e) {
    console.error(e);
}