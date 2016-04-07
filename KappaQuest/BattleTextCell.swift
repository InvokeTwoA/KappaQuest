import UIKit

class BattleTextCell: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var explainText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setCell(iconImage : UIImage, explainText: String) {
        self.explainText!.text = explainText
        self.iconImage.image = iconImage
    }
}
