import Foundation

func GetInput() -> [Character]{
    do{
        //Get Content from input file
        let fileURL = Bundle.main.url(forResource: "input", withExtension: "txt")
        let content: String = try String(contentsOf: fileURL!)
        //Build character array
        return content.map({$0})
    } catch{
        print(error.localizedDescription)
    }
    fatalError()
}

//Get Input
let input = GetInput()

func GetMarkerLenght(lenght: Int, chars: [Character]) -> Int{
    for i in 0 ... (chars.count - lenght - 1) {
        //Check if the marker is in the current position (4 is minimum, so add it but remove the counter in the end (i+4-1))
        let marker = chars[i ... i + lenght - 1]
        //If the marker contains the exac and unique elements of four return solution
        if Set(marker).count == lenght {
            return (i + lenght)
        }
    }
    fatalError("Not supposed to happen")
}

print("We need to process:",GetMarkerLenght(lenght: 4, chars: input), "Characters until the start package marker was detected!")


print("We need to process:",GetMarkerLenght(lenght: 14, chars: input), "Characters until the start message marker was detected!")
