import Foundation

func GetLoad() -> ([String],[String]){
    do{
        //Get Content from input file
        let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
        let content: String = try String(contentsOf: fileURL!)
        //Build arrays from input return as tupel
        return (content.components(separatedBy: "\n\n")[0].components(separatedBy: "\n"),content.components(separatedBy: "\n\n")[1].components(separatedBy: "\n").dropLast())
    } catch{
        print(error.localizedDescription)
    }
    fatalError()
}

//Get input as tupel
let (loadlist, instructions) = GetLoad()
//Manualy define existing load stack
var loadStack: [Int:[String]] =
    [
     1: ["T","Q","V","C","D","S","N"],
     2: ["V","F","M"],
     3: ["M","H","N","P","D","W","Q","F"],
     4: ["F","T","R","Q","D"],
     5: ["B","V","H","Q","N","M","F","R"],
     6: ["Q","W","P","N","G","F","C"],
     7: ["T","C","L","R","F","W"],
     8: ["S","N","Z","T"],
     9: ["N","H","Q","R","J","D","S","M"]
    ]
//Prepare for CrateMover9001
var loadStack2 = loadStack

//Crate Mover9000
for line in instructions{
    var lineInstruction = [Int]()
    for thing in line.components(separatedBy: CharacterSet.decimalDigits.inverted) {
        if thing != ""{
            lineInstruction.append(Int(thing)!)
        }
    }
    //Line Instructions now contains cleaned information
    var counter: Int = 1
    while counter <= lineInstruction[0] {
        //Get elements from origin and save it to the crane
        //print("Old stack: ", loadStack[lineInstruction[1]])
        let crane = loadStack[lineInstruction[1]]?.first
        //Remove the elements from origin
        loadStack[lineInstruction[1]] = Array((loadStack[lineInstruction[1]]?.dropFirst())!)
        //print("Hopefully moved stack: ", loadStack[lineInstruction[1]])
        //Save the crane content to the target stack
        //print("Bfore change on new stack: ", loadStack[lineInstruction[2]])
        loadStack[lineInstruction[2]]?.insert(crane!, at: 0)
        //print("After change on new stack: ", loadStack[lineInstruction[2]])
        counter += 1
    }
}

//Instructions done
var returnString: String = ""
for stack in loadStack.sorted(by: {$0.key < $1.key}){
    returnString += stack.value[0]
}
print("The following crates are the first on each Stack:", returnString)

//Crate Mover9001
for line in instructions{
    var lineInstruction = [Int]()
    for thing in line.components(separatedBy: CharacterSet.decimalDigits.inverted) {
        if thing != ""{
            lineInstruction.append(Int(thing)!)
        }
    }
    //Line Instructions now contains cleaned information
    
    //Get elements from origin and save it to the crane
    //print("Old stack: ", loadStack[lineInstruction[1]])
    let crane = loadStack2[lineInstruction[1]]?.prefix(lineInstruction[0])
    //Remove the elements from origin
    loadStack2[lineInstruction[1]] = Array((loadStack2[lineInstruction[1]]?.dropFirst(lineInstruction[0]))!)
    //print("Hopefully moved stack: ", loadStack[lineInstruction[1]])
    //Save the crane content to the target stack
    //print("Bfore change on new stack: ", loadStack[lineInstruction[2]])
    loadStack2[lineInstruction[2]]?.insert(contentsOf: crane!, at: 0)
    //print("After change on new stack: ", loadStack[lineInstruction[2]])
    
}

//Instructions done
returnString = ""
for stack in loadStack2.sorted(by: {$0.key < $1.key}){
    returnString += stack.value[0]
}
print("The following crates are the first on each Stack when working with the crait mover 9001 :", returnString)



//Debug and logical test env
//var loadStack2: [Int:[String]] =
//    [
//     1: ["A","A","A"],
//     2: ["B","B","B"],
//     3: ["C","C","C"]
//    ]
//
//let anweisung2 = [2,1,3]
//
//var counter2: Int = 0
//while counter2 <= anweisung2[0] {
//    //Get elements from origin and save it to the crane
//    let crane2 = loadStack2[anweisung2[1]]?.first
//    //Remove the elements from origin
//    loadStack2[anweisung2[1]] = Array((loadStack2[anweisung2[1]]?.dropFirst())!)
//    //Save the crane content to the target stack
//    loadStack2[anweisung2[2]]?.insert(crane2!, at: 0)
//    counter2 += 1
//}
//
//let debug2 = loadStack2
