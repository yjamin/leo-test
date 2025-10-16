/// It is very important for the Hyperlane Protocol to calculate Message IDs they are part of the commitment that validators sign.
/// This means that the Message ID can't be computed off-chain and taken as a trusted input. The ID must be calculated on-chain because of that.
/// Only ingoing messages can be of a dynamic length (`process` method), outgoing messages are static and the ID is easy to calculate.
program mailbox.aleo {
    struct StaticMessage {
        nonce: u32,
        // .. every other property
        body: [u128; 16],
    }

    // These are the "dynamic" message sizes to calculate message ids
    struct Message16Bytes {
        nonce: u32,
        // .. every other property
        body: u128
    }

    struct Message32Bytes {
        nonce: u32,
        // .. every other property
        body: [u128; 2]
    }

    // ...
    // continue all the way up to 128Bytes


    // Mapping to see whether or not a message has already been processed
    mapping processed: MessageId => bool;

    /// - body_length: is the byte length of the message.
    async transition process(public message: StaticMessage, body_length: u32) -> Future {
        // Calculate the message id dynamically
        // Initially we went with just raw bytes and copied the raw bytes into the desired length
        // After some testing, we switched to static sized structes as it seemed to be less heavy on compute
        // See this code for the raw byte example: https://github.com/hyperlane-xyz/hyperlane-aleo/blob/b26a4b23e13a8ab3883e357245d3ef1c59a1d210/mailbox/src/main.leo#L224

        assert(body_length % 16 == 0);
        assert(body_length > 0 && body_length <= 128);
        let id = MesasgeId { id: [0u128; 2] };
        // We can't use a for loop as the structs that we copy into are different
        if body_length == 16 {
            let dynamic_message = Message16Bytes {
                nonce: message.nonce,
                body: message.body[0],
            };
            let id = keccak_raw(dynamic_message);
        } else if body_length == 32 {
            let dynamic_message = Message32Bytes {
                nonce: message.nonce,
                body: [message.body[0], message.body[1]],
            };
            let id = keccak_raw(dynamic_message);
        } 
        // .. continue all the way up to 128 Bytes
        return finalize_process(current_state, message);
    }

    async function finalize_process(message_id: MessageId, message: StaticMessage) {
        processed.set(message_id, true);
    }
}
