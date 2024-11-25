import gleam/erlang/process
import mist
import wisp
import wisp/wisp_mist

import gleam/string_tree

/// The HTTP request handler- your application!
/// 
const html = "<!DOCTYPE html>
<html lang=\"en\">
  <head>
    <meta charset=\"utf-8\">
    <title>Wisp Example</title>
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
    <link rel=\"stylesheet\" href=\"/static/styles.css\">
  </head>
  <body>
    <script src=\"/static/main.js\"></script>
  </body>
</html>
"

pub fn handle_request(_req: wisp.Request) -> wisp.Response {
  wisp.html_response(string_tree.from_string(html), 200)
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
