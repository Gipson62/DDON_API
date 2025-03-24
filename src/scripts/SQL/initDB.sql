DROP TABLE IF EXISTS Crest;
DROP TABLE IF EXISTS Augment;
DROP TABLE IF EXISTS Skill;
DROP TABLE IF EXISTS WeaponVocation;
DROP TABLE IF EXISTS Weapon;
DROP TABLE IF EXISTS BuffStatistics;
DROP TABLE IF EXISTS MainStatistic;
DROP TABLE IF EXISTS Tag;
DROP TABLE IF EXISTS ArrowKind;
DROP TABLE IF EXISTS ArmorKind;
DROP TABLE IF EXISTS Vocation;
DROP TABLE IF EXISTS WeaponKind;
CREATE TABLE WeaponKind (
    -- Hardcoded IDs because they are not expected to change
    -- and no way to add new ones
    id              integer PRIMARY KEY, 
    "name"          text NOT NULL,
    "description"   text NOT NULL
);
INSERT INTO WeaponKind (id, "name", "description") VALUES
(0, 'One-handed Sword', '[PlaceHolder]'), (1, 'Shield', '[PlaceHolder]'), (2, 'Bow', '[PlaceHolder]'), 
(3, 'Staff', '[PlaceHolder]'), (4, 'Greatshield', '[PlaceHolder]'), (5, 'Rod', '[PlaceHolder]'), 
(6, 'Daggers', '[PlaceHolder]'), (7, 'Archistaff', '[PlaceHolder]'), (8, 'Magick Bow', '[PlaceHolder]'),
(9, 'Greatsword', '[PlaceHolder]'), (10, 'Magick Gauntlet', '[PlaceHolder]'), (11, 'Spirit Lance', '[PlaceHolder]'),
(12, 'Magick Sword', '[PlaceHolder]');

CREATE TABLE ArmorKind (
    -- Hardcoded IDs because they are not expected to change
    -- and no way to add new ones
    id              integer PRIMARY KEY, 
    "name"          text NOT NULL,
    "description"   text NOT NULL
);
INSERT INTO ArmorKind (id, "name", "description") VALUES 
(0, 'Head Armor', '[PlaceHolder]'), (1, 'Body Armor', '[PlaceHolder]'), (2, 'Arm Armor', '[PlaceHolder]'), 
(3, 'Leg Armor', '[PlaceHolder]'), (4, 'Body Clothing', '[PlaceHolder]'), (5, 'Legwear', '[PlaceHolder]'), 
(6, 'Overwear', '[PlaceHolder]'), (7, 'Jewelry', '[PlaceHolder]');

-- Specific for the Hunter vocation
CREATE TABLE ArrowKind (
    -- Hardcoded IDs because they are not expected to change
    -- and no way to add new ones
    -- They also correspond to the IR of the item
    id              integer PRIMARY KEY, 
    "name"          text NOT NULL,
    "description"   text NOT NULL
);
INSERT INTO ArrowKind (id, "name", "description") VALUES
(1, 'Poison Arrow', 'An arrow used by Hunters that can inflict the Poisoned debilitation on enemies. Can be purchased from merchants or crafted.'),
(3, 'Oil Arrow', 'An arrow used by Hunters that can inflict the Tarring debilitation on enemies. Can be purchased from merchants or crafted.'),
(4, 'Sleeper Arrow', 'An arrow used by Hunters that can inflict the Sleep debilitation on enemies. Can be purchased from merchants or crafted.'),
(5, 'Silencer Arrow', 'An arrow used by Hunters that can inflict the Silenced debilitation on enemies. Can be purchased from merchants or crafted.'),
(6, 'Asininity Arrow', 'An arrow used by Hunters that can inflict the Torpor debilitation on enemies. Can be purchased from merchants or crafted.');

CREATE TABLE Vocation (
    id              integer PRIMARY KEY,
    "name"          TEXT NOT NULL UNIQUE,
    main_weapon     integer NOT NULL REFERENCES WeaponKind(id),
    -- NULL if no sub weapon
    sub_weapon      integer REFERENCES WeaponKind(id),
    "description"   text NOT NULL
);
-- INSERT INTO Vocation ("name", main_weapon, sub_weapon, "description") VALUES 
-- ('Fighter', 0, 1, 'Balances offense and defense in battle. Can use their shield to counter attacks. The leader of the Battlefield.'),
-- ('Hunter', 2, NULL, 'Able to deal precise damage from long distances. Has a variety of support abilities by the use of special arrows. The Sniper of the Battlefield.'),
-- ('Priest', 3, NULL, 'Supports the party with healing and support magick. Can not only heal, but also reveal weaknesses of enemies. The Pillar of the Battlefield.'),
-- ('Shieldsage', 4, 5, 'Attracts attention and protects others with their strong defense. Convert the power of their enemis into magick of the five elements to attack and support. The Fortress of the Battlefield.'),
-- ('Seeker', 6, NULL, 'An acrobat who excels at hit and run tactics. Uses a rope to instantly move to the blind spot of large enemies. The Gale of the Battlefield.'),
-- ('Sorcerer', 7, NULL, 'Magician who commands great magick to cause greater harm. Can enhance magick by chanting, but needs to be protected. The Calamity of the Battlefield.'),
-- ('Element Archer', 8, NULL, 'Mysterious archer who manipulates magick into their magick bow. They can attack enemies, supports alliers and show the weak points of enemies. They Eyes of the Battlefield.'),
-- ('Warrior', 9, NULL, 'Endures pain to deliver even greater damage to their enemies. One swing of their huge sword can even bury enemies. The Behemoth of the Battlefield.'),
-- ('Alchemist', 10, NULL, 'Soldier who attracks the enemies'' attention using alchemy and high mobility. Uses the secret of alchemy to inflict and manipulate status abnormalities. The Trickster of the Battlefield.'),
-- ('Spirit Lancer', 11, NULL, 'A warrior blessed and protected by the spirits. With their spirit spear they can heal, lead and support the party. The Druid of the Battlefield.'),
-- ('High Scepter', 12, NULL, 'A magical swordsman who uses his sword to take his enemies'' magic into his own hands. Transforms magic into offensive and defensive magic. He shines by overturning the battle situation in various situations.');

CREATE TABLE Tag (
    id              integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "name"          text NOT NULL
);
INSERT INTO Tag ("name") VALUES 
('Physical'),   ('Magical'),    ('Support'),    ('Heal'),       ('Debuff'),     ('Buff'), 
('Tank'),       ('DPS'),        ('Mid Game'),   ('Late Game'),  ('Early Game'), ('Preview Build'); -- "Preview Build" is for builds that are not yet released

CREATE TABLE MainStatistic (
    id              integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    max_health      smallint NOT NULL,
    max_stamina     smallint NOT NULL,
    physical_atk    smallint NOT NULL,
    magick_atk      smallint NOT NULL,
    physical_def    smallint NOT NULL,
    magick_def      smallint NOT NULL,
    strength        smallint NOT NULL,
    magick          smallint NOT NULL,
    blow_power      smallint NOT NULL,
    endurance       smallint NOT NULL,
    chance_attack   smallint NOT NULL,
    healing_power   smallint NOT NULL,
    exhaust_attack  smallint NOT NULL,
    knockout_power  smallint NOT NULL,
    "weight"        smallint NOT NULL
);

CREATE TABLE BuffStatistics (
    id                          integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    guard_power                 smallint NOT NULL,
    max_force_stock             smallint NOT NULL,
    blocking_stamina_reduce     smallint NOT NULL,
    max_loaded_arrows           smallint NOT NULL,

    -- Slayers Status (Increases damage against specific enemies)
    giant_slayer                smallint NOT NULL,
    dragon_slayer               smallint NOT NULL,
    demon_slayer                smallint NOT NULL,
    spirit_slayer               smallint NOT NULL,
    corrupted_slayer            smallint NOT NULL,
    skeleton_slayer             smallint NOT NULL,
    undead_slayer               smallint NOT NULL,
    war_ready_slayer            smallint NOT NULL,
    demihuman_slayer            smallint NOT NULL,
    beast_slayer                smallint NOT NULL,
    demon_kin_slayer            smallint NOT NULL,
    winged_slayer               smallint NOT NULL,
    formless_slayer             smallint NOT NULL,
    cursed_slayer               smallint NOT NULL,
    golem_slayer                smallint NOT NULL,
    alchemy_slayer              smallint NOT NULL,

    -- Inflict Status
    inflict_blind               smallint NOT NULL, -- Inflicts Blind (Decreases Accuracy)
    inflict_golden              smallint NOT NULL, -- Inflicts Golden (Decreases Magick Defense???)
    inflict_petrification       smallint NOT NULL, -- Inflicts Petrification (Can't move but standing as rock???)
    inflict_frozen_solid        smallint NOT NULL, -- Inflicts Frozen Solid (Can't move but standing as an ice block???)
    inflict_holy_drain          smallint NOT NULL, -- Inflicts Holy Drain (Drains HP)
    inflict_torpor              smallint NOT NULL, -- Inflicts Torpor (Slows down Stamina Recovery)
    inflict_frail               smallint NOT NULL, -- Inflicts Frail (Physical Defense Down)
    inflict_sleep               smallint NOT NULL, -- Inflicts Sleep (Can't move but on the ground???)
    inflict_tarring             smallint NOT NULL, -- Inflicts Tarring (Decreases Fire Resistance???)
    inflick_shock               smallint NOT NULL, -- Inflicts Shock (Decreases Thunder Resistance???)
    -- Removes Resistance
    inflict_holy_res_down       smallint NOT NULL, -- Removes Holy Resistance
    inflict_ice_res_down        smallint NOT NULL, -- Removes Ice Resistance
    inflict_thunder_res_down    smallint NOT NULL, -- Removes Thunder Resistance
    inflict_dark_res_down       smallint NOT NULL, -- Removes Dark Resistance
    inflict_physical_res_down   smallint NOT NULL, -- Removes Physical Resistance
    inflict_magick_res_down     smallint NOT NULL, -- Removes Magick Resistance

    -- Resistance Status
    resist_blind                smallint NOT NULL,
    resist_golden               smallint NOT NULL,
    resist_petrification        smallint NOT NULL,
    resist_frozen_solid         smallint NOT NULL,
    resist_torpor               smallint NOT NULL,
    resist_poison               smallint NOT NULL,
    resist_curse                smallint NOT NULL,
    resist_knockout             smallint NOT NULL,
    resist_skill_stifling       smallint NOT NULL,
    resist_shock                smallint NOT NULL,
    resist_drenching            smallint NOT NULL,
    resist_sleep                smallint NOT NULL,
    resist_tarring              smallint NOT NULL,
    resist_catching_fire        smallint NOT NULL,
    -- Resistance to a specific kind of damage
    thunder_res                 smallint NOT NULL,
    dark_res                    smallint NOT NULL,
    holy_res                    smallint NOT NULL,
    fire_res                    smallint NOT NULL,
    ice_res                     smallint NOT NULL,
    corruption_res              smallint NOT NULL,
    -- Resist the status that drains the resistance
    resist_holy_res_down        smallint NOT NULL,
    resist_physical_res_down    smallint NOT NULL,
    resist_magick_res_down      smallint NOT NULL
);

CREATE TABLE Weapon (
    id              integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "name"          text NOT NULL,
    kind            integer NOT NULL REFERENCES WeaponKind(id),
    "description"   text NOT NULL,
    -- The main statistic of the weapon
    -- Can't be null as opposed to BuffStatistics
    main_statistic  integer NOT NULL REFERENCES MainStatistic(id),
    buff_stats      integer REFERENCES BuffStatistics(id)
);

CREATE TABLE WeaponVocation (
    weapon_id       integer NOT NULL REFERENCES Weapon(id),
    vocation_id     integer NOT NULL REFERENCES Vocation(id),
    PRIMARY KEY (weapon_id, vocation_id)
);

CREATE TABLE Skill ( -- Active skills
    id              integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "name"          text NOT NULL UNIQUE,
    "description"   text NOT NULL,
    vocation_id     integer NOT NULL REFERENCES Vocation(id) -- Can't be null as opposed to Augment
);

CREATE TABLE Augment ( -- Passive skills
    id              integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "name"          text NOT NULL UNIQUE,
    "description"   text NOT NULL,
    vocation_id     integer REFERENCES Vocation(id) -- Optional, NULL if universal
);

CREATE TABLE CREST (
    "name"          text NOT NULL
);
