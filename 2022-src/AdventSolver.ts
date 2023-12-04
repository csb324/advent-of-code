import * as fs from 'fs';

class AdventSolver {
  
  title: string;

  constructor(title: string) {
    this.title = title;
  }

  getFile(): string {
    return fs.readFileSync('./2022-input/'+ this.title +'-input.txt').toString();
  }

  getLines(): string[] {
    return this.getFile().split("\n");
  }

  showAnswer(answer: string | number): void {
    console.log(answer);
  }
}

export default AdventSolver;