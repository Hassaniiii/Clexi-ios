import UIKit

extension UIView {

    func constrainEdges(to view: UIView, offset: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset),
            topAnchor.constraint(equalTo: view.topAnchor, constant: offset),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -offset)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func constrainCenter(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        let constrainst = [
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constrainst)
    }

    func constrainEdges(to view: UIView, offset: UIOffset) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset.horizontal),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -offset.horizontal),
            topAnchor.constraint(equalTo: view.topAnchor, constant: offset.vertical),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -offset.vertical)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
