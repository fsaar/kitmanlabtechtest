import Foundation

protocol ImageCacheable {
    func imageForURL(_ url: NSURL) async -> Data?
}

actor ImageCache : ObservableObject,ImageCacheable {
    private let cache = NSCache<NSURL, NSData>()
    
    func imageForURL(_ url: NSURL) async -> Data? {
        if let data = cache.object(forKey: url as NSURL)  {
            return data as Data
        }
        let imageData = await Task {
            let data = try? Data(contentsOf: url as URL)
            return data
        }.value
        if let imageData {
            cache.setObject(imageData as NSData, forKey: url)
        }
        return imageData
    }
}
