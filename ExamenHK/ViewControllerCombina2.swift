

import UIKit

class ViewControllerCombina2: UIViewController {
    @IBOutlet weak var btnRespuesta1: UIButton!
    @IBOutlet weak var btnRespuesta2: UIButton!
    @IBOutlet weak var btnRespuesta3: UIButton!
    @IBOutlet weak var btnLanzarDado: UIButton!
    @IBOutlet weak var btnReiniciarJuego: UIButton!
    
    var jugadores = [
        Jugador(turno: <#T##Int#>, posicion: <#T##Int#>, puntos: <#T##Int#>, racha: <#T##Int#>, vidas: <#T##Int#>),
        Jugador(turno: <#T##Int#>, posicion: <#T##Int#>, puntos: <#T##Int#>, racha: <#T##Int#>, vidas: <#T##Int#>)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func terminarPartida(){
        
    }
    
    func reiniciarValores(){
        
    }
    
    func resetBotones(){
        btnRespuesta1.isEnabled = false
        btnRespuesta2.isEnabled = false
        btnRespuesta3.isEnabled = false
    }
 
    @IBAction func actionReiniciar(_ sender: UIButton) {
        resetBotones()
    }
    
    @IBAction func ActionLanzarDado(_ sender: UIButton) {
        
    }
    
}

struct Jugador {
    var turno: Int
    var posicion: Int
    var puntos: Int
    var racha: Int
    var vidas: Int
}
