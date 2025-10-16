// The 'test_loop_generation' test program.
import loop_generation.aleo;
program test_loop_generation.aleo {
    @test
    script test_it() {
        let result: u32 = loop_generation.aleo/main(1u32, 2u32);
        assert_eq(result, 3u32);
    }

    @test
    @should_fail
    transition do_nothing() {
        let result: u32 = loop_generation.aleo/main(2u32, 3u32);
        assert_eq(result, 3u32);
    }

    @noupgrade
    async constructor() {}
}
