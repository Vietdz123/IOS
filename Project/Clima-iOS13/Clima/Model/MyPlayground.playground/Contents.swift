import UIKit

let queue = DispatchQueue(label: "Hello")

queue.async {
 
    for i in 1...10 {
        print(i)
    }
    print("Hello")
}

for i in 1...10 {
    print("j \(i)")
}
