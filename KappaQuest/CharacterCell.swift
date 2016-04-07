import UIKit

class CharacterCell: UITableViewCell {

    @IBOutlet weak var _iconImage: UIImageView!
    @IBOutlet weak var _name: UILabel!
    @IBOutlet weak var _gender: UILabel!
    @IBOutlet weak var _job: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(character : CharacterModel) {
        self._name.text = character.name
        self._gender.text = character.gender
        self._job.text = character.job
    }
}
