import Foundation

func GetInput() -> [String]{
    do{
        //Get Content from input file
        let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
        let content: String = try String(contentsOf: fileURL!)
        //Build array from input
        return content.components(separatedBy: "\n").dropLast()
    } catch{
        print(error.localizedDescription)
    }
    fatalError()
}

/*
 A = Rock
 B = Paper
 C = Scissor
 
 X = Rock = 1
 Y = Paper = 2
 Z = Scissor = 3
 
 */

func GetBaseScore(playerChoice: Character) -> Int {
    switch playerChoice {
    case "X":
        return 1
    case "Y":
        return 2
    case "Z":
        return 3
    default:
        fatalError("That is not supposed to happen")
    }
}

func GetGameScore(playersChoice: Character, opponentChoice: Character) -> Int{
    switch playersChoice {
    case "Z":
        switch opponentChoice {
        case "C":
            return 3
        case "A":
            return 0
        case "B":
            return 6
        default:
            fatalError()
        }
    case "X":
        switch opponentChoice {
        case "C":
            return 6
        case "A":
            return 3
        case "B":
            return 0
        default:
            fatalError()
        }
    case "Y":
        switch opponentChoice {
        case "C":
            return 0
        case "A":
            return 6
        case "B":
            return 3
        default:
            fatalError()
        }
    default:
        fatalError()
    }
}

func CalculateGameOutcome(opponentsChoice: Character, desiredOutcome: Character) -> Int{
    /*
     A = Rock = 1
     B = Paper = 2
     C = Scissor = 3
     Win = 6
     Tie = 3
     Loose = 0
     X = loose
     Y = draw
     Z = win
     */
    switch desiredOutcome {
    case "X":
        //We need to loose
        switch opponentsChoice {
        case "A":
            //Opponent takes Rock, we take scissor and loose
            return 3
        case "B":
            //Opponent takes Paper, we take rock and loose
            return 1
        case "C":
            //Opponent takes Scissor, we take paper and loose
            return 2
        default:
            fatalError()
        }
    case "Y":
        //We need to draw
        switch opponentsChoice {
        case "A":
            //Opponent takes Rock, we take Rock and tie
            return 4
        case "B":
            //Opponent takes Paper, we take paper and tie
            return 5
        case "C":
            //Opponent takes Scissor, we take Scissor and tie
            return 6
        default:
            fatalError()
        }
    case "Z":
        //We need to win
        switch opponentsChoice {
        case "A":
            //Opponent takes Rock, we take paper and win
            return 8
        case "B":
            //Opponent takes Paper, we take scissor and win
            return 9
        case "C":
            //Opponent takes Scissor, we take rock and win
            return 7
        default:
            fatalError()
        }
    default:
        fatalError()
    }
}

let input = GetInput()
var tournamentScore: Int = 0
for game in input{
    tournamentScore += GetBaseScore(playerChoice: game.last!)
    tournamentScore += GetGameScore(playersChoice: game.last!, opponentChoice: game.first!)
    //print("First: ", game.first!, " and last: ", game.last!)
}

print("If all goes according to plan the final score will be: ", tournamentScore)

//Zero the score for recalculation
tournamentScore = 0
for game in input {
    tournamentScore += CalculateGameOutcome(opponentsChoice: game.first!, desiredOutcome: game.last!)
}

print("If all goes according to the new plan the final score will be: ", tournamentScore)


