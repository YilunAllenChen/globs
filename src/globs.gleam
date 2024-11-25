import gleam/erlang/process
import mist
import wisp
import wisp/wisp_mist


pub fn handle_request(req: wisp.Request) -> wisp.Response {
  use <- wisp.serve_static(req, under: "static", from: "static")
  todo
  // wisp.html_response(string_tree.from_string(html), 200)
}

pub fn main() {
  wisp.configure_logger()

  // Start the Mist web server.
  let assert Ok(_) =
    wisp_mist.handler(handle_request, "...")
    |> mist.new
    |> mist.port(8000)
    |> mist.start_http

  // The web server runs in new Erlang process, so put this one to sleep while
  // it works concurrently.
  process.sleep_forever()
}
