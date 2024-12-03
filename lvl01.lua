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
        imgs = {},
        answers = {}
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

table.insert(totems, constructors.newTotem(10, 9, aux))

local function Game()
    return map, player, enemys, totems
end

return {
    Game = Game
}