import com.twitter.scalding._

class Job(args: Args) extends com.twitter.scalding.Job(args) {
  // Use a jar file contains job classes as job.jar

  // NOTE Without cascading.app.appjar.class (or cascading.app.appjar.path,)
  // Cascading will try find the jar file contains main() method currently using,
  // and most of case, it's com.twitter.scalding.Tool which may be in libjars
  // instead of jars contains job classes.
  // See HadoopPlanner#initialize(), AppProps and HadoopUtil.

  override def config(implicit mode: Mode): Map[AnyRef,AnyRef] =
    super.config ++ Map("cascading.app.appjar.class" -> this.getClass)
}
