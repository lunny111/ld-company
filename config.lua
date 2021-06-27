itemList = {"packaged_chicken2", "portakal_suyu", "domates", "sogan", "marul", "patates", "tuz", "domates_suyu", "havuc", "atom", "ekmek", "ketcap", "kiyma", "sosis","tburgerxl", "tburgers", "tburgerm", "tburgerl", "tacoxl", "tacot", "tacos", "tacok", "sogan2", "patates2", "marul2", "hotdogxl", "hotdogs", "hotdogm", "hotdogl","friesxl", "friess", "friesm", "friesl", "domates2", "burgerxl", "burgers", "burgerm", "burgerl"}

blips = {
    ["hotdog"] = {
        ["coord"] = vector3(45.065189361572, -1002.4287719727, 29.285171508789),
        ["name"] = "Chihuahua Hotdogs",
        ["sprite"] = 104,
    },
    ["taco"] = {
        ["coord"] = vector3(415.54870605469, -1911.9406738281, 25.471221923828),
        ["name"] = "Taco Libre",
        ["sprite"] = 208,
    },
    ["chicken"] = {
        ["coord"] = vector3(-518.66815185547, -694.70562744141, 33.167949676514),
        ["name"] = "Cluckin Bell",
        ["sprite"] = 89,
    },
    ["burger"] = {
        ["coord"] = vector3(-1189.6739501953, -888.65936279297, 13.995300292969),
        ["name"] = "Burger Shoot",
        ["sprite"] = 106,
    },
}

-- Kesilebilir
cuttingItems = {
    ["domates2"] = "domates",
    ["sogan2"] = "sogan",
    ["marul2"] = "marul",
    ["patates2"] = "patates",
    ["ketcap"] = "domates",
    ["sosis"] = "kiyma",
}

cuttingCoords = {
    ["taco"] = vector3(427.39392089844, -1918.5316162109, 25.471242904663),
    ["hotdog"] = vector3(44.624305725098, -1006.6956176758, 29.287910461426),
    ["chicken"] = vector3(-520.34436035156, -702.67260742188, 33.172496795654),
    ["burger"] = vector3(-1200.5089111328, -900.77117919922, 13.995230674744),
}


-- Patates Kızartması
frieItem = {
    ["friess"] = {
        ["patates2"] = 1,
        ["tuz"] = 1
    },
    ["friesm"] = {
        ["patates2"] = 2,
        ["tuz"] = 1
    },
    ["friesl"] = {
        ["patates2"] = 3,
        ["tuz"] = 1
    },
    ["friesxl"] = {
        ["patates2"] = 4,
        ["tuz"] = 1
    },
}

friesCoords = {
    ["taco"] = vector3(417.69107055664, -1918.9669189453, 25.471240997314),
    ["hotdog"] = vector3(41.027584075928, -1008.0799560547, 29.28670501709),
    ["chicken"] = vector3(-521.47552490234, -700.89337158203, 33.172496795654),
    ["burger"] = vector3(-1201.74609375, -899.21179199219, 13.995308876038),
}

-- İçecekler
drinkItem = {
    ["atom"] = {
        ["portakal_suyu"] = 1,
        ["domates_suyu"] = 1,
        ["havuc"] = 1
    },
}

drinkCoords = {
    ["taco"] = vector3(418.78067016602, -1917.7169189453, 25.471240997314),
    ["hotdog"] = vector3(45.46524810791, -1009.8017578125, 29.487492752075),
    ["chicken"] = vector3(-514.36358642578, -699.26538085938, 33.372481536865),
    ["burger"] = vector3(-1199.0432128906, -895.92626953125, 14.295237350464),
}

-- Yiyecekler
foodItems = {
    ["taco"] = {
        ["tacos"] = { 
            ["domates2"] = 1,
            ["kiyma"] = 1,
            ["sogan2"] = 1,
        },
        ["tacok"] = { 
            ["domates2"] = 1,
            ["kiyma"] = 2,
            ["sogan2"] = 1,
            ["tuz"] = 1,
        },
        ["tacot"] = { 
            ["domates2"] = 1,
            ["packaged_chicken2"] = 2,
            ["sogan2"] = 1,
            ["tuz"] = 1,
        },
        ["tacoxl"] = { 
            ["domates2"] = 2,
            ["packaged_chicken2"] = 2,
            ["kiyma"] = 2,
            ["sogan2"] = 1,
            ["tuz"] = 1,
        }
    },
    ["hotdog"] = {
        ["hotdogs"] = { 
            ["ekmek"] = 1,
            ["sosis"] = 1,
            ["marul2"] = 1,
        },
        ["hotdogm"] = { 
            ["ekmek"] = 1,
            ["sosis"] = 2,
            ["marul2"] = 1,
            ["ketcap"] = 1,
        },
        ["hotdogl"] = { 
            ["ekmek"] = 1,
            ["sosis"] = 2,
            ["marul2"] = 2,
            ["ketcap"] = 1,
        },
        ["hotdogxl"] = { 
            ["ekmek"] = 1,
            ["sosis"] = 2,
            ["marul2"] = 2,
            ["ketcap"] = 2,
            ["sogan2"] = 1,
        }
    },
    ["chicken"] = {
        ["tburgers"] = {
            ["packaged_chicken2"] = 1,
            ["sogan2"] = 1,
            ["marul2"] = 1,
        },
        ["tburgerm"] = {
            ["packaged_chicken2"] = 1,
            ["sogan2"] = 2,
            ["marul2"] = 2,
        },
        ["tburgerl"] = {
            ["packaged_chicken2"] = 2,
            ["sogan2"] = 2,
            ["marul2"] = 2,
            ["tuz"] = 1,
        },
        ["tburgerxl"] = {
            ["packaged_chicken2"] = 2,
            ["sogan2"] = 2,
            ["marul2"] = 2,
            ["tuz"] = 1,
            ["domates2"] = 2
        }
    },
    ["burger"] = {
        ["burgers"] = { 
            ["domates2"] = 1,
            ["sogan2"] = 1,
            ["marul2"] = 1,
            ["kiyma"] = 1,
            ["ekmek"] = 1,
        },
        ["burgerm"] = {
            ["domates2"] = 1,
            ["sogan2"] = 1,
            ["marul2"] = 1,
            ["kiyma"] = 2,
            ["ekmek"] = 1,
        },
        ["burgerl"] = { 
            ["domates2"] = 2,
            ["sogan2"] = 1,
            ["marul2"] = 1,
            ["kiyma"] = 3,
            ["ekmek"] = 1,
        },
        ["burgerxl"] = { 
            ["domates2"] = 2,
            ["sogan2"] = 2,
            ["marul2"] = 2,
            ["kiyma"] = 3,
            ["ekmek"] = 1,
        }
    },
}

foodCoords = {
    ["taco"] = vector3(425.35290527344, -1920.9470214844, 25.471242904663),
    ["hotdog"] = vector3(42.253612518311, -1008.5904541016, 29.286949157715),
    ["chicken"] = vector3(-516.48602294922, -700.26129150391, 33.172481536865),
    ["burger"] = vector3(-1202.8441162109, -897.39373779297, 13.995230674744),
}

-- Depo
storageCoord = {
    ["taco"] = vector3(424.16546630859, -1921.7279052734, 25.471240997314),
    ["hotdog"] = vector3(43.676856994629, -1008.8042602539, 29.287187576294),
    ["chicken"] = vector3(-514.86962890625, -702.70434570312, 33.167930603027),
    ["burger"] = vector3(-1203.4822998047, -895.89953613281, 13.995308876038),
    ["popsdiner"] = vector3(1585.931640625, 6459.7778320312, 26.014015197754),
}

-- Tezgah
tableCoord = {
    ["taco"] = vector3(417.76370239258, -1915.0740966797, 25.671240997314),
    ["hotdog"] = vector3(43.849662780762, -1004.7572631836, 29.287828445435),
    ["chicken"] = vector3(-517.83465576172, -697.71929931641, 33.167991638184),
    ["burger"] = vector3(-1195.0285644531, -892.33166503906, 13.995308876038),
    ["popsdiner"] = vector3(1590.6541748047, 6455.2075195312, 26.014015197754),
}

-- Tezgah 2
tableCoord1 = {
    ["burger"] = vector3(-1193.82, -907.189, 14.006),
}

--Patron
bossCoord = {
    ["taco"] = vector3(423.06506347656, -1917.2591552734, 25.022441482544),
    ["hotdog"] = vector3(41.347591400146, -1004.6605834961, 29.287342071533),
    ["chicken"] = vector3(-512.37713623047, -702.65057373047, 33.167987823486),
    ["burger"] = vector3(-1192.1845703125, -901.13385009766, 13.998950004578),
    ["popsdiner"] = vector3(1595.248046875, 6455.6264648438, 26.014039993286),
}