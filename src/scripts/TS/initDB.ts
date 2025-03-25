import { readFileSync } from "node:fs";
import { pool } from "../../database/database.js";
import type { Vocation } from "../../model/vocation.js";
import { existsSync } from "node:fs";
import type { WeaponKind } from "../../model/weapon.js";
import type { ArmorKind } from "../../model/armor_kind.js";

const init_db_query = readFileSync(
    './src/scripts/SQL/initDB.sql',
    {encoding: "utf-8"}
);

const weapon_kinds: WeaponKind[] = JSON.parse(readFileSync(
    './src/data/static/weapon_kind.json',
    {encoding: "utf-8"}
));

const armor_kinds: ArmorKind[] = JSON.parse(readFileSync(
    './src/data/static/armor_kind.json',
    {encoding: "utf-8"}
));

const vocations: Vocation[] = JSON.parse(readFileSync(
    './src/data/static/vocations.json',
    {encoding: "utf-8"}
))


try {
    await pool.query(init_db_query, []);
    
    const weapon_kinds_insert_query = `
        INSERT INTO WeaponKind (name, description)
        VALUES ${weapon_kinds.map((weapon, _) => `('${weapon.name}', '${weapon.description}')`).join(", ")}
    `;
    await pool.query(weapon_kinds_insert_query, []);

    const armor_kinds_insert_query = `
        INSERT INTO ArmorKind (name, description)
        VALUES ${armor_kinds.map((armor, _) => `('${armor.name}', '${armor.description}')`).join(", ")}
    `;
    await pool.query(armor_kinds_insert_query, []);

    const vocations_insert_query = `
        INSERT INTO vocation (name, description, main_weapon, sub_weapon) 
        VALUES ${vocations.map((vocation, _) => `('${vocation.name}', '${vocation.description}', '${vocation.main_weapon}', ${vocation.sub_weapon == null ? null : `'${vocation.sub_weapon}'`})`).join(", ")}
    `;

    await pool.query(vocations_insert_query, []);
    const res = await pool.query(`
        SELECT v.*, w1.name as main_weapon_name, w2.name as sub_weapon_name
        FROM vocation v
        LEFT JOIN WeaponKind w1 ON v.main_weapon = w1.name
        LEFT JOIN WeaponKind w2 ON v.sub_weapon = w2.name
    `, []);
    console.log(res.rows);
    console.log("done");
} catch (e) {
    console.error(e);
}