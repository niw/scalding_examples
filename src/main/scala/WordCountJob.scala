import com.twitter.scalding._

class WordCountJob(args: Args) extends Job(args) {
  TextLine(args("in"))
      .flatMap('line -> 'word) { tokenize }
      .groupBy('word) { _.size }
      .write(Tsv(args("out")))

  def tokenize(text: String) =
    text.toLowerCase.replaceAll("[^a-zA-Z0-9\\s]", "").split("\\s+")
}