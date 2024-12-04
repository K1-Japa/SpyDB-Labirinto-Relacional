local constructors = require("constructors")

local minigameType = {
    DER = {
        typeName = "Diagrama Entidade Relacionamento",
        img = {"01.png", "02.png", "03.png", "04.png"},
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

local map = {{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
            { 0,  1,  1,  1,  1,  1,  1,  1,  1,  1, 0 },
            { 0,  2,  2,  2,  2,  2,  2,  2,  2,  1, 0 },
            { 0,  2,  1,  2,  1,  2,  1,  1,  2,  1, 0 },
            { 0,  2,  1,  2,  1,  2,  2,  2,  2,  1, 0 },
            { 0,  2,  1,  2,  1,  2,  1,  1,  2,  1, 0 },
            { 0,  2,  1,  2,  1,  2,  1,  1,  2,  1, 0 },
            { 0,  2,  1,  2,  1,  2,  1,  1,  2,  1, 0 },
            { 0,  2,  1,  2,  2,  2,  2,  2,  2,  2, 0 },
            { 0,  2,  2,  2,  1,  1,  1,  1,  1,  1, 0 },
            { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }}

local player = constructors.newPlayer(6, 3, 0, 0)

local enemys = {}

local totems = {}

table.insert(enemys, constructors.newEnemy(2,3,0,0, "right"))
table.insert(enemys, constructors.newEnemy(4,4,0,0, "down"))

local aux = {
    typeName = "Decodificar Tabelas",
    imgs = {"a.png", "b.png"},
    answers = {"Nome", "CPF"}
}

-- table.insert(totems, constructors.newTotem(10, 9, aux))


aux = nil

aux = {
    typeName = "Decodificar Tabelas",
    imgs = {
            Nome = "Nome.png",
            Codificado = {"./imgs/lvl01/cCol01.png", "./imgs/lvl01/cCol02.png", "./imgs/lvl01/cCol03.png"},
            Decodificado = {"./imgs/lvl01/dCol01.png", "./imgs/lvl01/dCol02.png", "./imgs/lvl01/dCol03.png"},
        },
    answers = {"Nome coluna 01", "Nome coluna 02", "Nome coluna 03"},
    correctAnswers = {false, false, false}
}

table.insert(totems, constructors.newTotem(9, 9, aux))

local function Game()
    return map, player, enemys, totems
end

return {
    Game = Game
}