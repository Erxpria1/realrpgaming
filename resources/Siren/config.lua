-- Sitemiz : https://sparrow-mta.blogspot.com/

-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://www.youtube.com/@TurkishSparroW/

-- Discord : https://discord.gg/DzgEcvy

config = {
    ["Mensagem Start"] = true, --Caso esteja false ele não irá aparecer a mensagem!
    ["VTR's Allowed"] = {
        [596] = {
            ["Volume"] = 0.3,
            ["Distância"] = 10,
        },     
        [597] = {
            ["Volume"] = 0.3,
            ["Distância"] = 10,
        },  
        [598] = {
            ["Volume"] = 0.3,
            ["Distância"] = 10,
        },     
        [523] = {
            ["Volume"] = 0.3,
            ["Distância"] = 10,
        },  
        [578] = {
            ["Volume"] = 0,
            ["Distância"] = 0,
        },  
        [525] = {
            ["Volume"] = 0.0,
            ["Distância"] = 0,
        },   
        [416] = {
            ["Volume"] = 0.3,
            ["Distância"] = 10,
        },                                                                                       
    },
    Sirene = {
        {""}, -- Giroflex
        {"files/sounds/police_sirena.mp3"}, -- Sirene
        {"files/sounds/horn.mp3"}, -- Buzina
    },
    car_lights_table = {
        [596] = {["mode"]="lamp", --gtr
            [1]={["pos"]={0.0, -0.00, 1}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0},
            [2]={["pos"]={-0.25, -0.10, 1}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0}, 
            [3]={["pos"]={0.25, -0.10, 1}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0},
            [4]={["pos"]={-0.45, -0.20, 1}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0}, 
            [5]={["pos"]={0.45, -0.20, 1}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0},
            [6]={["pos"]={-0.45, -0.30,1}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0}, 
            [7]={["pos"]={0.45, -0.30, 1}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0},
        }, 
        [597] = {["mode"]="lamp", --TrailBlazer
            [1]={["pos"]={-0.25, 0.25, 0.78}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0}, 
            [2]={["pos"]={0.25, 0.25, 0.78}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0},
            [3]={["pos"]={-0.45, 0.15, 0.78}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0}, 
            [4]={["pos"]={0.45, 0.15, 0.78}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0},
            [5]={["pos"]={0.0, 0.35, 0.78}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0},
            [6]={["pos"]={-0.45, 0.10, 0.78}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0}, 
            [7]={["pos"]={0.45, 0.10, 0.78}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0},
            [8]={["pos"]={-0.45, 0.05, 0.78}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0}, 
            [9]={["pos"]={0.45, 0.05, 0.78}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0},
        },  
        [598] = {["mode"]="lamp", --Amarok sem capota
            [1]={["pos"]={0.0, -0.00, 0.7}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0},
            [2]={["pos"]={-0.25, -0.10, 0.7}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0}, 
            [3]={["pos"]={0.25, -0.10, 0.7}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0},
            [4]={["pos"]={-0.45, -0.20, 0.7}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0}, 
            [5]={["pos"]={0.45, -0.20, 0.7}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0},
            [6]={["pos"]={-0.45, -0.30, 0.7}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0}, 
            [7]={["pos"]={0.45, -0.30, 0.7}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0},
        }, 
        [523] = {["mode"]="lamp", --rocam certa   
        [1]={["pos"]={-0.45, 0.53, 0.2}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0}, 
        [2]={["pos"]={0.45, 0.53, 0.2}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0}, 
        },
        [578] = {["mode"]="lamp", --mec guincho
            [1]={["pos"]={0.0, 0.9 --[[Menos pra trás, mais pra frente]], 1.8 --[[Mais pra cima, menos pra baixo]]}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0},
            [2]={["pos"]={-0.2, 0.9, 1.8}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0},
            [3]={["pos"]={0.2, 0.9, 1.8}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0},
            [4]={["pos"]={0.0, 0.9 --[[Menos pra trás, mais pra frente]], 1.8 --[[Mais pra cima, menos pra baixo]]}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0},
            [5]={["pos"]={-0.2, 0.9, 1.8}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0},
            [6]={["pos"]={-0.4, 0.9, 1.8}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0},
            [7]={["pos"]={0.2, 0.9, 1.8}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0},
            [8]={["pos"]={0.4, 0.9, 1.8}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0},
            [9]={["pos"]={0.6, 0.9, 1.8}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0},
            [10]={["pos"]={-0.6, 0.9, 1.8}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0}, 
        },    
        [416] = {["mode"]="lamp", --samu curvada certa
            [1]={["pos"]={-0.70, 0.30, 1.9}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0},
            [2]={["pos"]={0.70, 0.30, 1.9}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0}, 
            [3]={["pos"]={-0.25, 0.30, 1.9}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0},
            [4]={["pos"]={0.25, 0.30, 1.9}, ["color"]={255,0,0}, ["size"]=0.3, ["phase"]=20.0}, 
        },
        [525] = {["mode"]="lamp", --mec guincho
            [1]={["pos"]={0.0, 0.0 --[[Menos pra trás, mais pra frente]], 1.2 --[[Mais pra cima, menos pra baixo]]}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0},
            [2]={["pos"]={-0.2, 0.0, 1.2}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0},
            [3]={["pos"]={0.2, 0.0, 1.2}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0},
            [4]={["pos"]={0.0, 0.0 --[[Menos pra trás, mais pra frente]], 1.2 --[[Mais pra cima, menos pra baixo]]}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0},
            [5]={["pos"]={-0.2, 0.0, 1.2}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0},
            [6]={["pos"]={-0.4, 0.0, 1.2}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0},
            [7]={["pos"]={0.2, 0.0, 1.2}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0},
            [8]={["pos"]={0.4, 0.0, 1.2}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0},
            [9]={["pos"]={0.6, 0.0, 1.2}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0},
            [10]={["pos"]={-0.6, 0.0, 1.2}, ["color"]={255,140,0}, ["size"]=0.3, ["phase"]=20.0}, 
        }, 
    }
}

-- Sitemiz : https://sparrow-mta.blogspot.com/

-- Facebook : https://facebook.com/sparrowgta/
-- İnstagram : https://instagram.com/sparrowmta/
-- YouTube : https://www.youtube.com/@TurkishSparroW/

-- Discord : https://discord.gg/DzgEcvy