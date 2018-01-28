import UIKit

class SuccessView: UIView {

    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = UIColor(red: 0.03, green: 0.7, blue: 0.93, alpha: 1)
        addSubview(titleLabel)
        setupTitleLabel()
    }

    private func setupTitleLabel() {
        titleLabel.textColor = .white
        titleLabel.text = "Thanks! Your answer has been sent."
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        titleLabel.constrainCenter(to: self)
    }
}
