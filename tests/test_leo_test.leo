// The 'test_leo_test' test program.
import leo_test.aleo;
program test_leo_test.aleo {

    @test
    transition test() {
        let result: [u8; 34] = leo_test.aleo/main(2u32, 3u32);
        assert_eq(result, [0u8; 34]);
    }

    @noupgrade
    async constructor() {}
}
