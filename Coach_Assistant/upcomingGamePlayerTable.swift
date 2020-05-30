import Firebase
import Foundation
import UIKit

class upcomingGamePlayerTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int?
        if teamSwitch.selectedSegmentIndex == 0 {
            count = game!.starting.count
        }
        else if teamSwitch.selectedSegmentIndex == 1 {
            count = game!.subs.count
        }
        
        return count!
    }
    
    @IBOutlet var teamSwitch: UISegmentedControl!
    @IBOutlet var startTable: UITableView!
    
    @IBAction func changeTeam(_ sender: Any) {
        if teamSwitch.selectedSegmentIndex == 0 {
            players = game!.starting
            startTable.reloadData()
        }
        else if teamSwitch.selectedSegmentIndex == 1 {
            players = game!.subs
            startTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if tableView == startTable {
            let Pcell = tableView.dequeueReusableCell(withIdentifier: "playerPrototypeCell", for: indexPath) as! PlayerCell
            let player = players[indexPath.row]
            
            Pcell.nameLabel.text = String(player.name)
            Pcell.surnameLabel.text = String(player.surname)
            Pcell.numLabel.text = String(player.number)
            Pcell.id = String(player.id)
            
            return Pcell
        }
        
        return cell!
    }
    
    var players: [Player] = []
    var game: upcomingGame?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? playerProfileVewController {
            let cell = sender as! PlayerCell
            dest.id = cell.id
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTable.dataSource = self
        startTable.delegate = self
        
        players = game!.starting
        
        title = "Состав команды"
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
}
