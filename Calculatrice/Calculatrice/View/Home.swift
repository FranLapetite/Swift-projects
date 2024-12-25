//
//  Home.swift
//  Calculatrice
//
//  Created by Françoise  Lapetite on 23/02/2024.
//

import SwiftUI

struct Home: View {
    @State var displayValue = "0"
    @State var computeValue = 0
    @State var CurrentOperator: Operation = .none
    //buttons
    let buttons: [[CalculatorButtons]] =
    [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .substract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equals]
    ]
    
    var body: some View {
        
        ZStack{
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack{
                //Display
                Spacer()
                HStack{
                    Spacer()
                    Text("\(displayValue)")
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding()
                
                //buttons
                ForEach(buttons, id:\.self)
                {
                    row in
                    HStack(spacing: 12) {
                        ForEach(row, id:\.self)
                        {
                            item in
                            Button
                            {
                                self.didtap(button: item)
                            }
                        label: {
                            Text(item.rawValue)
                                .font(.system(size: 32))
                                .frame(width: self.buttonWidth(item: item), height: self.buttonHeight())
                                .background(item.buttoncolor)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            
                                .foregroundColor(.white)
                        }
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
        
    }
    func buttonWidth(item:CalculatorButtons) -> CGFloat
    {
        if item == .zero
        {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    func buttonHeight() -> CGFloat
    {
        (UIScreen.main.bounds.width - (5*12)) / 4
    }
    func didtap(button: CalculatorButtons)
    {
        switch button {
        case .add, .substract, .divide, .multiply, .equals:
            if button == .add
            {
                self.CurrentOperator = .add
                self.computeValue = Int(self.displayValue) ?? 0
            }
            if button == .substract
            {
                self.CurrentOperator = .substract
                self.computeValue = Int(self.displayValue) ?? 0
            }
            if button == .divide
            {
                self.CurrentOperator = .divide
                self.computeValue = Int(self.displayValue) ?? 0
            }
            if button == .multiply
            {
                self.CurrentOperator = .multiply
                self.computeValue = Int(self.displayValue) ?? 0
            }
            if button == .equals
            {
                let runningValue = self.computeValue
                let currentvalue = Int(self.displayValue) ?? 0
                switch self.CurrentOperator {
                case .add:
                    self.displayValue = "\(runningValue + currentvalue)"
                case .divide:
                    self.displayValue = "\(runningValue / currentvalue)"
                case .multiply:
                    self.displayValue = "\(runningValue * currentvalue)"
                case .substract:
                    self.displayValue = "\(runningValue - currentvalue)"
                case .none:
                    break
                }
            }
            if button != .equals
            {
                self.displayValue = "0"
            }
        case .clear:
                self.displayValue = "0"
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.displayValue == "0"
            {
                displayValue = number
            }
            else
            {
                self.displayValue = "\(self.displayValue)\(number)"
            }
            
        }
    }
}

#Preview {
    Home()
}
