
import UIKit

class ViewControllerMatematik: UIViewController {
    
    @IBOutlet weak var numero1: UILabel!
    @IBOutlet weak var numero2: UILabel!
    @IBOutlet weak var operador: UILabel!
    
    @IBOutlet weak var btnResultado1: UIButton!
    @IBOutlet weak var btnResultado2: UIButton!
    @IBOutlet weak var btnResultado3: UIButton!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var rachaLabel: UILabel!
    @IBOutlet weak var imageVidas: UIImageView!
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var btnBasico: UIButton!
    @IBOutlet weak var btnIntermedio: UIButton!
    @IBOutlet weak var btnAvanzado: UIButton!
    
    var operadores:[String] = ["+","-","*","/"]
    var puntuacion:Int = 0
    var vidasRestantes:Int = 3
    var limitePuntos: Int = 0
    var racha: Int = 0
        
        var respFinal: Double = 0

        override func viewDidLoad() {
            score.text = "Score: \(puntuacion)"
            rachaLabel.text = "Racha: \(racha)"
            numero1.text = ""
            numero2.text = ""
            resetButtons()
        }
        
        func generarRandoms()->[Int]{
            var aleatorios: [Int] = [0,0,0]
            let n1: Int = Int.random(in: 0...100)
            let n2: Int = Int.random(in: 0...100)
            let falso1: Int = Int.random(in: 0...100)
            let falso2: Int = Int.random(in: 0...1000)
            let operadores: Int = Int.random(in: 0...3)
            let botonCorrecto: Int = Int.random(in: 0...2)
            
            aleatorios = [n1,n2,operadores, botonCorrecto, falso1, falso2]
            
            return aleatorios
        }
        
        func asignarValores(){
            var valores = generarRandoms()
            
            numero1.text = String(valores[0])
            numero2.text = String(valores[1])
            operador.text = operadores[valores[2]]
            
            respFinal = calcularExp("\(valores[0])\(operadores[valores[2]])\(valores[1])")
            
            asignarBotonCorrecto(valores[3],respFinal, valores[4], valores[5])
            
            print("Respuesta " + String(respFinal))
            
        }
        
        func calcularExp(_ cadena:String) -> Double {
            let ecuacion:String = cadena
            let expression:NSExpression = NSExpression(format: ecuacion)
            let resultado:Double = expression.expressionValue(with: nil, context: nil) as! Double
            return resultado
        }
        
        func asignarBotonCorrecto(_ correcto: Int, _ resultado: Double, _ falso1: Int,_ falso2: Int){
            if(correcto == 0){
                btnResultado1.setTitle(String(resultado), for: .normal)
                btnResultado2.setTitle(String(Double(falso1)), for: .normal)
                btnResultado3.setTitle(String(Double(falso2)), for: .normal)
                print(btnResultado1.currentTitle)
            }
            else if(correcto == 1){
                btnResultado2.setTitle(String(resultado), for: .normal)
                btnResultado3.setTitle(String(Double(falso1)), for: .normal)
                btnResultado1.setTitle(String(Double(falso2)), for: .normal)
                print(btnResultado2.currentTitle)
            }
            else if(correcto == 2){
                btnResultado3.setTitle(String(resultado), for: .normal)
                btnResultado1.setTitle(String(Double(falso1)), for: .normal)
                btnResultado2.setTitle(String(Double(falso2)), for: .normal)
                print(btnResultado3.currentTitle)
            }
        }
        
        func RespuestaCorrecta(){
            image.image = UIImage(named: "correcto")
            puntuacion += 1
            racha +=  1
            score.text = "Score: " + String(puntuacion)
            rachaLabel.text = "Racha: \(racha)"
            pararJuego()
            generarRandoms()
            asignarValores()
        }
        func RespuestaIncorrecta(){
            image.image = UIImage(named: "incorrecto")
            vidasRestantes -= 1
            racha = 0
            rachaLabel.text = "Racha: \(racha)"
            if(vidasRestantes == 2){
                imageVidas.image = UIImage(named: "2vidasw")
            }
            else if(vidasRestantes == 1){
                imageVidas.image = UIImage(named: "1vida")
            }
            
            pararJuego()
            generarRandoms()
            asignarValores()
        }
        
    @IBAction func btnOption1(_ sender: Any) {
        if((Double(btnResultado1.currentTitle ?? "")) == respFinal){
            RespuestaCorrecta()
        }
        else if((Double(btnResultado1.currentTitle ?? "")) != respFinal){
            RespuestaIncorrecta()
        }
    }
        
    @IBAction func btnOption2(_ sender: Any) {
        if((Double(btnResultado2.currentTitle ?? "")) == respFinal){
            RespuestaCorrecta()
        }
        else if((Double(btnResultado2.currentTitle ?? "")) != respFinal){
            RespuestaIncorrecta()
        }
    }
    
    @IBAction func btnOption3(_ sender: Any) {
        if((Double(btnResultado3.currentTitle ?? "")) == respFinal){
            RespuestaCorrecta()
        }
        else if((Double(btnResultado3.currentTitle ?? "")) != respFinal){
            RespuestaIncorrecta()
        }
    }
        
        func pararJuego(){
            if(puntuacion == limitePuntos){
                score.text = "Score: " + String(puntuacion)
                numero1.text = ""
                numero2.text = ""
                operador.text = ""
                resetButtons()
            }
            else if(vidasRestantes == 0){
                imageVidas.image = UIImage(named: "")
                image.image = UIImage(named: "incorrecto")
                score.text = "Score: " + String(puntuacion)
                numero1.text = ""
                numero2.text = ""
                operador.text = ""
                resetButtons()
            }
        }
    
    func resetButtons(){
        btnResultado1.isEnabled = false
        btnResultado2.isEnabled = false
        btnResultado3.isEnabled = false
        
        btnBasico.isEnabled = true
        btnIntermedio.isEnabled = true
        btnAvanzado.isEnabled = true
    }
    
    func nuevoJuego(_ vida: Int, _ limitePunto: Int){
        puntuacion = 0
        racha = 0
        asignarValores()
        vidasRestantes = vida
        limitePuntos = limitePunto
        btnBasico.isEnabled = false
        btnIntermedio.isEnabled = false
        btnAvanzado.isEnabled = false
        btnResultado1.isEnabled = true
        btnResultado2.isEnabled = true
        btnResultado3.isEnabled = true
    }
    
    @IBAction func btnResetAll(_ sender: Any) {
        puntuacion = 0
        racha = 0
        image.image = UIImage(named: "")
        imageVidas.image = UIImage(named: "vidascompletas")
        score.text = "Score: \(puntuacion)"
        rachaLabel.text = "Racha: \(racha)"
        numero1.text = ""
        numero2.text = ""
        operador.text = ""
        resetButtons()
    }
    
    @IBAction func actionBasico(_ sender: Any) {
        imageVidas.image = UIImage(named: "vidascompletas")
        nuevoJuego(3,5)
    }
    
    @IBAction func actionIntermedio(_ sender: Any) {
        imageVidas.image = UIImage(named: "2vidasw")
        nuevoJuego(2,7)
    }
    
    @IBAction func actionAvanzado(_ sender: Any) {
        imageVidas.image = UIImage(named: "1vida")
        nuevoJuego(1,10)
    }
    }
