open Type

let _ =
  let usage () =
    Printf.printf "usage: %s [-c cmd | file | - ]\n" Sys.executable_name
  in
    match Sys.argv with
      | [| _; "-h" |]
      | [| _; "--help" |] ->
          usage ()
      | [| _; "-c" ; sexp |] ->
          Repl.repl {
            stdin;
            stdout;
            lexbuf = Some (Lexing.from_string sexp);
            interactive = false;
            print_result = false;
            print_exn = true;
          }
      | [| _; "-" |] ->
          Repl.repl {
            stdin;
            stdout;
            lexbuf = None;
            interactive = false;
            print_result = false;
            print_exn = true;
          }
      | [| _; filename |] ->
          Repl.repl {
            stdin = open_in filename;
            stdout;
            lexbuf = None;
            interactive = false;
            print_result = false;
            print_exn = true;
          }
      | [| _ |] ->
          Repl.repl {
            stdin;
            stdout;
            lexbuf = None;
            interactive = true;
            print_result = true;
            print_exn = true;
          }
      | _ -> usage ()
;;
