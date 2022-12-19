import Foundation

func GetInput() -> [String:[String]]{
    do{
        //Get Content from input file
        let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
        let content: String = try String(contentsOf: fileURL!)
        //Build array from input and add command to output
        var commandResult = [String:[String]]()
        let arrayResult = content.components(separatedBy: "\n").dropLast()
        let maxMatches = arrayResult.count
        
        var counter: Int = 0
        while counter <= (arrayResult.count - 1)  {
            if arrayResult[counter].first == "$"{
                print("Found a command: ", arrayResult[counter], "- Counter: \(counter) out of \(maxMatches) ")
                //We got a command
                let command: String = String(counter)+"-"+arrayResult[counter]
                commandResult[command] = [String]()
                counter += 1
                while arrayResult[counter].first != "$" && counter <= arrayResult.count {
                    print("Adding for command \(command) - Counter: \(counter) out of \(maxMatches)")
                    var responseArray = commandResult[command]!
                    responseArray.append(arrayResult[counter])
                    print("Adding: \(arrayResult[counter])")
                    commandResult[command] = responseArray
                    counter += 1
                    print("Increased counter to \(counter) out of \(maxMatches)")
                    if counter == arrayResult.count{
                        break;
                    }
                }
                print("I am done adding for command: \(command)")
            }
        }
        return commandResult
    } catch{
        print(error.localizedDescription)
    }
    fatalError()
}

let input = GetInput().sorted(by: {$0.key < $1.key})

var debug = input


//Get a Dictionary [DirectoryName: FileSize] --> Get all directories with size bigger than x -> Add sizes and return first answer
