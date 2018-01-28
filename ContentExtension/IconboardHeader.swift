import UIKit

class IconboardHeader: UIView {

    private let submitButton = SubmitButton()
    private let timerLabel = UILabel()
    private let successOverlayView = SuccessView()
    private let stackView = UIStackView()

   init() {
        super.init(frame: .init(x: 0, y: 0, width: 375, height: 60))
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func showSuccessView() {
        UIView.transition(from: stackView,
                          to: successOverlayView,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          completion: nil)
        successOverlayView.constrainEdges(to: self)
    }

    private func setupView() {
        addSubview(stackView)
        setupStackView()
        setupTimerLabel()
        addTapAction()
        backgroundColor = UIColor(red: 0.1, green: 0.11, blue: 0.11, alpha: 1)
    }

    private func setupStackView() {
        stackView.addArrangedSubview(timerLabel)
        stackView.addArrangedSubview(submitButton)
        stackView.distribution = .fillEqually
        stackView.constrainEdges(to: self)
    }

    private func addTapAction() {
        submitButton.addTarget(self, action: #selector(didTapSubmitButton), for: .touchUpInside)
    }

    private func setupTimerLabel() {
        timerLabel.text = "00:15"
        timerLabel.textAlignment = .center
        timerLabel.textColor = .white
        timerLabel.font = UIFont.systemFont(ofSize: 42, weight: .regular)
    }

    func updateTimer(_ seconds: Int) {
        timerLabel.text = String(format: "00:%02d", seconds)
    }

    @objc
    private func didTapSubmitButton() {
        showSuccessView()
    }
}
