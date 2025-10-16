// The 'loop_generation' program.
program loop_generation.aleo {

    @noupgrade
    async constructor() {}

    transition get_message_id(message_raw: [u8; 256], message_length: u32) -> [u128; 2] {
        assert(message_length >= 77);
        let id = [0u128; 2];
        for resolution in 0u8..8u8 {
            const length: u32 = 77u32 + resolution as u32 * 16u32;
            if message_length == length {
                let message = [0u8; length];
                for i in 0u32..length {
                    message[i] = message_raw[i];
                }
                let hash = Keccak256::hash_native_raw(message);
                id = Deserialize::from_bits_raw::[[u128; 2]](hash);
            }
        }

        return id;
    }
}
