import SwiftUI

/// Displays details of a single page
struct PageDetailView: View {
    let page: Page // Replace with your actual page model
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(page.title)
                .font(.largeTitle)
                .padding(.bottom)
            
            Text("Page Details Here") // Replace with actual details
                .font(.body)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Page Details")
    }
}

struct PageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PageDetailView(page: Page(title: "Sample Page"))
    }
}
