import com.twitter.scalding._
import org.apache.hadoop.conf.Configuration
import org.apache.hadoop.util.GenericOptionsParser

object Main {
  // Usually we're using com.twitter.scalding.Tool to run Scalding Job class.
  // This Main class works as standalone and runs a single Scalding Job.
  def main(args: Array[String]) {
    val conf = new Configuration

    // Gives next options to use local Hadoop pseudo clustor.
    //   -Dfs.default.name=hdfs://localhost:8020
    //   -Dmapred.job.tracker=localhost:8021
    val parser = new GenericOptionsParser(conf, args)
    val jobArgs = Args(parser.getRemainingArgs)

    // val mode = Hdfs(true, conf)
    val mode = Local(true)

    val jobArgsWithMode = Mode.putMode(mode, jobArgs)

    // Define and create a job then run it.
    val job = new Job(jobArgsWithMode) {
      Tsv(args("in"), ('key, 'value))
          .write(Tsv(args("out")))
    }
    job.run
  }
}