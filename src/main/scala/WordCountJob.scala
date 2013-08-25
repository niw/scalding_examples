import com.twitter.scalding._

class WordCountJob(args: Args) extends Job(args) {
  TextLine(args("in"))
      .flatMap('line -> 'word) { line: String => tokenize(line) }
      .groupBy('word) { _.size }
      .write(Tsv(args("out")))

  def tokenize(text: String): Array[String] =
    text.toLowerCase.replaceAll("[^a-zA-Z0-9\\s]", "").split("\\s+")
}