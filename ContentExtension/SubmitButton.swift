import UIKit

class SubmitButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        backgroundColor = UIColor(red: 0.03, green: 0.7, blue: 0.93, alpha: 1)
        setImageView()
        setTitleLabel()
    }

    private func setImageView() {
        imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 16)
        setImage(#imageLiteral(resourceName: "righ_arrow"), for: .normal)
        imageView?.contentMode = .scaleAspectFit
        setImageViewHeight()
    }

    private func setImageViewHeight() {
        guard let titleLabel = titleLabel else { return }

        let heightConstraint = imageView?.heightAnchor.constraint(equalTo: titleLabel.heightAnchor)
        heightConstraint?.constant = -4
        heightConstraint?.isActive = true
    }

    private func setTitleLabel() {
        titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        setTitle("SUBMIT", for: .normal)
        setTitleColor(.black, for: .normal)
    }
}
