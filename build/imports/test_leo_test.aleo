import leo_test.aleo;
program test_leo_test.aleo;

function test:
    call leo_test.aleo/main 2u32 3u32 into r0;
    cast 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 0u8 into r1 as [u8; 34u32];
    assert.eq r0 r1;

constructor:
    assert.eq edition 0u16;
