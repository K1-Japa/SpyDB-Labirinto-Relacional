local constructors = require("constructors")

local minigameType = {
    DER = {
        typeName = "Diagrama Entidade Relacionamento",
        img = {"01.png", "02.png", "03.png", "04.png"},
        diagram = 1,
        answer = nil
    },
    AR = {
        typeName = "Algebra Relacional",
        img = "",
        answer = {}
    },
    DTB = {
        typeName = "Decodificar Tabelas",
        imgs = {
            Nome = "Nome.png",
            Codificado = {"./imgs/lvl01/cCol01.png", "./imgs/lvl01/cCol02.png", "./imgs/lvl01/cCol03.png"},
            Decodificado = {"./imgs/lvl01/dCol01.png", "./imgs/lvl01/dCol02.png", "./imgs/lvl01/dCol03.png"},
        },
        answers = {"Nome coluna 01", "Nome coluna 02", "Nome coluna 03"},
        correctAnswers = {false, false, false}
    }
}

local map = {
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    {0,1,1,1,1,1,1,2,2,2,2,2,2,2,2,1,0},
    {0,2,2,2,2,2,2,2,1,1,2,1,1,1,2,1,0},
    {0,1,2,1,1,2,1,2,1,1,2,1,1,1,2,1,0},
    {0,2,2,1,1,2,1,2,2,2,2,2,2,2,2,2,0},
    {0,1,2,2,2,2,1,1,1,2,1,1,2,1,1,1,0},
    {0,1,1,1,1,2,1,1,1,2,2,2,2,1,1,1,0},
    {0,1,1,1,1,2,2,2,2,2,1,1,2,1,1,1,0},
    {0,2,2,2,2,2,1,1,1,2,1,1,2,2,2,2,0},
    {0,1,2,1,2,2,2,2,2,2,2,2,2,1,1,1,0},
    {0,1,2,1,2,1,1,2,1,1,1,2,1,1,1,1,0},
    {0,1,1,1,2,1,1,2,1,1,1,2,1,1,1,1,0},
    {0,1,1,1,2,2,2,2,2,2,2,2,1,2,2,2,0},
    {0,1,1,1,2,1,1,1,2,1,1,2,1,2,1,1,0},
    {0,2,2,1,2,1,1,1,2,1,1,2,2,2,2,1,0},
    {0,1,2,2,2,1,1,2,2,1,1,2,1,2,1,1,0},
    {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
}

local player = constructors.newPlayer(2, 3, 0, 0)

local enemys = {}

local totems = {}

table.insert(enemys, constructors.newEnemy(10,2,0,0, "left"))
table.insert(enemys, constructors.newEnemy(3,10,0,0, "down"))
table.insert(enemys, constructors.newEnemy(15,9,0,0, "left"))

local aux

aux = nil

aux = {
    typeName = "Diagrama Entidade Relacionamento",
    img = {"imgs/lvl01/lvl01R.png", "imgs/lvl01/lvl01Erro01.png", "imgs/lvl01/lvl01Erro02.png", "imgs/lvl01/lvl01Erro03.png"},
    diagram = 1,
    answer = 1
}
table.insert(totems, constructors.newTotem(2, 9, aux))
table.insert(totems, constructors.newTotem(8, 16, aux))
table.insert(totems, constructors.newTotem(16, 5, aux))
table.insert(totems, constructors.newTotem(16,13, aux))

local function Game()
    return map, player, enemys, totems
end

return {
    Game = Game
}