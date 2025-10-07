program leo_test.aleo;

function async_program_address:
    async async_program_address leo_test.aleo into r0;
    output r0 as leo_test.aleo/async_program_address.future;

finalize async_program_address:
    input r0 as address.public;
    assert.eq true true;

function sync_program_address:
    output leo_test.aleo as address.private;

constructor:
    assert.eq edition 0u16;
