import AdventSolver from './AdventSolver';

const solver = new AdventSolver('day1');

function sum(arrayOfNumbers) {
  return arrayOfNumbers.reduce((prev, current) => prev + current);
}

const eachElf = solver.getFile().split("\n\n");
const elfValues = eachElf.map((elf) => {
  return elf.split("\n").map((e)=> parseInt(e)).reduce((prev, current) => prev + current);
})
elfValues.sort((a, b) => b - a);

solver.showAnswer(sum(elfValues.slice(0, 3)));
