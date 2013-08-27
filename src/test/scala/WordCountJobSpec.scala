import org.specs2.mutable.SpecificationWithJUnit
import com.twitter.scalding._

class WordCountJobSpec extends SpecificationWithJUnit with FieldConversions with TupleConversions {
  def testJob = JobTest[WordCountJob]
      .arg("in", "input")
      .arg("out", "output")

  // TextLine fields is ('offset, 'line), add line number to lines.
  def textLines(lines: String*): Seq[(String, String)] =
    for((line, index) <- lines.zipWithIndex) yield index.toString -> line

  "WordCountJob" should {
    testJob
        .source(TextLine("input"), textLines(
          "nyan nyan meow purr meow",
          "meow meow nyan purr"
        ))
        .sink[(String, Int)](Tsv("output")) { output =>
      "counts words" in {
        output.toSet mustEqual Set(
          "purr" -> 2,
          "nyan" -> 3,
          "meow" -> 4
        )
      }
    }.run.finish
  }
}