import Foundation

class DataReader {
    
    public static func getWeather() -> Weather? {
        do {
            guard let jsonData = self.readLocalFile(forName: "Data") else { return nil }
            let decodedData = try JSONDecoder().decode(Weather.self, from: jsonData)
            
            return decodedData
        } catch {
            print("decode error")
        }
        
        return nil
    }
    
    private static func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
