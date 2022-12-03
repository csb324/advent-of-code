import AdventSolver from './AdventSolver';

const solver = new AdventSolver('day2');
const games = solver.getLines();

// PART ONE

// A: rock
// B: paper
// C: scissors
// X: rock
// Y: paper
// Z: scissors

// in part two, x = lose, y = draw, z = win? 

function partOne() {
  type PlayerMove = 'X' | 'Y' | 'Z';
  type ElfMove = 'A' | 'B' | 'C';
  
  const gameRules: Record<ElfMove, Record<PlayerMove, number>> = {
    'A': {
      'X': 3,
      'Y': 6,
      'Z': 0
    },
    'B': {
      'Y': 3,
      'Z': 6,
      'X': 0
    },
    'C': {
      'X': 6,
      'Y': 0,
      'Z': 3
    }
  }
  
  const baseScore: Record<PlayerMove, number> = {
    'X': 1,
    'Y': 2,
    'Z': 3
  }
  
  let part1Total = 0;
  function scoreGame(game: string): number {
    const theirMove: ElfMove = game[0] as ElfMove;
    const yourMove: PlayerMove = game[2] as PlayerMove;
  
    const score = gameRules[theirMove][yourMove] + baseScore[yourMove];
    part1Total += score;
    return score;
  }
  
  games.forEach((game) => scoreGame(game));
  console.log(part1Total);
}


// a = rock, b = paper, c = scissors
// in part two, x = lose, y = draw, z = win? 
function partTwo() {
  type EndState = 'X' | 'Y' | 'Z';
  type ElfMove = 'A' | 'B' | 'C';
  
  const gameRules: Record<ElfMove, Record<EndState, number>> = {
    'A': {
      'X': 3,
      'Y': 1,
      'Z': 2
    },
    'B': {
      'X': 1,
      'Y': 2,
      'Z': 3
    },
    'C': {
      'X': 2,
      'Y': 3,
      'Z': 1
    }
  }
  
  const baseScore: Record<EndState, number> = {
    'X': 0,
    'Y': 3,
    'Z': 6
  }
  
  let part2Total = 0;
  function scoreGame(game: string): number {
    const theirMove: ElfMove = game[0] as ElfMove;
    const endState: EndState = game[2] as EndState;
 
    const whatYouMustDo = gameRules[theirMove][endState];
    const score = whatYouMustDo + baseScore[endState];
    part2Total += score;
    return score;
  }
  
  games.forEach((game) => scoreGame(game));
  console.log(part2Total);
}

partTwo();