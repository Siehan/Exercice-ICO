const { expect } = require('chai');

describe('SmyTokenICO', async function () {
  let SmyTokenICO, smytokenico, SmyToken, smytoken, dev, owner;

  const RATE = 100 * 10 ** 18; // is the number of tokens that will be sold per 1 Ether (1 Ethereum)
  /*
  const TOKEN_RESERVE = 1000000 * 10 ** 18; // is the number of tokens that you want to keep for yourself or company.
  const ICO_OPENING_TIME;
  const ICO_CLOSING_TIME;
  */
  const INITIAL_SUPPLY = ethers.utils.parseEther('1000000');

  beforeEach(async function () {
    [dev, owner, smytokenico] = await ethers.getSigners();
    SmyToken = await ethers.getContractFactory('SmyToken');
    smytoken = await SmyToken.connect(dev).deploy(owner.address, INITIAL_SUPPLY);
    await smytoken.deployed();

    SmyTokenICO = await ethers.getContractFactory('SmyTokenICO');
    smytokenico = await SmyTokenICO.connect(owner).deploy(smytoken.address, RATE);
    await smytokenico.deployed();
    await smytoken.connect(owner).approve(smytokenico, INITIAL_SUPPLY);
  });

  describe('Deployment', function () {
    it('Should set the right owner', async function () {
      expect(await smytokenico.owner()).to.equal(owner.address);
    });
  });
});
