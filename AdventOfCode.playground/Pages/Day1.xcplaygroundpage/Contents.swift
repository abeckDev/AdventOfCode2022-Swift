import Foundation

func GetInput() -> [String]{
    do{
        //Get Content from input file
        let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
        let content: String = try String(contentsOf: fileURL!)
        //Build array from input
        return content.components(separatedBy: "\n")
    } catch{
        print(error.localizedDescription)
    }
    fatalError()
}
    
func CalculateCaloriesPerElf(input: [String]) -> [Int: Int]{
    var input = GetInput()
    //Sum up the calories carried by elfes
    var elfCounter: Int = 1
    var caloriesCounter: Int = 0
    var CaloriesBacklog = [Int: Int]()
    for calories in input{
        if calories != "" {
            caloriesCounter += Int(calories)!
        }
        else{
            //Save results
            CaloriesBacklog[elfCounter] = caloriesCounter
            //Reset Calories counter
            caloriesCounter = 0
            //Calculate the secone elf
            elfCounter += 1
        }
    }
    return CaloriesBacklog
}
//Sort descending
var elfBacklog = CalculateCaloriesPerElf(input: GetInput()).sorted{
    //Sort descending
    $0.value > $1.value
}

//Calculate top three
var topThree = elfBacklog.prefix(3)
var topThreetotal: Int = 0
for elf in topThree{
    topThreetotal += elf.value
}

print("Elf ",elfBacklog.first!.key, " is carrying the most (", elfBacklog.first!.value, ") calories")
print("The first three elves carry: ", topThreetotal, "calories")
