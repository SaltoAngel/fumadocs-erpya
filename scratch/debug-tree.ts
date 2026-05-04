import { source } from '../lib/source';

async function test() {
    const tree = source.getPageTree();
    console.log(JSON.stringify(tree, null, 2));
}

test();
