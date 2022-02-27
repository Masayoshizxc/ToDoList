import UIKit
class AllView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var viewModel = StopWatchViewModel()
    var arr: [String] = []
    var timer = Timer()

    let pickerView: UIPickerView = {
        let p = UIPickerView()
        p.translatesAutoresizingMaskIntoConstraints = false
        return p
    }()
    let restartButton: UIButton = {
        let reset = UIButton()
        reset.tintColor = .black
        reset.setBackgroundImage(UIImage(systemName: "square.circle.fill"), for: .normal)
        reset.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        reset.layer.cornerRadius = 30
        reset.translatesAutoresizingMaskIntoConstraints = false
        return reset
    }()
    
    let stopButton: UIButton = {
        let stop = UIButton()
        stop.setBackgroundImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        stop.tintColor = .black
        stop.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
        stop.layer.cornerRadius = 30
        stop.translatesAutoresizingMaskIntoConstraints = false
        return stop
    }()
    
    let startButton: UIButton = {
        let start = UIButton()
        start.tintColor = .black
        start.setBackgroundImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        start.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        start.layer.cornerRadius = 30
        start.translatesAutoresizingMaskIntoConstraints = false
        return start
    }()
    
    let label: UILabel = {
        let l = UILabel()
        l.text = "00:00:00"
        l.font = .systemFont(ofSize: 47)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let mySegmentedControl: UISegmentedControl = {
        let s = UISegmentedControl(items: ["StopWatch", "Timer"])
        let mySegmentedControl = UISegmentedControl()
        s.selectedSegmentIndex = 0
        s.tintColor = .yellow
        s.backgroundColor = .white
        s.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    override func viewDidLoad() {
        view.backgroundColor = .systemYellow
        
        arr = viewModel.lazy()
        pickerView.isHidden = true
        pickerView.dataSource = self
        pickerView.delegate = self

        
        view.addSubview(mySegmentedControl)
        view.addSubview(startButton)
        view.addSubview(stopButton)
        view.addSubview(restartButton)
        view.addSubview(pickerView)
        view.addSubview(label)
        view.addSubview(viewModel.imageView)
        
        setUpConstraints()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let val1 = arr[pickerView.selectedRow(inComponent: 0)]
        let val2 = arr[pickerView.selectedRow(inComponent: 1)]
        let val3 = arr[pickerView.selectedRow(inComponent: 2)]
        viewModel.pickerViewUpdated(val1: val1, val2: val2, val3: val3)
    }


    
    @objc func restartButtonTapped() {
        viewModel.restartButtonTapped(pickerView: pickerView, label: label, timer: timer)
    }
    
    @objc func stopButtonTapped() {
        viewModel.stopButtonTapped(pickerView: pickerView, timer: timer)
    }
    
    @objc func startButtonTapped() {
        viewModel.startButtonTapped(pickerView: pickerView, timer: timer)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!){
        viewModel.segmentedValueHasChanged(sender: sender, pickerView: pickerView, label: label, timer: timer)
    }
    
    func conditions() {
        viewModel.conditions(label: label)
    }
    
    @objc func update() {
        viewModel.timerUpdated(pickerView: pickerView, label: label, timer: timer)
    }
    
//MARK: CONSTRAINTS
    
    func setUpConstraints() {
        viewModel.imageView.frame = CGRect(x: 154, y: 51.5, width: 100, height: 100)
        
        mySegmentedControl.frame = CGRect(x: 104, y: 164, width: 206, height: 32)
        
        label.frame = CGRect(x: 0, y: 235, width: 414, height: 85)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 70)

        
        pickerView.frame = CGRect(x: 0, y: 250, width: 414, height: 300)
        
        restartButton.frame = CGRect(x: 66, y: 605, width: 80, height: 70)
        
        stopButton.frame = CGRect(x: 173, y: 605, width: 80, height: 70)
        
        startButton.frame = CGRect(x: 278.5, y: 605, width: 80, height: 70)

    }
    
}
