import com.twitter.scalding.{HadoopMode, Args}

class Job(args: Args) extends com.twitter.scalding.Job(args) {
  // Workaround for Hadoop mode.
  // See https://github.com/themodernlife/scalding-kryo-bug
  // and https://groups.google.com/d/msg/cascading-user/45h5g8Cf9fY/jxZbvOlU--kJ
  override def config: Map[AnyRef, AnyRef] = {
    super.config ++ (mode match {
      case _: HadoopMode => Map("cascading.app.appjar.class" -> this.getClass)
      case _ => Map()
    })
  }
}
