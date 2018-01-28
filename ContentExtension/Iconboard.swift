import UIKit

class Iconboard: UIView {

    private var iconButtons = [IconButton]()
    private let verticalStack = UIStackView()
    private let topHorizontalStack = UIStackView()
    private let bottomHorizontalStack = UIStackView()

    private let verticalSpacing: CGFloat = 16
    private let horizontalSpacing: CGFloat = 30
    private let offset = UIOffset(horizontal: 30, vertical: 16)

    init() {
        super.init(frame: .init(x: 0, y: 0, width: 375, height: 216))
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = UIColor(red: 0.1, green: 0.11, blue: 0.11, alpha: 1)
        addSubview(verticalStack)
        setupSubviews()
    }

    private func setupSubviews() {
        setupVerticalStack()
        setupHorizontalStack(topHorizontalStack)
        setupHorizontalStack(bottomHorizontalStack)
        addIcons([#imageLiteral(resourceName: "bin"), #imageLiteral(resourceName: "cancel"), #imageLiteral(resourceName: "lock"), #imageLiteral(resourceName: "sound"), #imageLiteral(resourceName: "delete"), #imageLiteral(resourceName: "erase")])
    }

    private func addIcons(_ iconImages: [UIImage]) {
        iconButtons = iconImages.map { IconButton(image: $0) }
        addIconButtons()
    }

    private func addIconButtons() {
        iconButtons.enumerated().forEach { (offset, button) in
            guard offset < 6 else { return }
            if offset < 3 {
                topHorizontalStack.addArrangedSubview(button)
            } else {
                bottomHorizontalStack.addArrangedSubview(button)
            }
        }
    }

    private func setupVerticalStack() {
        verticalStack.addArrangedSubview(topHorizontalStack)
        verticalStack.addArrangedSubview(bottomHorizontalStack)
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillEqually
        verticalStack.spacing = verticalSpacing
        verticalStack.constrainEdges(to: self, offset: offset)
    }

    private func setupHorizontalStack(_ stackView: UIStackView) {
        stackView.distribution = .fillEqually
        stackView.spacing = horizontalSpacing
    }
}
