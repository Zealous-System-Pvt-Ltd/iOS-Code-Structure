import UIKit

extension UIAlertController {
    
    /// Add two textField
    ///
    /// - Parameters:
    ///   - height: textField height
    ///   - hInset: right and left margins to AlertController border
    ///   - vInset: bottom margin to button
    ///   - textFieldOne: first textField
    ///   - textFieldTwo: second textField
    
    func addTwoTextFields(height: CGFloat = 58, hInset: CGFloat = 0, vInset: CGFloat = 0, textFieldOne: TextField.Config?, textFieldTwo: TextField.Config?) {
        let textField = TwoTextFieldsViewController(height: height, hInset: hInset, vInset: vInset, textFieldOne: textFieldOne, textFieldTwo: textFieldTwo)
        set(vc: textField, height: height * 2 + 2 * vInset)
    }
}

final class TwoTextFieldsViewController: UIViewController {
    
    fileprivate lazy var textFieldView: UIView = UIView()
    fileprivate lazy var textFieldOne: TextField = TextField()
    fileprivate lazy var textFieldTwo: TextField = TextField()
    
    fileprivate var height: CGFloat
    fileprivate var hInset: CGFloat
    fileprivate var vInset: CGFloat
    
    init(height: CGFloat, hInset: CGFloat, vInset: CGFloat, textFieldOne configurationOneFor: TextField.Config?, textFieldTwo configurationTwoFor: TextField.Config?) {
        self.height = height
        self.hInset = hInset
        self.vInset = vInset
        super.init(nibName: nil, bundle: nil)
        view.addSubview(textFieldView)
        
        textFieldView.addSubview(textFieldOne)
        textFieldView.addSubview(textFieldTwo)
        
        textFieldView.frame.size.width = view.frame.size.width
        textFieldView.frame.size.height = height * 2
        textFieldView.layer.masksToBounds = true
        //textFieldView.borderWidth = 1
        textFieldView.borderColor = UIColor.lightGray
        textFieldView.cornerRadius = 8
        
        configurationOneFor?(textFieldOne)
        configurationTwoFor?(textFieldTwo)
        
        //preferredContentSize.height = height * 2 + vInset
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Log("has deinitialized")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        textFieldView.frame.size.width = view.frame.size.width - hInset * 2
        textFieldView.frame.size.height = height * 2
        textFieldView.center.x = view.center.x
        textFieldView.center.y = view.center.y
        
        textFieldOne.frame.size.width = textFieldView.frame.size.width
        textFieldOne.frame.size.height = textFieldView.frame.size.height / 2
        textFieldOne.center.x = textFieldView.frame.size.width / 2
        textFieldOne.center.y = textFieldView.frame.size.height / 4
        
        textFieldTwo.frame.size.width = textFieldView.frame.size.width
        textFieldTwo.frame.size.height = textFieldView.frame.size.height / 2
        textFieldTwo.center.x = textFieldView.frame.size.width / 2
        textFieldTwo.center.y = textFieldView.frame.size.height - textFieldView.frame.size.height / 4
    }
}

