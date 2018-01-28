import UIKit

class IconButton: UIButton {

    private let iconView = UIImageView()
    private let iconContainer = UIView()

    private let cornerRadius: CGFloat = 16
    private let iconContainerCornerRadius: CGFloat = 14
    private let iconViewOffset: CGFloat = 16
    private let iconContainerOffset: CGFloat = 4

    private var selectedColor: UIColor = UIColor(red: 0.03, green: 0.7, blue: 0.93, alpha: 1)
    private var unselectedColor: UIColor = UIColor(red: 0.24, green: 0.25, blue: 0.27, alpha: 1)
    private var iconSelectedColor: UIColor = UIColor(red: 0.1, green: 0.11, blue: 0.11, alpha: 1)

    override var isSelected: Bool {
        didSet {
            changeBackgroundColor()
        }
    }

    init(image: UIImage) {
        super.init(frame: .zero)
        setupView(with: image)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView(with image: UIImage) {
        setIcon(image)
        addSubviews()
        setIconView()
        setIconContainer()
        setCornerRadius()
        changeBackgroundColor()
        addTapAction()
    }

    private func setIcon(_ icon: UIImage) {
        iconView.image = icon
    }

    private func addTapAction() {
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc
    private func didTapButton() {
        isSelected = !isSelected
    }

    private func addSubviews() {
        addSubview(iconContainer)
        iconContainer.addSubview(iconView)
    }

    private func setCornerRadius() {
        layer.cornerRadius = cornerRadius
        iconContainer.layer.cornerRadius = iconContainerCornerRadius
    }

    private func changeBackgroundColor() {
        backgroundColor = isSelected ? selectedColor : unselectedColor
        iconContainer.backgroundColor = isSelected ? iconSelectedColor : unselectedColor
    }

    private func setIconContainer() {
        iconContainer.isUserInteractionEnabled = false
        iconContainer.backgroundColor = unselectedColor
        iconContainer.constrainEdges(to: self, offset: iconContainerOffset)
    }

    private func setIconView() {
        iconView.contentMode = .scaleAspectFit
        iconView.isUserInteractionEnabled = false
        iconView.constrainEdges(to: iconContainer, offset: iconViewOffset)
    }
}
