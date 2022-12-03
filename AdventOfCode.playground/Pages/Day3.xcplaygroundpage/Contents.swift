import Foundation

extension String {

    var length: Int {
        return count
    }
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

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

//Get Inout
let backPacks  = GetInput()
//Split them into different compartments and get unique match
var identifiedItems: [Character] = [Character]()
for backPack in backPacks{
    let halfString = backPack.count / 2
    let firstHalf = backPack[0..<halfString]
    let secondHalf = backPack[halfString..<backPack.count]
charloop:
    for char in firstHalf{
        if secondHalf.contains(char){
            identifiedItems.append(char)
            break charloop
            //print("Identified Item: ", char)
        }
    }
}

//Match value
//Build mapping table
var counter: Int = 1
var alphabetMappingTable = [Character:Int]()
for char in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"{
    alphabetMappingTable[char] = counter
    //print("Letter: ", char, "Value: ", counter)
    counter += 1
}

var totalPriority: Int = 0

for item in identifiedItems {
    totalPriority += alphabetMappingTable[item]!
}
print("The total priority is:", totalPriority)

//Divide into groups
var badgeCollection = [Character]()
counter = 0
while counter < backPacks.count{
    print("Entry counter:", counter)
    let backpack1 = backPacks[counter]
    let backpack2 = backPacks[counter+1]
    let backpack3 = backPacks[counter+2]
secondcharloop:
    for char in backpack1{
        if backpack2.contains(char){
            if backpack3.contains(char){
               //Found it
                badgeCollection.append(char)
                break secondcharloop
            }
        }
    }
    //Get the first backpack of the next group
    counter += 3
}
var badgePriority: Int = 0
for badge in badgeCollection {
    badgePriority += alphabetMappingTable[badge]!
}

print("The badge priority is:", badgePriority)
