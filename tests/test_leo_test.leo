// The 'test_leo_test' test program.
import leo_test.aleo;
program test_leo_test.aleo {

    @noupgrade
    async constructor() {}

    @test
    script test_async() {
        let future: Future = leo_test.aleo/async_program_address();
        future.await();
    }

    @test
    // Why do we have to do this for tests?
    transition test_sync() {
        let result = leo_test.aleo/sync_program_address();
        assert_eq(result, aleo14e57yulw852a35ht8afk44jdw7hx8lmq69gag4u0mwakl7uvdy9sw487qs);
    }
}
