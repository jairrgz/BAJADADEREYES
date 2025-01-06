//
//  ViewController.swift
//  BAJADADEREYES
//
//  Created by Jorge Jair Ramirez Gaston Zuloeta on 5/01/25.
//

import UIKit


class ReyesMagosViewController: UIViewController {
    
    // MARK: - Properties
    private var reyesMagosView: ReyesMagosView!
    private var animator: UIViewPropertyAnimator?
    private let starImageView = UIImageView()
    private var stars: [UIView] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupStars()
        setupReyesMagos()
        setupAnimations()
    }
    
    // MARK: - Setup Methods
    private func setupBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 0.1, green: 0.1, blue: 0.3, alpha: 1.0).cgColor,
            UIColor(red: 0.2, green: 0.2, blue: 0.4, alpha: 1.0).cgColor
        ]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        // Setup Moon
        let moonView = UIView(frame: CGRect(x: view.bounds.width - 100, y: 50, width: 60, height: 60))
        moonView.backgroundColor = .white
        moonView.layer.cornerRadius = 30
        moonView.alpha = 0.9
        view.addSubview(moonView)
    }
    
    private func setupStars() {
        // Create twinkling stars
        for _ in 0...100 {
            let starView = UIView(frame: CGRect(x: 0, y: 0, width: 2, height: 2))
            starView.backgroundColor = .white
            starView.center = CGPoint(
                x: CGFloat.random(in: 0...view.bounds.width),
                y: CGFloat.random(in: 0...view.bounds.height/2)
            )
            stars.append(starView)
            view.addSubview(starView)
            
            animateStar(starView)
        }
        
        // Setup Bethlehem Star
        starImageView.frame = CGRect(x: view.bounds.width/2 - 30, y: 50, width: 60, height: 60)
        starImageView.tintColor = .yellow
        starImageView.contentMode = .scaleAspectFit
        if let starImage = UIImage(systemName: "star.fill") {
            starImageView.image = starImage
        }
        view.addSubview(starImageView)
    }
    
    private func setupReyesMagos() {
        reyesMagosView = ReyesMagosView(frame: CGRect(
            x: -300,
            y: view.bounds.height - 300,
            width: 300,
            height: 200
        ))
        view.addSubview(reyesMagosView)
    }
    
    // MARK: - Animation Methods
    private func setupAnimations() {
        // Animate Reyes Magos
        UIView.animate(withDuration: 10.0,
                      delay: 0,
                      options: [.repeat, .curveLinear],
                      animations: {
            self.reyesMagosView.frame.origin.x = self.view.bounds.width + 300
        })
        
        // Animate Bethlehem Star
        UIView.animate(withDuration: 2.0,
                      delay: 0,
                      options: [.repeat, .autoreverse],
                      animations: {
            self.starImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        })
    }
    
    private func animateStar(_ starView: UIView) {
        UIView.animate(withDuration: Double.random(in: 0.5...2.0),
                      delay: 0,
                      options: [.repeat, .autoreverse],
                      animations: {
            starView.alpha = CGFloat.random(in: 0.3...1.0)
        })
    }
}

// MARK: - ReyMagoView
class ReyMagoView: UIView {
    private let colorTunica: UIColor
    private let nombre: String
    
    init(frame: CGRect, color: UIColor, nombre: String) {
        self.colorTunica = color
        self.nombre = nombre
        super.init(frame: frame)
        setupReyMago()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupReyMago() {
        // Cabeza
        let cabezaView = UIView(frame: CGRect(x: frame.width/4, y: 0, width: 40, height: 40))
        cabezaView.backgroundColor = UIColor(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)
        cabezaView.layer.cornerRadius = 20
        addSubview(cabezaView)
        
        // Corona
        let coronaView = UIView(frame: CGRect(x: frame.width/4 - 5, y: -10, width: 50, height: 20))
        coronaView.backgroundColor = .yellow
        coronaView.layer.cornerRadius = 5
        addSubview(coronaView)
        
        // Túnica
        let tunicaView = UIView(frame: CGRect(x: frame.width/4 - 10, y: 40, width: 60, height: 100))
        tunicaView.backgroundColor = colorTunica
        tunicaView.layer.cornerRadius = 10
        addSubview(tunicaView)
        
        // Nombre
        let nombreLabel = UILabel(frame: CGRect(x: 0, y: 150, width: frame.width, height: 20))
        nombreLabel.text = nombre
        nombreLabel.textAlignment = .center
        nombreLabel.textColor = .white
        nombreLabel.font = .boldSystemFont(ofSize: 14)
        addSubview(nombreLabel)
    }
}

// MARK: - ReyesMagosView
class ReyesMagosView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupReyesMagos()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupReyesMagos() {
        // Melchor
        let melchorView = ReyMagoView(
            frame: CGRect(x: 0, y: 0, width: 100, height: 200),
            color: .purple,
            nombre: "Melchor"
        )
        addSubview(melchorView)
        
        // Gaspar
        let gasparView = ReyMagoView(
            frame: CGRect(x: 100, y: 0, width: 100, height: 200),
            color: .green,
            nombre: "Gaspar"
        )
        addSubview(gasparView)
        
        // Baltasar
        let baltasarView = ReyMagoView(
            frame: CGRect(x: 200, y: 0, width: 100, height: 200),
            color: .red,
            nombre: "Baltasar"
        )
        addSubview(baltasarView)
        
        // Añadir camellos y regalos
        setupCamellos()
        setupRegalos()
    }
    
    private func setupCamellos() {
        for i in 0...2 {
            let camelloView = createCamelloView()
            camelloView.frame.origin.x = CGFloat(i * 100)
            camelloView.frame.origin.y = 50
            insertSubview(camelloView, at: 0)
        }
    }
    
    private func createCamelloView() -> UIView {
        let camelloView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 60))
        
        // Cuerpo del camello
        let cuerpoView = UIView(frame: CGRect(x: 0, y: 20, width: 60, height: 40))
        cuerpoView.backgroundColor = UIColor(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0)
        cuerpoView.layer.cornerRadius = 20
        camelloView.addSubview(cuerpoView)
        
        // Cuello y cabeza
        let cuelloPath = UIBezierPath()
        cuelloPath.move(to: CGPoint(x: 10, y: 40))
        cuelloPath.addCurve(to: CGPoint(x: 0, y: 10),
                           controlPoint1: CGPoint(x: 10, y: 30),
                           controlPoint2: CGPoint(x: 0, y: 20))
        
        let cuelloLayer = CAShapeLayer()
        cuelloLayer.path = cuelloPath.cgPath
        cuelloLayer.fillColor = UIColor(red: 0.8, green: 0.6, blue: 0.4, alpha: 1.0).cgColor
        camelloView.layer.addSublayer(cuelloLayer)
        
        return camelloView
    }
    
    private func setupRegalos() {
        for i in 0...2 {
            let regaloView = UIView(frame: CGRect(x: CGFloat(i * 100 + 30), y: 120, width: 30, height: 30))
            regaloView.backgroundColor = [.yellow, .purple, .red][i]
            regaloView.layer.cornerRadius = 5
            addSubview(regaloView)
        }
    }
}


import SwiftUI
struct ReyesMagosViewControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return ReyesMagosViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Aquí puedes actualizar el UIViewController si es necesario
    }
}

// Vista de Preview de SwiftUI
#Preview {
    ReyesMagosViewControllerPreview()
        .edgesIgnoringSafeArea(.all)
}

