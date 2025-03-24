import type { BuffStatistics, ID, MainStatistics } from "./statistics.js";

export interface Weapon {
    id          : ID
    name        : string
    kind        : WeaponKind
    description : string
    main_stat   : MainStatistics
    buff_stat   : BuffStatistics
}

export enum WeaponKind {
    OneHandedSword,
    Shield,
    Bow,
    Staff,
    GreatShield,
    Rod,
    Daggers,
    Archistaff,
    MagickBow,
    GreatSword,
    MagickGauntlet,
    SpiritLance,
    MagickSword
}