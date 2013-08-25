import org.specs2.mutable.SpecificationWithJUnit
import com.twitter.scalding._

class EchoJobSpec extends SpecificationWithJUnit with FieldConversions with TupleConversions {
  def testJob = JobTest[EchoJob]
      .arg("in", "input")
      .arg("out", "output")

  "EchoJob" should {
    testJob
        .source(Tsv("input", ('key, 'value)), Seq("a" -> "1", "b" -> "2"))
        .sink[(String, String)](Tsv("output")) { output =>
      "write input" in {
        output.toSeq mustEqual Seq("a" -> "1", "b" -> "2")
      }
    }.run.finish
  }
}
