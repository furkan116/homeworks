import SwiftUI

struct RSA: View {
    
    @State private var p: String = ""
    @State private var q: String = ""
    @State private var e: String = ""
    
    @State private var number: String = ""
    
    @State private var totientNumber: String = ""

    @State private var cryptedNumber: String = ""
    @State private var decryptedNumber: String = ""

    @State private var d: String = ""
    
    @State var activeAlert: Bool = false
    @State var alertText: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("P", text: $p)
                .onChange(of: p, perform: { text in
                    self.p = text.onlyNumber()
                })
            
            TextField("Q", text: $q)
                .onChange(of: q, perform: { text in
                    self.q = text.onlyNumber()
                })
            
            TextField("E", text: $e)
                .onChange(of: e, perform: { text in
                    self.e = text.onlyNumber()
                })
            
            TextField("Number", text: $number)
                .onChange(of: number, perform: { text in
                    self.number = text.onlyNumber()
                })
            
            Button {
                encrypt()
            } label: {
                Text("Encrypt")
            }
            
            
            Text("şifre: \(cryptedNumber)")
            Text("Toitent Sayısı: \(totientNumber)")

            Button {
                decrypt()
            } label: {
                Text("Decrypt")
            }
            
            Text("çözülen şifre: \(decryptedNumber)")
            Text("D: \(d)")
        }
        .alert(isPresented: $activeAlert) {
            Alert(title: Text("Dikkat"), message: Text(alertText))
        }
        .padding(.horizontal, 20)
    }
    
    func encrypt() {
        
        if p == "" ||  q == "" ||  e == "" || number == ""  {
            alertText = "Lütfen tüm boşlukları doldurunuz."
            activeAlert.toggle()
            return
        }
        
        let mod: Int = (Int(p)! * Int(q)!)
        let eint: Int = Int(e)!
        let numberint: Int = Int(number)!
        
        if eint > ((Int(p)! - 1) * (Int(q)! - 1)) {
            alertText = "E değeri p-1*q-1 den fazla olamaz"
            activeAlert.toggle()
            return
        }
        
        if eint == 1 {
            alertText = "E değeri asal olmalıdır"
            activeAlert.toggle()
            return
        }
        
        for i in stride(from: 2, to: sqrt(Double(eint)), by: 1) {
            if eint%Int(i) == 0 {
                alertText = "E değeri asal olmalıdır"
                activeAlert.toggle()
                return
            }
        }
        
        totientNumber = String(((Int(p)! - 1) * (Int(q)! - 1)))
        
        var power: Int = numberint
        
        for _ in 1...(eint-1) {
            power = power * numberint
            if power >= mod {
                power = power % mod
            }
        }
        cryptedNumber = String(power)
    }
    
    func decrypt() {
        if p == "" ||  q == "" ||  e == "" || number == ""  {
            alertText = "Lütfen tüm boşlukları doldurunuz."
            activeAlert.toggle()
            return
        }
        
        let mod: Int = (Int(p)! * Int(q)!)
        let eint: Int = Int(e)!
        let numberint: Int = Int(cryptedNumber)!
        
        if eint > ((Int(p)! - 1) * (Int(q)! - 1)) {
            e = "E değeri p-1*q-1 den fazla olamaz"
            return
        }
        
        if eint == 1 {
            alertText = "E değeri asal olmalıdır"
            activeAlert.toggle()
            return
        }
        
        for i in stride(from: 3, to: sqrt(Double(eint)), by: 2) {
            if eint%Int(i) == 0 {
                e = "E değeri asal olmalıdır"
                return
            }
        }
        
        totientNumber = String(((Int(p)! - 1) * (Int(q)! - 1)))

        var dint: Double = Double((((Double(totientNumber)!) * 0 + 1)/Double(eint)))

        var i = 1
        
        var isItPrime: Bool = false
        
        while !(dint.truncatingRemainder(dividingBy: 1) == 0) && !isItPrime  {
            
            dint = Double((((Double(totientNumber)!) * Double(i) + 1)/Double(eint)))
            i += 1
            
            
            for i in stride(from: 3, to: sqrt(dint), by: 2) {
                if Int(dint)%Int(i) == 0 {
                    isItPrime = false
                    break
                }
                isItPrime = true
            }
        }
                
        let newDint: Int = Int(dint)
        
        var power: Int = numberint

        for _ in 1...(newDint-1) {
            power = power * numberint
            if power >= mod {
                power = power % mod
            }
        }
        decryptedNumber = String(power)
        d = String(newDint)
    }
}

//For string character limitations
extension String {
    func onlyNumber() -> String {
        return self.filter {"0123456789".contains($0)}.prefix(2).uppercased()
    }
}
