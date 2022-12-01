import AdventSolver from './AdventSolver';

const solver = new AdventSolver();

const fs = require('fs');
function sum(arrayOfNumbers) {
  return arrayOfNumbers.reduce((prev, current) => prev + current);
}
function getInput() {
  return fs.readFileSync('./day1-input.txt').toString();
}
const eachElf = getInput().split("\n\n");
const elfValues = eachElf.map((elf) => {
  return elf.split("\n").map((e)=> parseInt(e)).reduce((prev, current) => prev + current);
})
elfValues.sort((a, b) => b - a);


solver.solve(sum(elfValues.slice(0, 3)));
