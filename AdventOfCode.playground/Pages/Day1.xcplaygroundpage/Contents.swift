import Foundation


//Get Content from input page
var content: String = ""

if let url = URL(string: "https://adventofcode.com/2022/day/1/input"){
    do{
        content = try String(contentsOf: url)
    } catch {
        print(error.localizedDescription)
    }
    print(content)
}



