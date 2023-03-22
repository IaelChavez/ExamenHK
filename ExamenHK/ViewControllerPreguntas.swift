import UIKit

class ViewControllerPreguntas: UIViewController {
    @IBOutlet weak var btnBasico: UIButton!
    @IBOutlet weak var btnIntermedio: UIButton!
    @IBOutlet weak var btnAvanzado: UIButton!
    @IBOutlet weak var btnTrue: UIButton!
    @IBOutlet weak var btnFalse: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var labelPreguntas: UILabel!
    @IBOutlet weak var imageVidas: UIImageView!
    @IBOutlet weak var imagePregunta: UIImageView!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var rachaLabel: UILabel!
    
    var puntuacion:Int = 0
    var vidasRestantes:Int = 0
    var limitePuntos: Int = 0
    var posicion: Int = 0
    var racha: Int = 0
    var preguntas = [Pregunta]()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            score.text = "Score: \(puntuacion)"
            rachaLabel.text = "Racha: \(racha)"
            labelPreguntas.text = ""
            resetButtons()
        }
        
    func llenarPreguntas(){
        preguntas = [
            Pregunta(pregunta: "La historia de Hollow Knight gira en torno a un caballero que busca explorar un reino subterráneo lleno de insectos:",
            imagen: "1vida",
            respuesta: "True"),
            Pregunta(pregunta: "El juego fue desarrollado por la compañía Team Cherry:",
            imagen: "1vida",
            respuesta: "True"),
            Pregunta(pregunta: "Hollow Knight fue lanzado en 2018:",
            imagen: "1vida",
            respuesta: "False"),
            Pregunta(pregunta: "El juego cuenta con un sistema de combate basado en esquivar y atacar:",
            imagen: "1vida",
            respuesta: "True"),
            Pregunta(pregunta: "El personaje principal puede saltar indefinidamente sin caer:",
            imagen: "1vida",
            respuesta: "False"),
            Pregunta(pregunta: "El juego cuenta con un modo multijugador:",
            imagen: "1vida",
            respuesta: "False"),
            Pregunta(pregunta: "El personaje principal puede adquirir nuevas habilidades a lo largo del juego:",
            imagen: "1vida",
            respuesta: "True"),
            Pregunta(pregunta: "El reino subterráneo en el que se desarrolla la historia de Hollow Knight se llama Hallownest:",
            imagen: "1vida",
            respuesta: "True"),
            Pregunta(pregunta: "El juego cuenta con una gran cantidad de jefes para derrotar:",
            imagen: "1vida",
            respuesta: "True"),
            Pregunta(pregunta: "La música del juego fue compuesta por Christopher Larkin:",
            imagen: "1vida",
            respuesta: "True"),
            Pregunta(pregunta: "El jugador puede elegir diferentes armas para luchar:",
            imagen: "1vida",
            respuesta: "False"),
            Pregunta(pregunta: "El jugador puede equipar diferentes amuletos para obtener habilidades especiales:",
            imagen: "1vida",
            respuesta: "True"),
            Pregunta(pregunta: "La moneda del juego se llama Geo:",
            imagen: "1vida",
            respuesta: "True"),
            Pregunta(pregunta: "El jugador puede explorar diferentes áreas del reino subterráneo en el orden que prefiera:",
            imagen: "1vida",
            respuesta: "False"),
            Pregunta(pregunta: "La dificultad del juego aumenta gradualmente a medida que avanza el jugador:",
            imagen: "1vida",
            respuesta: "True"),
            Pregunta(pregunta: "El juego cuenta con un sistema de guardado automático:",
            imagen: "1vida",
            respuesta: "True")
            ]
    }
        
        func seleccionarPreguntas(){
            posicion = Int.random(in: 0...preguntas.count-1)
            labelPreguntas.text = "\(preguntas[posicion].pregunta)"
            imagePregunta.image = UIImage(named: preguntas[posicion].imagen)
            print(preguntas[posicion].respuesta)
            
        }
    func pararJuego(){
        if(puntuacion == limitePuntos){
            score.text = "Score: \(puntuacion)"
            labelPreguntas.text = "Ganaste"
            resetButtons()
        }
        else if(vidasRestantes == 0 ){
            imageVidas.image = UIImage(named: "")
            score.text = "Score: \(puntuacion)"
            labelPreguntas.text = "Perdiste"
            resetButtons()
        }
    }
    func resetButtons(){
        btnTrue.isEnabled = false
        btnFalse.isEnabled = false
        
        btnBasico.isEnabled = true
        btnIntermedio.isEnabled = true
        btnAvanzado.isEnabled = true
    }
    
    func nuevoJuego(_ vida: Int, _ limitePunto: Int){
        llenarPreguntas()
        puntuacion = 0
        racha = 0
        seleccionarPreguntas()
        labelPreguntas.text = ""
        score.text = "Score: \(puntuacion)"
        rachaLabel.text = "Racha: \(racha)"
        vidasRestantes = vida
        limitePuntos = limitePunto
        
        btnTrue.isEnabled = true
        btnFalse.isEnabled = true
        
        btnBasico.isEnabled = false
        btnIntermedio.isEnabled = false
        btnAvanzado.isEnabled = false
        seleccionarPreguntas()
    }
    
    func comprobarRespuesta(_ title: String){
        
        if(title == preguntas[posicion].respuesta) {
            puntuacion += 1
            racha += 1
        }
        else{
            vidasRestantes -= 1
            racha = 0
            if(vidasRestantes == 2){
                imageVidas.image = UIImage(named: "2vidasw")
            }
            else if(vidasRestantes == 1){
                imageVidas.image = UIImage(named: "1vida")
            }
            else if(vidasRestantes == 0){
                imageVidas.image = UIImage(named: "")
            }
        }
        score.text = "Score: \(puntuacion)"
        rachaLabel.text = "Racha: \(racha)"
        preguntas.remove(at: posicion)
        seleccionarPreguntas()
        pararJuego()
    }
    @IBAction func actionTrue(_ sender: UIButton) {
        guard let btnTitle = sender.titleLabel?.text else { return }
        comprobarRespuesta(btnTitle)
    }
    
    
    @IBAction func actionFalse(_ sender: UIButton) {
        guard let btnTitle = sender.titleLabel?.text else { return  }
        comprobarRespuesta(btnTitle)
    }
    
    @IBAction func btnResetAll(_ sender: UIButton) {
        imageVidas.image = UIImage(named: "vidascompletas")
        imagePregunta.image = UIImage(named: "")
        labelPreguntas.text = ""
        score.text = "Score: 0"
        rachaLabel.text = "Racha: 0"
        resetButtons()
        
    }
    
    @IBAction func actionBasico(_ sender: UIButton) {
        imageVidas.image = UIImage(named: "vidascompletas")
        nuevoJuego(3, 5)
    }
    
    @IBAction func actionIntermedio(_ sender: UIButton) {
        imageVidas.image = UIImage(named: "2vidasw")
        nuevoJuego(2, 7)
    }
    
    @IBAction func actionAvanzado(_ sender: UIButton) {
        imageVidas.image = UIImage(named: "1vida")
        nuevoJuego(1, 10)
    }
    
    
    
}

    struct Pregunta {
        var pregunta: String
        var imagen: String
        var respuesta: String
    }
