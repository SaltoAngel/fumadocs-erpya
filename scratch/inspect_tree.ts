import { source } from '../lib/source';

const tree = source.getPageTree();
console.log(JSON.stringify(tree, (key, value) => {
  if (key === 'children' && Array.isArray(value) && value.length > 5) return [`${value.length} children...`];
  return value;
}, 2));

const pages = source.getPages();
console.log("Example page data keys:", Object.keys(pages[0].data));
