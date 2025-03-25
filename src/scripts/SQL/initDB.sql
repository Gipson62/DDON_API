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
    "name"          text NOT NULL PRIMARY KEY,
    "description"   text NOT NULL
);

CREATE TABLE ArmorKind (
    -- Hardcoded IDs because they are not expected to change
    -- and no way to add new ones
    "name"          text NOT NULL PRIMARY KEY,
    "description"   text NOT NULL
);

-- Specific for the Hunter vocation
CREATE TABLE ArrowKind (
    -- Hardcoded IDs because they are not expected to change
    -- and no way to add new ones
    -- They also correspond to the IR of the item
    "name"          text NOT NULL,
    "description"   text NOT NULL
);
INSERT INTO ArrowKind ("name", "description") VALUES
('Poison Arrow', 'An arrow used by Hunters that can inflict the Poisoned debilitation on enemies. Can be purchased from merchants or crafted.'),
('Oil Arrow', 'An arrow used by Hunters that can inflict the Tarring debilitation on enemies. Can be purchased from merchants or crafted.'),
('Sleeper Arrow', 'An arrow used by Hunters that can inflict the Sleep debilitation on enemies. Can be purchased from merchants or crafted.'),
('Silencer Arrow', 'An arrow used by Hunters that can inflict the Silenced debilitation on enemies. Can be purchased from merchants or crafted.'),
('Asininity Arrow', 'An arrow used by Hunters that can inflict the Torpor debilitation on enemies. Can be purchased from merchants or crafted.');

CREATE TABLE Vocation (
    "name"          text NOT NULL UNIQUE,
    main_weapon     text NOT NULL REFERENCES WeaponKind("name"),
    -- NULL if no sub weapon
    sub_weapon      text REFERENCES WeaponKind("name"),
    "description"   text NOT NULL
);

CREATE TABLE Tag (
    "name"          text NOT NULL PRIMARY KEY
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
    kind            text NOT NULL REFERENCES WeaponKind("name"),
    "description"   text NOT NULL,
    -- The main statistic of the weapon
    -- Can't be null as opposed to BuffStatistics
    main_statistic  integer NOT NULL REFERENCES MainStatistic(id),
    buff_stats      integer REFERENCES BuffStatistics(id)
);

CREATE TABLE WeaponVocation (
    weapon          text NOT NULL REFERENCES WeaponKind("name"),
    vocation        text NOT NULL REFERENCES Vocation("name"),
    PRIMARY KEY (weapon, vocation)
);

CREATE TABLE Skill ( -- Active skills
    id              integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "name"          text NOT NULL UNIQUE,
    "description"   text NOT NULL,
    vocation_id     text NOT NULL REFERENCES Vocation("name") -- Can't be null as opposed to Augment
);

CREATE TABLE Augment ( -- Passive skills
    id              integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    "name"          text NOT NULL UNIQUE,
    "description"   text NOT NULL,
    vocation_id     text REFERENCES Vocation("name") -- Optional, NULL if universal
);

CREATE TABLE CREST (
    "name"          text NOT NULL
);
