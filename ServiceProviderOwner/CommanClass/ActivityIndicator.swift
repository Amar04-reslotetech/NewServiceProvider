
import UIKit

class ActivityIndicator: UIView {

  @IBOutlet var mainView: UIView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit() {
    Bundle.main.loadNibNamed("ActivityIndicator", owner: self, options: nil)
    addSubview(mainView)
    mainView.frame = self.bounds
    activityIndicator.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
  }
  
}
