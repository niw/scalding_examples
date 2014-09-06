import com.twitter.scalding._

class TypedWordCountJob(args: Args) extends Job(args) {
  import TDsl._

  TypedPipe.from(TextLine(args("in")))
      .flatMap(tokenize)
      .map(_ -> 1)
      .sumByKey
      .write(TypedTsv(args("out")))

  def tokenize(text: String) =
    text.toLowerCase.replaceAll("[^a-zA-Z0-9\\s]", "").split("\\s+")
}
