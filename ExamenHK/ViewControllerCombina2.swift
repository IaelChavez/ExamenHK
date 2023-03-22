import UIKit

class ViewControllerCombina2: UIViewController {

    @IBOutlet weak var btnRespuesta1: UIButton!
    @IBOutlet weak var btnRespuesta2: UIButton!
    @IBOutlet weak var btnRespuesta3: UIButton!
    @IBOutlet weak var btnLanzarDado: UIButton!
    @IBOutlet weak var btnReiniciarJuego: UIButton!
    @IBOutlet weak var scoreJugador1: UILabel!
    @IBOutlet weak var scoreJugador2: UILabel!
    @IBOutlet weak var rachaJugador1: UILabel!
    @IBOutlet weak var rachaJugador2: UILabel!
    @IBOutlet weak var preguntaLabel: UILabel!
    @IBOutlet weak var imageDados: UIImageView!
    @IBOutlet weak var turnoLabel: UILabel!
    
    var jugadores = [Jugador]()
    var turnoGeneral = 1
    var cadenaPregunta = ""
    var operadores:[String] = ["+","-","*","/"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reiniciarValores()
        nuevaPartida()
    }
    
    func nuevaPartida(){
        var jugadorInicial: Int = Int.random(in: 0...1)
        if(jugadorInicial == 0){
            jugadores[0].turno = 1
            jugadores[1].turno = 2
            turnoLabel.text = "Turno: J1"
        }
        else if(jugadorInicial == 1){
            jugadores[1].turno = 1
            jugadores[0].turno = 2
            turnoLabel.text = "Turno: J2"
        }
    }
    
    func asignarValores(){
        let n1: Int = Int.random(in: 0...100)
        let n2: Int = Int.random(in: 0...100)
        let index: Int = Int.random(in: 0...3)
        let falso1: Int = Int.random(in: 0...100)
        let falso2: Int = Int.random(in: 0...1000)
        let correcto: Int = Int.random(in: 0...2)
        
        var cadena = "\(n1)\(index)\(n2)"
        var respuesta = calcularExp(cadena)
        preguntaLabel.text = cadena
        
        if(correcto == 0){
            btnRespuesta1.setTitle(String(respuesta), for: .normal)
            btnRespuesta2.setTitle(String(Double(falso1)), for: .normal)
            btnRespuesta3.setTitle(String(Double(falso2)), for: .normal)
        }
        else if(correcto == 1){
            btnRespuesta2.setTitle(String(respuesta), for: .normal)
            btnRespuesta3.setTitle(String(Double(falso1)), for: .normal)
            btnRespuesta1.setTitle(String(Double(falso2)), for: .normal)
        }
        else if(correcto == 2){
            btnRespuesta3.setTitle(String(respuesta), for: .normal)
            btnRespuesta1.setTitle(String(Double(falso1)), for: .normal)
            btnRespuesta2.setTitle(String(Double(falso2)), for: .normal)
        }
        
        print("Respuesta: \(cadena)")
    }
    
    func calcularExp(_ cadena:String) -> Double {
        let ecuacion:String = cadena
        let expression:NSExpression = NSExpression(format: ecuacion)
        let resultado:Double = expression.expressionValue(with: nil, context: nil) as! Double
        return resultado
    }
    
    func generarPreguntados(){
        btnLanzarDado.isEnabled = false
        btnRespuesta2.isEnabled = false
    }
    
    func generarMates(){
        asignarValores()
        btnLanzarDado.isEnabled = false
    }
    
    func seleccionarJuego(_ opcion: Int){
        if(opcion == 1){
            generarMates()
        }
        else if(opcion == 2){
            generarPreguntados()
        }
    }
    
    func turnoJugador(_ dado: Int){
        if(jugadores[0].turno == turnoGeneral){
            turnoLabel.text = "Turno: J1"
            turnoGeneral += 1
            if(turnoGeneral == 3){
                turnoGeneral = 1
            }
        }
        else if(jugadores[1].turno == turnoGeneral){
            turnoLabel.text = "Turno: J2"
            turnoGeneral += 1
            if(turnoGeneral == 3){
                turnoGeneral = 1
            }
        }
        
    }
    
    func terminarPartida(){
        
    }
    
    func reiniciarValores(){
        jugadores = [
            Jugador(turno: 0, posicion: 0, puntos: 0, racha: 0, vidas: 0),
            Jugador(turno: 0, posicion: 0, puntos: 0, racha: 0, vidas: 0)
        ]
        scoreJugador1.text = "Score: \(jugadores[0].puntos)"
        rachaJugador1.text = "Racha: \(jugadores[0].racha)"
        scoreJugador2.text = "Score: \(jugadores[1].puntos)"
        rachaJugador2.text = "Racha: \(jugadores[1].racha)"
        imageDados.image = UIImage(named: "")
        preguntaLabel.text = ""
    }
    
    func resetBotones(){
        btnRespuesta1.isEnabled = false
        btnRespuesta2.isEnabled = false
        btnRespuesta3.isEnabled = false
    }
    
    func tiroDado()->[Int]{
        var valores = [0,0]
        var tiradaDado: Int = Int.random(in: 1...6)
        imageDados.image = UIImage(named: "D\(tiradaDado)")
        if(tiradaDado % 2 == 0){
            valores[1] = 1
        }else{
            valores[1] = 2
        }
        return valores
    }
 
    @IBAction func actionReiniciar(_ sender: UIButton) {
        resetBotones()
        reiniciarValores()
        nuevaPartida()
    }
    
    @IBAction func ActionLanzarDado(_ sender: UIButton) {
        var valorDado = tiroDado()
        turnoJugador(valorDado[0])
    }
    
    
    @IBAction func actionRespuesta1(_ sender: UIButton) {
        guard let btnTitle = sender.titleLabel?.text else { return }
    }
    
    @IBAction func actionRespuesta2(_ sender: UIButton) {
        guard let btnTitle = sender.titleLabel?.text else { return }
    }
    
    @IBAction func actionRespuesta3(_ sender: UIButton) {
        guard let btnTitle = sender.titleLabel?.text else { return }
    }
}

struct Jugador {
    var turno: Int
    var posicion: Int
    var puntos: Int
    var racha: Int
    var vidas: Int
}
