import UIKit

// MARK: - Properties

extension UITextField {
    
    public typealias TextFieldConfig = (UITextField) -> Swift.Void
    
    public func config(textField configurate: TextFieldConfig?) {
        configurate?(self)
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }


    
    func left(image: UIImage?, color: UIColor = .black) {
        if let image = image {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            //imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
            //imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
    }
    
    func right(image: UIImage?, color: UIColor = .black) {
        if let image = image {
            rightViewMode = UITextField.ViewMode.always
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 28, height: 20))
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 12, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            //imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
            //imageView.tintColor = color
            view.addSubview(imageView)
            rightView = view
        } else {
            rightViewMode = UITextField.ViewMode.never
            rightView = nil
        }
    }
}
