//
//  ProspectsView.swift
//  HotProspects—Challenge
//
//  Created by Ciaran Murphy on 3/21/24.
//

import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Prospect.name) var prospects: [Prospect]
    //@State private var prospectsQuery: Query<Prospect, [Prospect]>?

    //@Query(sort: sortOrder) var prospects: [Prospect]
    //@Query(sortDescriptors: sortOrder) var prospects: [Prospect]

    @State private var isShowingScanner = false
    @State private var selectedProspects = Set<Prospect>()
    
    @State private var sortOrder = [
        \Prospect.name,
        \Prospect.emailAddress
    ]
    
    let filter: FilterType
    
    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted"
        case .uncontacted:
            "Uncontacted"
        }
    }
    
    var body: some View {
        //NavigationStack{
            //Text("People: \(prospects.count)")
            List(prospects, selection: $selectedProspects){ prospect in
                
                /*if filter == .none {
                 Image(systemName: "person")
                 }*/
                NavigationLink{
                    EditingView(prospect: prospect)
                } label: {
                    HStack{
                        if filter == .none {
                            Image(systemName: prospect.isContacted ? "checkmark" : "xmark")
                                .padding()
                        }
                        VStack(alignment: .leading){
                            
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundStyle(.secondary)
                            Text("\(prospect.dateAdded)")
                        }
                    }
                    .swipeActions{
                        Button("Delete", systemImage: "trash", role: .destructive){
                            modelContext.delete(prospect)
                        }
                        
                        if prospect.isContacted {
                            Button("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark"){
                                prospect.isContacted.toggle()
                            }
                            .tint(.blue)
                        } else {
                            Button("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark"){
                                prospect.isContacted.toggle()
                            }
                            .tint(.green)
                            
                            Button("Remind me", systemImage: "bell"){
                                addNotification(for: prospect)
                            }
                            .tint(.orange)
                        }
                    }
                    .tag(prospect)
                }
            }
        
                .navigationTitle(title)
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Scan", systemImage: "qrcode.viewfinder"){
                            /*let prospect = Prospect(name: "Ciarán Murphy", emailAddress: "Test@Test.Test", isContacted: false)
                            modelContext.insert(prospect)*/
                            isShowingScanner = true
                        }
                    }
                    
                    /*ToolbarItem{
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Button("Sort by name") {
                                        sortOrder = [
                                            \Prospect.name,
                                            \Prospect.emailAddress
                                        ]
                                    }
                                    Button("Sort by email") {
                                        sortOrder = [
                                            \Prospect.emailAddress,
                                            \Prospect.name
                                        ]
                                    }
                            /*
                            Picker("Sort", selection: $sortOrder){
                                Text("Sort by name")
                                    .tag([
                                        SortDescriptor(\Prospect.name),
                                        SortDescriptor(\Prospect.emailAddress),
                                    ])
                                Text("Sort by email")
                                    .tag([
                                        SortDescriptor(\Prospect.emailAddress),
                                        SortDescriptor(\Prospect.name)
                                    ])
                            }*/
                        }
                        
                    }*/

                    
                    
                    ToolbarItem(placement: .topBarLeading){
                        EditButton()
                    }
                    
                    if selectedProspects.isEmpty == false {
                        ToolbarItem(placement: .bottomBar){
                            Button("Delete Selected", action: delete)
                        }
                    }
                    
                }
                .sheet(isPresented: $isShowingScanner){
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Biarán Murphy\nciaranenator@gmail.com", completion: handleScan)
                }

        //}
    }
    
    
    init(filter: FilterType, sort: SortDescriptor<Prospect>) {
        self.filter = filter
        
        if filter != .none {
            let showContactedOnly = filter == .contacted
            
            _prospects = Query(filter: #Predicate{
                $0.isContacted == showContactedOnly
            }, sort: [sort]/*[SortDescriptor(\Prospect.name)]*/)
        }
    }
    
    func delete() {
        for prospect in selectedProspects {
            modelContext.delete(prospect)
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>){
        isShowingScanner = false
        
        switch result {
        case.success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect(name: details[0], emailAddress: details[1], isContacted: false)
            modelContext.insert(person)
            
        case.failure(let error):
            print("Scanning Failed: \(error.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect){
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
//            var dateComponents = DateComponents()
//            dateComponents.hour = 9
//
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

#Preview {
    ProspectsView(filter: .none, sort: SortDescriptor(\Prospect.name))
        .modelContainer(for: Prospect.self)
}
