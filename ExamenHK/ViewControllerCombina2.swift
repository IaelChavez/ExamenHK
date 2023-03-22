

import UIKit

class ViewControllerCombina2: UIViewController {
    @IBOutlet weak var btnRespuesta1: UIButton!
    @IBOutlet weak var btnRespuesta2: UIButton!
    @IBOutlet weak var btnRespuesta3: UIButton!
    @IBOutlet weak var btnLanzarDado: UIButton!
    @IBOutlet weak var btnReiniciarJuego: UIButton!
    
    var jugadores = [
        Jugador(turno: 0, posicion: 0, puntos: 0, racha: 0, vidas: 0),
        Jugador(turno: 0, posicion: 0, puntos: 0, racha: 0, vidas: 0)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func nuevaPartida(){
        var jugadorInicial: Int = Int.random(in: 0...1)
        if(jugadorInicial == jugadores[0].turno){
            jugadores[0].turno = 1
            jugadores[1].turno = 2
        }
        else{
            jugadores[1].turno = 1
            jugadores[0].turno = 2
            
        }
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
