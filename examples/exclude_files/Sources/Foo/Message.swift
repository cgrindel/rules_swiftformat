public struct Message {
  public var value: String
  var pfmt: PoorlyFormatted

  public init(value: String = "") {
    self.value = value
    pfmt = PoorlyFormatted()
    pfmt.name = value
  }
}
