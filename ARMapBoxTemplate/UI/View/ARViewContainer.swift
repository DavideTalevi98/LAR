//
//  ARViewContainer.swift
//  ARMapBoxTemplate
//
//  Created by Davide Talevi on 09/01/24.
//

import SwiftUI
import RealityKit
import ARKit
import MapboxSceneKit

struct ARViewContainer: UIViewRepresentable {
    @Binding var arView: ARSCNView
    @Binding var POIs: [(CLLocationDegrees, CLLocationDegrees)]
    @Binding var userCoordinate: CLLocation?
    @Binding var path: Bool
    
    var terrain: SCNNode?
    
    let styles = ["mapbox/outdoors-v10", "mapbox/satellite-v9", "mapbox/navigation-preview-day-v2"]
    @Binding var terrainNode: TerrainNode?
    
    func makeUIView(context: Context) -> ARSCNView {
        restartTracking()
        
        let scale = Float(0.333 * 2) / terrainNode!.boundingSphere.radius
        terrainNode!.transform = SCNMatrix4MakeScale(scale, scale, scale)
        terrainNode!.position = SCNVector3(0, -0.2, -0.3)
        
        terrainNode!.geometry?.materials = defaultMaterials()
        
        self.arView.scene.rootNode.addChildNode(terrainNode!)
                
        applyStyle(styles[1])
        
        return arView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {}
    
    private func restartTracking() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.isLightEstimationEnabled = true
        
        arView.session.run(configuration, options: [.removeExistingAnchors])
        //        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        arView.isUserInteractionEnabled = false
    }
    
    private func defaultMaterials() -> [SCNMaterial] {
        let groundImage = SCNMaterial()
        groundImage.diffuse.contents = UIColor.darkGray
        groundImage.name = "Ground texture"
        
        let sideMaterial = SCNMaterial()
        sideMaterial.diffuse.contents = UIColor.darkGray
        //TODO: Some kind of bug with the normals for sides where not having them double-sided has them not show up
        sideMaterial.isDoubleSided = true
        sideMaterial.name = "Side"
        
        let bottomMaterial = SCNMaterial()
        bottomMaterial.diffuse.contents = UIColor.black
        bottomMaterial.name = "Bottom"
        
        return [sideMaterial, sideMaterial, sideMaterial, sideMaterial, groundImage, bottomMaterial]
    }
    
    private func applyStyle(_ style: String) {
        guard let terrainNode = terrainNode else {
            return
        }
        
        terrainNode.fetchTerrainAndTexture(minWallHeight: 50.0, enableDynamicShadows: true, textureStyle: style, heightProgress: { progress, total in
        }, heightCompletion: { heightFetchError in
            if let heightFetchError = heightFetchError {
                NSLog("Texture load failed: \(heightFetchError.localizedDescription)")
            } else {
                NSLog("Terrain load complete")
            }
            self.makeMapPoints(to: terrainNode, POIs: POIs, path: path, userCoordinate: self.userCoordinate)
        }, textureProgress: { progress, total in
        }) { image, textureFetchError in
            if let textureFetchError = textureFetchError {
                NSLog("Texture load failed: \(textureFetchError.localizedDescription)")
            }
            if image != nil {
                NSLog("Texture load for \(style) complete")
                terrainNode.geometry?.materials[4].diffuse.contents = image
            }
        }
    }
    
    private func makeMapPoints(to terrainNode: TerrainNode, POIs: [(CLLocationDegrees, CLLocationDegrees)], path: Bool, userCoordinate: CLLocation?){
        self.addUserPath(to: terrainNode, POIs: POIs, path: path)
        self.addUserPosition(to: terrainNode, userCoordinate: userCoordinate)
    }
    
    private func addUserPosition(to terrainNode: TerrainNode, userCoordinate: CLLocation?){
        DispatchQueue.main.async {
            if userCoordinate != nil {
                var userSphere = SCNNode(geometry: SCNSphere(radius: 40.0))
                
                if let myScene = SCNScene(named: "player" + ".scn"){
                    userSphere = myScene.rootNode.childNode(withName: "Root", recursively: true)!
                }else {
                    userSphere.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
                }
                userSphere.position = terrainNode.positionForLocation(userCoordinate!)
                terrainNode.addChildNode(userSphere)
            }
        }
    }
    
    private func addUserPath(to terrainNode: TerrainNode, POIs: [(CLLocationDegrees, CLLocationDegrees)], path: Bool) {
        DispatchQueue.main.async {
            terrainNode.enumerateChildNodes({ node, stop in
                node.removeFromParentNode()
            })
            
            if path, POIs.count > 0 {
                for latlon in POIs {
                    let location: CLLocation = CLLocation(latitude: latlon.0, longitude: latlon.1)
                    let sphere =  SCNNode(geometry: SCNBox(width: 20.0, height: 20.0, length: 20.0, chamferRadius: 0.0))
                    sphere.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                    sphere.position = terrainNode.positionForLocation(location)
                    terrainNode.addChildNode(sphere)
                }
                
                let firstLocation: CLLocation = CLLocation(latitude: POIs.first!.0, longitude: POIs.first!.1)
                let startSphere = SCNNode(geometry: SCNSphere(radius: 60.0))
                startSphere.geometry?.firstMaterial?.diffuse.contents = UIColor.green
                startSphere.position = terrainNode.positionForLocation(firstLocation)
                terrainNode.addChildNode(startSphere)
                
                let lastLocation: CLLocation = CLLocation(latitude: POIs.last!.0, longitude: POIs.last!.1)
                let endSphere = SCNNode(geometry: SCNSphere(radius: 60.0))
                endSphere.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                endSphere.position = terrainNode.positionForLocation(lastLocation)
                terrainNode.addChildNode(endSphere)
            } else {
                for latlon in POIs {
                    let location: CLLocation = CLLocation(latitude: latlon.0, longitude: latlon.1)
                    var modelNode: SCNNode =  SCNNode(geometry: SCNSphere(radius: 30.0))
                    
                    if let myScene = SCNScene(named: "infoPoint" + ".scn") {
                        modelNode = myScene.rootNode.childNode(withName: "Root", recursively: true)!
                    } else {
                        modelNode.geometry?.firstMaterial?.diffuse.contents = UIColor.green
                    }
                    
                    modelNode.position = terrainNode.positionForLocation(location)
                    terrainNode.addChildNode(modelNode)
                }
            }
        }
    }
}
