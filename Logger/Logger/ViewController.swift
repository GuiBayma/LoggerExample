import UIKit

final class ViewController: UIViewController {

    private let customView: UIView

    // MARK: - Initializing

    init(customView: UIView = UIView()) {
        self.customView = customView
        super.init(nibName: nil, bundle: nil)
        Logger.log(.controller)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Managing the View

    override func loadView() {
        customView.backgroundColor = .cyan
        view = customView
        Logger.log(.controller)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Logger.log(.controller)
    }

    // MARK: - View-Related Events

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Logger.log(.controller)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Logger.log(.controller)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Logger.log(.controller)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Logger.log(.controller)
    }

    // MARK: - Safe Area

    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        Logger.log(.controller)
    }

    // MARK: - View's Margins

    override func viewLayoutMarginsDidChange() {
        super.viewLayoutMarginsDidChange()
        Logger.log(.controller)
    }

    // MARK: - View’s Layout Behavior

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        Logger.log(.controller)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Logger.log(.controller)
    }
}
