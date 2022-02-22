import UIKit

final class ViewController: UIViewController {
    let recordButton = UIButton()
    let playbackButton = UIButton()
    let audioWaveView = AudioWaveFormView()

    var audioController: AudioController?

    init() {
        super.init(nibName: nil, bundle: nil)
        audioController = AudioController(
            recordButton: recordButton,
            playbackButton: playbackButton,
            updateAudioWaveFormCallback: { [weak self] powerValue in
                self?.audioWaveView.updateSequence(with: powerValue)
            }
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        // temp: Probably don't need to ask it every time the view controller is created
        audioController?.requestUserPermissions()

        super.viewDidLoad()

        setupView()
        setupConstraints()
    }

    private func setupView() {
        view.backgroundColor = .black
        audioWaveView.backgroundColor = .black

        recordButton.setTitle("Record Note", for: .normal)
        recordButton.setTitleColor(.systemBlue, for: .normal)
        recordButton.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)

        playbackButton.setTitle("Play Recording", for: .normal)
        playbackButton.setTitleColor(.systemBlue, for: .normal)
        playbackButton.addTarget(self, action: #selector(playbackButtonTapped), for: .touchUpInside)

        view.addSubview(audioWaveView)
        view.addSubview(recordButton)
        view.addSubview(playbackButton)
    }

    private func setupConstraints() {
        audioWaveView.translatesAutoresizingMaskIntoConstraints = false
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        playbackButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            audioWaveView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            audioWaveView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            audioWaveView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            audioWaveView.bottomAnchor.constraint(equalTo: recordButton.topAnchor, constant: -8.0),

            recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            playbackButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            playbackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

    // todo: Fuser
    @objc func recordButtonTapped(_ sender: UIButton) {
        if audioController?.audioRecorder == nil {
            audioController?.startRecording()
        } else {
            audioController?.stopRecording(successfully: true)
        }
    }

    @objc func playbackButtonTapped(_ sender: UIButton) {
        audioController?.prepareAudioPlayer()

        if let audioPlayer = audioController?.audioPlayer {
            if audioPlayer.isPlaying {
                audioController?.pauseAudio()
            } else {
                audioController?.playAudio()
            }
        }
    }
}
