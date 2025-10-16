program mailbox.aleo {
    struct MyState {
        nonce: u32
    }

    struct Message {
        nonce: u32,
        body: [u8; 32],
        // .. every other property
    }

    mapping state: bool => MyState;

    // In a perfect world we would be able to either call other programs inside of functions 
    // Or somehow query the state in transitions
    async transition dispatch(public current_state: MyState) -> Future {
        // Calculate message for other program
        // Message relies on the current state
        let message = Message {
            nonce: current_state.nonce,
            body: [0u8; 32],
        };
        return finalize_dispatch(current_state, message);
    }

    async function finalize_dispatch(current_state: MyState, message: Message) {
        assert_eq(state.get(true), current_state);

        // Do some state changes 
        state.nonce += 1;
        // ..

        state.set(current_state);
    }
}

/// Our hooks right now have to be a different program as the implementation is close to the size limit (79k KB)
/// Please look at following code examples to see why the program size is this big.
/// - InsertIntoTree: https://github.com/hyperlane-xyz/hyperlane-aleo/blob/main/hook_manager/src/main.leo#L308-L327
/// - MerkleRoot: https://github.com/hyperlane-xyz/hyperlane-aleo/blob/main/hook_manager/src/main.leo#L329-L347
program hook.aleo {
    
    struct Tree {
        branch: [[u128; 2]; 32],
        count: u32,
    }

    struct Event {
        root: [u128; 2],
        index: u32
    }

    mapping state: bool => Tree;
    mapping events: u32 => Event;


    async transition post_dispatch(public message: Message) -> Future {
       return finalize_post_dispatch(message);
    }

    async function finalize_post_dispatch(message: Message) {
        let current_state = state.get(true);
        // Get message id of the given message
        // ID is the Keccak of the entire message
        let message_id = get_message_id(message);

        // Insert the message id into the tree
        let tree = insert_into_tree(tree, message);
        let root = merkle_root(tree);
        let index = tree.count - 1;
        
        // Emit events based on the calculation
        events.set(index, Event { root, index });
        // Update the state
        state.set(true, tree);
    }
}