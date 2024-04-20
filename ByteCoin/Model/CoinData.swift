import Foundation

struct CoinData: Decodable {
  let asset_id_base: String
  let asset_id_quote: String
  let rate: Double
}
