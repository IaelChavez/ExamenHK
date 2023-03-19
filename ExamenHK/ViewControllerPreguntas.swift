//
//  ViewControllerPreguntas.swift
//  ExamenHK
//
//  Created by ec2-user on 3/19/23.
//

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
    @IBOutlet weak var score: UILabel!
    
    var puntuacion:Int = 0
    var vidasRestantes:Int = 0
    var limitePuntos: Int = 0
    var posicion:Int = 0
    var preguntasSeleccionadas = [Pregunta]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            score.text = "Score: \(puntuacion)"
            labelPreguntas.text = ""
            resetButtons()
        }
        
        func seleccionarPreguntas(){
            var preguntas = [
                Pregunta(pregunta: "¿Hornet es una araña?",
                         imagen: "",
                         respuesta: "True"),
                Pregunta(pregunta: "¿Hornet es una pelona?",
                         imagen: "",
                         respuesta: "True"),
                Pregunta(pregunta: "¿Hornet es una jugador de lol?",
                         imagen: "",
                         respuesta: "True"),
                Pregunta(pregunta: "¿Hornet es una mano?",
                         imagen: "",
                         respuesta: "True"),
                Pregunta(pregunta: "¿Hornet es una lata?",
                         imagen: "",
                         respuesta: "True"),
                Pregunta(pregunta: "¿Hornet es una hormiga?",
                         imagen: "",
                         respuesta: "True"),
                Pregunta(pregunta: "¿Hornet es una jojo fan?",
                         imagen: "",
                         respuesta: "False"),
                Pregunta(pregunta: "¿Hornet es una tortuga?",
                         imagen: "",
                         respuesta: "False"),
                Pregunta(pregunta: "¿Hornet es una furra?",
                         imagen: "",
                         respuesta: "False"),
                Pregunta(pregunta: "¿Hornet es una loba?",
                         imagen: "",
                         respuesta: "False"),
                Pregunta(pregunta: "¿Hornet es una rata?",
                         imagen: "",
                         respuesta: "False"),
                Pregunta(pregunta: "¿Hornet es una cabra?",
                         imagen: "",
                         respuesta: "False"),
                    Pregunta(pregunta: "¿Hornet es una vaca?",
                             imagen: "",
                             respuesta: "False")
                ]
            let numPreguntas = 11
            var i = 0
            while preguntasSeleccionadas.count < numPreguntas {
                let preguntaAleatoria = preguntas.randomElement()!
                if(preguntas[i].pregunta != preguntaAleatoria.pregunta ){
                    preguntasSeleccionadas.append(preguntaAleatoria)
                    i += 1
                }
            }
            labelPreguntas.text = "\(preguntasSeleccionadas[0].pregunta)"
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
        puntuacion = 0
        posicion = 0
        labelPreguntas.text = ""
        score.text = "Score: \(puntuacion)"
        preguntasSeleccionadas = [Pregunta]()
        seleccionarPreguntas()
        vidasRestantes = vida
        limitePuntos = limitePunto
        
        btnTrue.isEnabled = true
        btnFalse.isEnabled = true
        
        btnBasico.isEnabled = false
        btnIntermedio.isEnabled = false
        btnAvanzado.isEnabled = false
    }
    
    func comprobarRespuesta(_ title: String){
        
        if(title == preguntasSeleccionadas[posicion].respuesta || title == preguntasSeleccionadas[posicion].respuesta ) {
            puntuacion += 1
            print("correcto")
        }
        else{
            print("incorrecto")
            vidasRestantes -= 1
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
        posicion += 1
        labelPreguntas.text = "\(preguntasSeleccionadas[posicion].pregunta)"
        score.text = "Score: \(puntuacion)"
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
        imageVidas.image = UIImage(named: "")
        labelPreguntas.text = ""
        score.text = "Score: 0"
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
