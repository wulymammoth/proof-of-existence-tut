// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract ProofOfExistence3 {
  // state
  mapping(bytes32 => bool) private proofs;

  // store POE in contract state
  function store(bytes32 proof) internal {
    proofs[proof] = true;
  }

  // calculate and store the proof for a doc
  function notarize(string calldata document) external {
    bytes32 proof = proofFor(document);
    store(proof);
  }

  // helper to get a document's SHA256
  function proofFor(string memory document)
    pure
    public
    returns (bytes32)
  {
    return keccak256(bytes(document));
  }

  function checkDocument(string memory document)
    public
    view
    returns (bool)
  {
    bytes32 proof = proofFor(document);
    return hasProof(proof);
  }

  function hasProof(bytes32 proof)
    internal
    view
    returns (bool)
  {
    return proofs[proof];
  }
}
