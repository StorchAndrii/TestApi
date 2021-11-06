import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet var ivGirl: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var lastLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func onPress(_ sender: Any) {
        
        NetworkLayer.shared.sendRequest(GetGirlRequest(onError: { (errorText) in
            debugPrint(errorText)
        }, onSuccess: { (resultData) in
            let sameEmployee = try? JSONDecoder().decode(UserResult.self, from: resultData!)

            guard let imageString = sameEmployee?.results?.first?.picture.large else { return }
            guard let imageUrl = URL(string: imageString), let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            guard let nameString = sameEmployee?.results?.first?.name else { return }
            
            DispatchQueue.main.async {
                self.ivGirl.image = UIImage(data: imageData)
                self.nameLabel.text = nameString.first
                self.lastLabel.text = nameString.last
            }
        }))
    }
}
