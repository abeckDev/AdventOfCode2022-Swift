import Foundation
import RegexBuilder

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

func GetSmallerNumber(rangeA: ClosedRange<Int>, rangeB: ClosedRange<Int>) -> Int{
    
    if rangeA.lowerBound <= rangeB.lowerBound{
        return rangeA.lowerBound
    }
    return rangeB.lowerBound
}
func GetBiggerNumber(rangeA: ClosedRange<Int>, rangeB: ClosedRange<Int>) -> Int{
    
    if rangeA.upperBound >= rangeB.upperBound{
        return rangeA.upperBound
    }
    return rangeB.upperBound
}


let input = GetInput()

var countContainingTasks: Int = 0
var countOverlappingTasks: Int = 0
for team in input{
    var individualAssignments = team.components(separatedBy: ",")
    var rangeRaw = individualAssignments[0].components(separatedBy: "-")
    var firstRange = Int(rangeRaw[0])!...Int(rangeRaw[1])!
    rangeRaw = individualAssignments[1].components(separatedBy: "-")
    var secondRange = Int(rangeRaw[0])!...Int(rangeRaw[1])!
    
    //Check if one range contains the other
    if !secondRange.ranges(of: firstRange).isEmpty ||
        !firstRange.ranges(of: secondRange).isEmpty {
        countContainingTasks += 1
    }
 
    //Check Overlap
    for number in firstRange{
        if secondRange.contains(number){
            countOverlappingTasks += 1
            break
        }
    }
}

print("The amount of containing tasks is: \(countContainingTasks)")
print("The amount of overlapping tasks is: \(countOverlappingTasks)")

