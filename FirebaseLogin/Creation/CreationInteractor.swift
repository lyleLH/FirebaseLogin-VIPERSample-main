//
//  CreationInteractor.swift
//
//
//  Created by Tom.Liu on .
//
//

import Foundation

protocol CreationInteractorProtocol {
    func getAllSections() -> [WorkoutSection]
    func fetchSectionsData()-> [WorkoutSection]
    func getSelectedActions() -> [WorkoutAction]
    func addOrRemoveAnAction(action: WorkoutAction, group: WorkoutGroup) -> [WorkoutAction]
    func isActionSelected(action: WorkoutAction) -> Bool
    func haveSelection() -> Bool
}

class CreationInteractor: CreationInteractorProtocol {
    
    func getAllSections() -> [WorkoutSection] {
         return allSections
    }
    
    
    private var allSections: [WorkoutSection] = []
    private var selectSections: [WorkoutAction] = []
    
    weak var presenter: CreationPresenterProtocol?
    
    func fetchSectionsData() -> [WorkoutSection] {
        // Mock data
        let dumbbellActions = [WorkoutAction(name: "Dumbbell Bench Press", equipmentType: "Dumbbell"),
                               WorkoutAction(name: "Dumbbell Fly", equipmentType: "Dumbbell"),
                               WorkoutAction(name: "Dumbbell Bench Press", equipmentType: "Dumbbell"),
                               WorkoutAction(name: "Dumbbell Fly", equipmentType: "Dumbbell"),
                               WorkoutAction(name: "Dumbbell Bench Press", equipmentType: "Dumbbell"),
                               WorkoutAction(name: "Dumbbell Fly", equipmentType: "Dumbbell"),
                               WorkoutAction(name: "Dumbbell Bench Press", equipmentType: "Dumbbell"),
                               WorkoutAction(name: "Dumbbell Fly", equipmentType: "Dumbbell")]
        
        let barbellActions = [WorkoutAction(name: "Barbell Squat", equipmentType: "Barbell"),
                              WorkoutAction(name: "Barbell Deadlift", equipmentType: "Barbell")]
        
        let cableActions = [WorkoutAction(name: "Cable Crossover", equipmentType: "Cable"),
                            WorkoutAction(name: "Cable Row", equipmentType: "Cable")]
        
        let machineActions = [WorkoutAction(name: "Leg Press", equipmentType: "Machine"),
                              WorkoutAction(name: "Chest Press", equipmentType: "Machine")]
        
        let chestGroup = [WorkoutGroup(equipmentType: "Dumbbell", actions: dumbbellActions),
                          WorkoutGroup(equipmentType: "Barbell", actions: barbellActions)]
        
        let backGroup = [WorkoutGroup(equipmentType: "Cable", actions: cableActions),
                         WorkoutGroup(equipmentType: "Machine", actions: machineActions)]
        
        let sections = [WorkoutSection(title: "Chest", groups: chestGroup),
                        WorkoutSection(title: "Back", groups: backGroup),
                        WorkoutSection(title: "Chest", groups: chestGroup),
                        WorkoutSection(title: "Chest", groups: chestGroup),
        ]
        allSections = sections
        return sections
    }
    
    func addOrRemoveAnAction(action: WorkoutAction, group: WorkoutGroup) -> [WorkoutAction] {
        if selectSections.isEmpty == false, selectSections.contains(where: { tAction in
            action.name == tAction.name
        }) == true {
            selectSections = selectSections.filter({ tAction in
                action.name != tAction.name
            })
        } else {
            selectSections.append(action)
        }
        return selectSections
    }
    
    
    func isActionSelected(action: WorkoutAction) -> Bool {
        if selectSections.contains(where: { tAction in
            action.name == tAction.name
        })  { return true }
        return false
    }
    
    func haveSelection() -> Bool {
        return selectSections.isEmpty == false
    }
    
    func getSelectedActions() -> [WorkoutAction] {
        return selectSections
    }
}
