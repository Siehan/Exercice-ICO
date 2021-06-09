/*
const { expect } = require('chai');

describe('Calculator contract', function () {
  let Calculator, calculator
  const amount = ether('1');

  beforeEach(async function () {
    Calculator = await ethers.getContractFactory('Calculator');
    calculator = await Calculator.deploy();
    await calculator.deployed();
  });

  it('calc functions should return the good restult', async function () {
    expect(add(1, 2), 'add(1, 2) failed').to.equal(3);
    expect(sub(2, 4), 'sub(2, 4) failed').to.equal(-2);
  });

  it('Should return the addition of 2 numbers', async function () {
    expect(await calculator.add(1, 2)).to.equal(3);
  });

  it('Should return the multiplication of 2 numbers', async function () {
    expect(await calculator.mul(1, 2)).to.equal(2);
  });

  it('Should return the division of 2 numbers', async function () {
    expect(await calculator.div(10, 2)).to.equal(5);
  });

  it('Should return an error if Calculator try to divide the digit 0', async function () {
    await expect(calculator.div(2, 0)).to.be.revertedWith('Calculator can not divide digit 0');
  });

  it('Should return the subtraction of 2 numbers', async function () {
    expect(await calculator.sub(5, 1)).to.equal(4);
  });

  it('Should return the modulo of 2 numbers', async function () {
    expect(await calculator.modulo(2, 2)).to.equal(0);
  });
});
*/
