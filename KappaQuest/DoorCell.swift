// 迷宮中の扉の選択肢
import UIKit

class DoorCell: UITableViewCell {
    @IBOutlet weak var _description: UILabel!
    @IBOutlet weak var _image: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(door: QuestModel.door) {
        self._description.text = door.description
        self._image.image = door.image
    }
}
