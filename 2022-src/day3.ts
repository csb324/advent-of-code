import AdventSolver from './AdventSolver';

const solver = new AdventSolver('day3');
const lines: string[] = solver.getLines();

let total = 0;

function getPriority(character: string): number {
  let value: number = 0;

  if(character.toUpperCase() === character) {
    value += 26
  }
  value += character.toLowerCase().charCodeAt(0) - 96
  return value;
}

function parseRucksack(line: string) {
  const first: string[] = line.slice(0, line.length/2).split('');
  const second: string[] = line.slice(line.length/2).split('');
  const overlap = first.filter((el) => {
    return second.includes(el);
  });
  const value = getPriority(overlap[0]);
  total += value;
  console.log(overlap[0], value);
}

// part one
lines.forEach((line:string) => {
  parseRucksack(line);
})
console.log(total);

// part two
function getElfGroups(strings: string[]): string[][][] {
  const perChunk = 3 // items per chunk    

  const result = strings.reduce((resultArray, item, index) => { 
    const chunkIndex = Math.floor(index/perChunk)
    if(!resultArray[chunkIndex]) {
      resultArray[chunkIndex] = [] // start a new chunk
    }
    resultArray[chunkIndex].push(item.split(''))
    return resultArray
  }, [])
  return result;
}

const elfGroups = getElfGroups(lines);

let partTwoTotal:number = 0;

elfGroups.forEach((elfGroup) => {  
  const overlap = elfGroup[0].filter((element) => {
    return elfGroup[1].includes(element) && elfGroup[2].includes(element)
  })
  partTwoTotal += getPriority(overlap[0]);
})

console.log(partTwoTotal)