import SwiftUI

/// Displays a list of pages
struct PageListView: View {
    let pages: [Page] // Replace with your actual page model
    let onPageSelected: (Page) -> Void
    let onDeletePage: (Page) -> Void
    
    var body: some View {
        List {
            ForEach(pages) { page in
                HStack {
                    Text(page.title) // Replace with your actual page title property
                        .font(.headline)
                    Spacer()
                    Button(action: { onDeletePage(page) }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    onPageSelected(page)
                }
            }
        }
        .navigationTitle("Pages")
    }
}

/// Mock model for `Page`
struct Page: Identifiable {
    let id = UUID()
    let title: String
}

struct PageListView_Previews: PreviewProvider {
    static var previews: some View {
        PageListView(
            pages: [Page(title: "Page 1"), Page(title: "Page 2")],
            onPageSelected: { _ in },
            onDeletePage: { _ in }
        )
    }
}
