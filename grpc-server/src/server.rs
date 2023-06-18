use std::{collections::HashMap, sync::{Arc, Mutex}, borrow::BorrowMut};

use protobuf::helloworld::{message_storage_server::{MessageStorage, MessageStorageServer}, Empty, Message, DeleteRequest, GetsResponse, GetsRequest, StoreRequest};
use tonic::{Response, Request, Status, transport::Server};

mod protobuf;

#[derive(Debug, Default)]
pub struct MyGreeter {
    sharedMap: Arc<Mutex<HashMap<Vec<u8>, Vec<u8>>>>,

}


#[tonic::async_trait]
impl MessageStorage for MyGreeter {
    async fn store(
        &self,
        request: Request<StoreRequest>
    ) -> Result<Response<Empty>, Status> {
        println!("Got a request: {:?}", request);
        let reply = Empty {  };
        let request_body = request.into_inner();
        let mut db = self.sharedMap.lock().unwrap();

        db.insert(request_body.destination_public_key, request_body.message);
        Ok(Response::new(reply))
    }
    async fn delete(   &self,
        request: Request<DeleteRequest>) -> Result<Response<Empty>, Status> {
            let reply: Empty = Empty {  };

            Ok(Response::new(reply))
    }
    async fn gets(   &self,
        request: Request<GetsRequest>) -> Result<Response<GetsResponse>, Status> {
            let mut db = self.sharedMap.lock().unwrap();
            let publick_key = &request.into_inner().public_key;
            let result = db.get(publick_key);
                 let empty: GetsResponse = GetsResponse { messages: vec![] };

                match result {
                    None => Ok(Response::new(empty)),
                    Some(val) => {
                        let reply = GetsResponse {messages: vec![Message {message: val.to_vec()}]};
                        db.remove(publick_key);
                        Ok(Response::new(reply))
                    },
                }
                
    }
    
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let addr = "[::1]:50051".parse()?;
    let greeter = MyGreeter{sharedMap: Arc::new(Mutex::new(HashMap::new()))};

    Server::builder()
        .add_service(MessageStorageServer::new(greeter))
        .serve(addr)
        .await?;

    Ok(())
}