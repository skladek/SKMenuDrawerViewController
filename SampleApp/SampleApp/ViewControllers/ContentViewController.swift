import Foundation
import SKMenuDrawerViewController
import UIKit

class ContentViewController: UIViewController {

    enum Color: Int {
        case red = 0
        case green
        case blue
    }

    let color: Color

    init(color: Color) {
        self.color = color

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func backgroundColor(for color: Color) -> UIColor {
        var backgroundColor = UIColor.white

        switch color {
        case .blue:
            backgroundColor = .blue
        case .green:
            backgroundColor = .green
        case .red:
            backgroundColor = .red
        }

        return backgroundColor
    }

    @IBAction func toggleMenu() {
        guard let parent = parent as? MenuDrawerViewController else {
            return
        }

        parent.toggleMenu()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = backgroundColor(for: color)
    }
}
