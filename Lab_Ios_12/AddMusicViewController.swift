import UIKit

class AddMusicViewController: UIViewController {

    // MARK: - Outlets
    
   
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Variables
    var tracks: [Track] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        MusicService.shared.searchForMusic { [weak self] result, error in
            guard let self = self else { return }
            
            if let tracks = result?.tracks {
                self.tracks = tracks
                self.tableView?.reloadData()
            } else if let error = error {
                print(error)
            }
        }
    }


}

extension AddMusicViewController: TrackTableViewCellDelegate {
    func didPressPlay(track: Track) {
        MusicService.shared.play(track: track)
    }
    
  
}

extension AddMusicViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "track", for: indexPath) as! TrackTableViewCell
        cell.track = self.tracks[indexPath.row]
        cell.delegate = self
        
        return cell
    }
}
