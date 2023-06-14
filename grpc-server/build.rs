fn main() -> Result<(), Box<dyn std::error::Error>> {
    tonic_build::configure()
        .build_server(true)
        .out_dir("src/protobuf")  // you can change the generated code's location
        .compile(
            &["../protos/message_storage.proto"],
            &["../protos/"], // specify the root location to search proto dependencies
        ).unwrap();
    println!("ciao");
    Ok(())
}