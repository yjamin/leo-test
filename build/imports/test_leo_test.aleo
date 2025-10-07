import leo_test.aleo;
program test_leo_test.aleo;

function test_sync:
    call leo_test.aleo/sync_program_address into r0;
    assert.eq r0 aleo14e57yulw852a35ht8afk44jdw7hx8lmq69gag4u0mwakl7uvdy9sw487qs;

constructor:
    assert.eq edition 0u16;
