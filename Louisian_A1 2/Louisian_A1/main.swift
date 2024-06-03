import Foundation

func initialFunction () -> (Any) -> Any {
    print("Welcome to Zoo Escape!")
    print("Menu")
    print("1: Start Game")
    print("2: Show scoreboard")
    print ("Choose Option")
    
    var optionSelected = Int(readLine()!) ?? 0
    
    if optionSelected == 1{
      
        return startGame()
        
        
    } else if optionSelected == 2
    {
        return showScoreboard(playerScores: playerScores)
    }; return initialFunction()
}

// the variables are an empty array that will store the players names and their scores.
var playersName: [String] = []
var playerScores: [String: Int] = [:]

// this function generates random counts of the animals for each city in the game btwn 3, 5, 7 using dictionaries.
func randomAnimalCountGenerator() -> [String: Int]  {
    var neighbourhoods: [String: Int] = [:]
       let animalCounts = [3, 5, 7]

        for neighbourhoodName in ["Brooklyn", "Queens", "Manhattan"] {
            let randomneighbourhoodIndex = Int.random(in: 0..<animalCounts.count)
            neighbourhoods[neighbourhoodName] = animalCounts[randomneighbourhoodIndex]
        }
        return neighbourhoods
}
// this function displays neighborhoods
func displayNeighbourhoods(_ neighbourhoods: [String: Int]) {
    print("New York Neighbourhoods:")
    for (neighbourhoodName, count) in neighbourhoods {
        print("\(neighbourhoodName): \(count) animals")
    }
}

func animalCount (animalQuantity:Int, selectedNeighbourhoodAnimals:Int) -> Int {
    
    if (animalQuantity <= 0)  {
        print("Animal Quantitiy MUST be greater than 0")
        return 0
    }
    else if selectedNeighbourhoodAnimals == 0{
        print("Sorry, there are no animals remaining here! Please Try again.")
        return  0
    }
    else if animalQuantity > selectedNeighbourhoodAnimals{
        print("Quantity selected is greater than animals in the selected Neighbourhood!")
        return 0
    }
        return animalQuantity
}

func startGame() -> (Any) -> Any {
    var randomNeighbourhoods = randomAnimalCountGenerator()
    displayNeighbourhoods(randomNeighbourhoods)
    //this  Ask players to enter their names  and the adds their name to the playername created above then inigializes the players scores to 0 by default
    print("Player 1 Enter your name here:")
    let player1Name = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
    var player1Score = playerScores[player1Name]
    playersName.append(player1Name)
    if  player1Score ?? 0 > 0 {
        playerScores[player1Name] = player1Score
    } else {
        playerScores[player1Name] = 0
    }
   
    
    print("Player 2 Enter your name here:")
    let player2Name = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
    playersName.append(player2Name)
    var player2Score = playerScores[player2Name]
        playersName.append(player2Name)
        if  player2Score ?? 0 > 0 {
            playerScores[player2Name] = player2Score
        } else{
            playerScores[player2Name] = 0
        }
    
    let startingPlayerIndex = Int.random(in: 0..<playersName.count)
    var currentPlayerIndex = startingPlayerIndex
    
    repeat {
        print("\(playersName[currentPlayerIndex])'s turn:")
        print("Please select the neighbourhood")
        let selectedNeighbourhood = readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)
        let selectedNeighbourhoodAnimals = randomNeighbourhoods[selectedNeighbourhood] ?? 0
        
        
        print("Please select the Quantity of animals to capture")
        let animalQuantity = Int(readLine()!.trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0
        let selectedQuantity = animalCount( animalQuantity: animalQuantity, selectedNeighbourhoodAnimals: selectedNeighbourhoodAnimals)
        
        if selectedQuantity == 0 {
           print("Please select the Quantity of animals to capture")
          
        }
        randomNeighbourhoods[selectedNeighbourhood] = selectedNeighbourhoodAnimals - selectedQuantity
        displayNeighbourhoods(randomNeighbourhoods)

        // Switch player
        // Switch player if the current player hasn't won yet
        if randomNeighbourhoods.contains(where: { $0.value > 0 }) {
            currentPlayerIndex = (currentPlayerIndex + 1) % playersName.count
        }

       
    }  while randomNeighbourhoods.contains { $0.value > 0 }
    
    print("The winner is :\(playersName[currentPlayerIndex])")
    let currWinnerScore =   playerScores[playersName[currentPlayerIndex]]
    playerScores[playersName[currentPlayerIndex]] = currWinnerScore! +  1
    
  return  initialFunction()
}

func showScoreboard(playerScores: [String: Int]) ->(Any) -> Any {
    print("Player name  Games won")
    for (name, score) in playerScores {
        print("\(name)\t\(score)")
    }; return  initialFunction()
}


print(initialFunction())
