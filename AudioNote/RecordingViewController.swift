import MobiusCore
import UIKit

final class RecordingViewController: UIViewController {
    var audioController: AudioController?

    private lazy var loopController: MobiusController<Model, Event, Effect> = {
        return AudioRecorderLoopFactory.makeLoopController()
    }()

    private var _view: RecordingView {
        guard let view = view as? RecordingView else {
            fatalError("Unexpected view type")
        }

        return view
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = RecordingView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loopController.connectView(AudioRecorderLoopFactory.makeViewConnectable(view: _view))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !loopController.running { loopController.start() }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        if loopController.running { loopController.stop() }
    }
}
