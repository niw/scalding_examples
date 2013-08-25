import com.twitter.scalding._

class EchoJob(args: Args) extends Job(args) {
  Tsv(args("in"), ('key, 'value))
      .write(Tsv(args("out")))
}