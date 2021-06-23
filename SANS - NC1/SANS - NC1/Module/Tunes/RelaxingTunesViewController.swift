//
//  RelaxingTunesViewController.swift
//  SANS - NC1
//
//  Created by Dheo Gildas Varian on 05/05/21.
//

import UIKit

class RelaxingTunesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var tunes = [Tunes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tunes"
        
        configure()
        table.delegate = self
        table.dataSource = self
    }
    func configure(){
        tunes.append(Tunes(name: "Time Alone", img: "musicNote", tunesName: "song1", tunesMaker: "By David Renda"))
        tunes.append(Tunes(name: "Deep Meditation", img: "musicNote", tunesName: "song2", tunesMaker: "By David Fesliyan"))
        tunes.append(Tunes(name: "Quiet Time", img: "musicNote", tunesName: "song3", tunesMaker: "By David Felisyan"))
        tunes.append(Tunes(name: "In The Light", img: "musicNote", tunesName: "song4", tunesMaker: "By David Renda"))
        tunes.append(Tunes(name: "Tranquility", img: "musicNote", tunesName: "song5", tunesMaker: "By David Renda"))
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tunes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let tune = tunes[indexPath.row]
        
        cell.textLabel?.text = tune.name
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)
        cell.imageView?.image = UIImage(named: tune.img)
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let position = indexPath.row
        guard let vc = storyboard?.instantiateViewController(identifier: "MusicPlayer") as? MusicPlayerViewController  else {
            return
        }
        
        vc.tunes = tunes
        vc.position = position
        
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}

struct Tunes {
    let name: String
    let img: String
    let tunesName: String
    let tunesMaker: String
}
