import gleam/io
import lustre/element.{text}
import lustre/element/html.{button, div, p}
import lustre/event.{on_click}
import lustre/ssg

type Msg {
  Incr
  Decr
}

fn view() {
  div([], [
    button([on_click(Incr)], [text(" + ")]),
    p([], [text("hi!")]),
    button([on_click(Decr)], [text(" - ")]),
  ])
}

pub fn main() {
  let build =
    ssg.new("./static")
    |> ssg.add_static_route("/", view())
    |> ssg.build

  case build {
    Ok(_) -> io.println("Build succeeded!")
    Error(e) -> {
      io.debug(e)
      io.println("Build failed!")
    }
  }
}
