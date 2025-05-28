import SwiftUI


struct AthleteView: View {
    let athlete: Athlete
    @EnvironmentObject var cache: ImageCache
    @State var profileImage = Image("placeholder")
    let squads: [Squad]
    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
                ProfileView(athlete: athlete)
                    .font(.title)
                    .fontWeight(.bold)
                HStack {
                    Text("UserName")
                }
                .font(.title)
                .fontWeight(.bold)
                .padding(.top,8)
                HStack {
                    Text(athlete.username)
                }
                
                HStack {
                    Text("Squads")
                }
                .font(.title)
                .fontWeight(.bold)
                .padding(.top,8)
                
                if !squads.isEmpty {
                    ScrollView {
                        VStack {
                            ForEach(squads) { squad in
                                HStack {
                                    Text(squad.name)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal,4)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            
        }
        
    }
}


#Preview {
    let squadData = Bundle.main.jsonData(for: "squads")!
    let squads = try! JSONDecoder().decode([Squad].self, from: squadData)
    let data = Bundle.main.jsonData(for: "athletes")!
    let athletes = try! JSONDecoder().decode([Athlete].self, from: data)
    AthleteView(athlete: athletes.first!, squads: squads).environmentObject(ImageCache())
}


