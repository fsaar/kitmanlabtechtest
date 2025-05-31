import SwiftUI

struct ProfileView: View {
    let athlete: Athlete
    @EnvironmentObject var cache: ImageCache
    @State var profileImage = Image("placeholder")
    var body: some View {
        HStack(alignment: .top) {
            profileImage
                .resizable()
                .frame(width:80,height: 80)
                .clipShape(Circle())
            VStack(alignment:.leading) {
                HStack {
                    Text(athlete.lastName)
                    Text(athlete.firstName)
                }
            }
        }
        .task {
            if let imageURL = athlete.imageURL {
                let data = await cache.imageForURL(imageURL as NSURL)
                if let data,let image = UIImage(data: data) {
                    Task { @MainActor in
                        profileImage = Image(uiImage: image)
                    }
                   
                }
            }
            
        }
    }
}


#Preview {
    let data = Bundle.main.jsonData(for: "athletes")!
    let athletes = try! JSONDecoder().decode([Athlete].self, from: data)
    ProfileView(athlete: athletes.first!).environmentObject(ImageCache())
}
