const { expect } = require('chai');

describe('SmyToken Token', async function () {
  let SmyToken, smytoken, owner, dev;

  const INITIAL_SUPPLY = ethers.utils.parseEther('1000000');

  beforeEach(async function () {
    [dev, owner] = await ethers.getSigners();
    SmyToken = await ethers.getContractFactory('SmyToken');
    smytoken = await SmyToken.connect(owner).deploy(1000000);
  });

  describe('Deployment', function () {
    it('Should set the right owner', async function () {
      expect(await smytoken.owner()).to.equal(owner.address);
    });

    it('Should have name SmyToken', async function () {
      expect(await smytoken.name()).to.equal('SmyToken');
    });

    it('Should have name SMY', async function () {
      expect(await smytoken.symbol()).to.equal('SMY');
    });

    it(`Should have total supply ${INITIAL_SUPPLY.toString()}`, async function () {
      expect(await smytoken.totalSupply()).to.equal(INITIAL_SUPPLY);
    });

    it(`Should mint total supply ${INITIAL_SUPPLY.toString()} to owner`, async function () {
      expect(await smytoken.balanceOf(owner.address)).to.equal(INITIAL_SUPPLY);
    });
  });
});
