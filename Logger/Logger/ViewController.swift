import UIKit

final class ViewController: UIViewController {

    private let customView: UIView

    // MARK: - Initializing

    init(customView: UIView = UIView()) {
        self.customView = customView
        super.init(nibName: nil, bundle: nil)
        Logger.shared.log(.controller)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Managing the View

    override func loadView() {
        customView.backgroundColor = .cyan
        view = customView
        Logger.shared.log(.controller)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Logger.shared.log(.controller)
    }

    // MARK: - View-Related Events

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Logger.shared.log(.controller)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Logger.shared.log(.controller)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Logger.shared.log(.controller)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Logger.shared.log(.controller)
    }

    // MARK: - Safe Area

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        Logger.shared.log(.controller)
    }

    // MARK: - View's Margins

    override func viewLayoutMarginsDidChange() {
        super.viewLayoutMarginsDidChange()
        Logger.shared.log(.controller)
    }

    // MARK: - View’s Layout Behavior

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        Logger.shared.log(.controller)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Logger.shared.log(.controller)
    }
}
