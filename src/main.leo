// The 'leo_test' program.
program leo_test.aleo {
    // This is the constructor for the program.
    // The constructor allows you to manage program upgrades.
    // It is called when the program is deployed or upgraded.
    // It is currently configured to **prevent** upgrades.
    // Other configurations include:
    //  - @admin(address="aleo1...")
    //  - @checksum(mapping="credits.aleo/fixme", key="0field")
    //  - @custom
    // For more information, please refer to the documentation: `https://docs.leo-lang.org/guides/upgradability`
    @noupgrade
    async constructor() {}

    async transition async_program_address() -> Future {
        // This will throw an error: unkown member of self 
        return finalize_main(self.address);
    }

    async function finalize_main(program_addess: address) {}


    transition sync_program_address() -> address {
        // This works
        return self.address;
    }
}
