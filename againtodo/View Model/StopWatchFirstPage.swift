import UIKit

struct StopWatchViewModel {
    var model = StopWatchModel(hour: 0, min: 0, sec: 0, secClick: 0, minClick : 0, hourClick : 0,clicker : 0,  timerFor: [])
    
    mutating func timerUpdated(pickerView: UIPickerView, label: UILabel, timer: Timer) {
        if model.clicker == 0 {
            model.sec += 1
            if model.min == 59 && model.sec == 60 {
                model.min = 0
                model.sec = 0
                model.hour += 1
            }else if model.sec == 60 {
                model.sec = 0
                model.min += 1
            }
        } else if model.clicker == 1 && model.sec != 0 || model.min != 0 || model.hour != 0{
            if model.min == 0 && model.sec == 0 {
                model.min = 59
                model.sec = 60
                model.hour -= 1
            }else if model.sec == 0 {
                model.sec = 60
                model.min -= 1
            }
            model.sec -= 1
        } else {
            timer.invalidate()
            pickerView.isHidden = false
            pickerView.selectRow(0, inComponent: 0, animated: false)
            pickerView.selectRow(0, inComponent: 1, animated: false)
            pickerView.selectRow(0, inComponent: 2, animated: false)
        }
        conditions(label: label)
    }
    
    func conditions(label: UILabel) {
        if model.min >= 10 && model.sec >= 10 && model.hour >= 10 {
            label.text = "\(model.hour):\(model.min):\(String(model.sec))"
        }else if model.hour >= 10 && model.sec >= 10{
            label.text = "\(model.hour):0\(model.min):\(String(model.sec))"
        }else if model.hour >= 10 && model.min >= 10{
            label.text = "\(model.hour):\(model.min):0\(String(model.sec))"
        }else if model.hour >= 10{
            label.text = "\(model.hour):0\(model.min):0\(String(model.sec))"
        }else if model.min >= 10 && model.sec >= 10{
            label.text = "0\(model.hour):\(model.min):\(String(model.sec))"
        }else if model.min >= 10  {
            label.text = "0\(model.hour):\(model.min):0\(String(model.sec))"
        }else if model.sec >= 10 {
            label.text = "0\(model.hour):0\(model.min):\(String(model.sec))"
        } else {
            label.text = "0\(model.hour):0\(model.min):0\(String(model.sec))"
        }
    }
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.image = UIImage(systemName: "timer")
        return imageView
    }()
    mutating func segmentedValueHasChanged(sender: UISegmentedControl, pickerView: UIPickerView, label: UILabel, timer: Timer){
        if sender.selectedSegmentIndex == 1 {
            pickerView.isHidden = false
            model.hour = 0
            model.min = 0
            model.sec = 0
            
            model.clicker = 1
            label.text = "00:00:00"
            timer.invalidate()
            
            imageView.image = UIImage(systemName: "stopwatch")
        } else if sender.selectedSegmentIndex == 0 {
            pickerView.isHidden = true
            model.hour = 0
            model.min = 0
            model.sec = 0

            model.clicker = 0
            label.text = "00:00:00"
            timer.invalidate()
            
            imageView.image = UIImage(systemName: "timer")
        }
    }
    
    mutating func startButtonTapped(pickerView: UIPickerView, timer: Timer) {
        timer.invalidate()

        if model.clicker == 1 {
            pickerView.isHidden = true
            model.hour = model.hourClick
            model.min = model.minClick
            model.sec = model.secClick
        }
        
    }
    
    mutating func stopButtonTapped(pickerView: UIPickerView, timer: Timer) {
        timer.invalidate()

        if model.clicker == 1 {
            pickerView.isHidden = false
            
            pickerView.selectRow(model.hour, inComponent: 0, animated: true)
            pickerView.selectRow(model.min, inComponent: 1, animated: true)
            pickerView.selectRow(model.sec, inComponent: 2, animated: true)
            
            model.hourClick = model.hour
            model.minClick = model.min
            model.secClick = model.sec
        }
    }
    
    mutating func restartButtonTapped(pickerView: UIPickerView, label: UILabel, timer: Timer) {
        timer.invalidate()

        if model.clicker == 1 {
            pickerView.isHidden = false
        }
        
        pickerView.selectRow(0, inComponent: 0, animated: true)
        pickerView.selectRow(0, inComponent: 1, animated: true)
        pickerView.selectRow(0, inComponent: 2, animated: true)
        model.sec = 0
        model.min = 0
        model.hour = 0
        
        model.hourClick = 0
        model.minClick = 0
        model.secClick = 0
        
        label.text = "00:00:00"
    }
    
    mutating func pickerViewUpdated(val1: String, val2: String, val3: String) {
        model.hourClick = Int(val1) ?? 0
        model.minClick = Int(val2) ?? 0
        model.secClick = Int(val3) ?? 0
    }
    
    mutating func lazy() -> [String]{
        for i in 0...59 {
            model.timerFor.append(String(i))
        }
        return model.timerFor
    }
}
