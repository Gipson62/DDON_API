import type { ID } from "./statistics.js";
import type { WeaponKind } from "./weapon.js";

export interface Vocation {
    id: ID;
    name: string;
    description: string;
    main_weapon: WeaponKind;
    sub_weapon: WeaponKind | null;
}