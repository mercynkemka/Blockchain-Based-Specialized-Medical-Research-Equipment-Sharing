# Blockchain-Based Specialized Medical Research Equipment Sharing

This decentralized platform enables research institutions to securely share expensive medical research equipment, maximizing utilization while maintaining transparency and accountability. The system leverages blockchain technology to create a trusted network of verified institutions, streamlined equipment scheduling, and comprehensive usage tracking.

## System Overview

The Blockchain-Based Specialized Medical Research Equipment Sharing platform consists of four primary smart contracts:

1. **Equipment Registration Contract**: Documents specialized research instruments with detailed specifications
2. **Institution Verification Contract**: Validates the credentials of participating research organizations
3. **Scheduling Contract**: Facilitates equipment reservation and sharing across institutions
4. **Usage Tracking Contract**: Records equipment utilization data and research outcomes

## Getting Started

### Prerequisites

- Node.js (v16.0+)
- Ethereum development framework (Truffle/Hardhat)
- Web3 library
- MetaMask or similar wallet

### Installation

1. Clone the repository
   ```
   git clone https://github.com/yourusername/medical-equipment-sharing.git
   cd medical-equipment-sharing
   ```

2. Install dependencies
   ```
   npm install
   ```

3. Compile smart contracts
   ```
   npx hardhat compile
   ```

4. Deploy to test network
   ```
   npx hardhat run scripts/deploy.js --network testnet
   ```

## Smart Contract Architecture

### Equipment Registration Contract
Records comprehensive details about specialized medical research equipment including model, specifications, capabilities, maintenance requirements, and current location. Each piece of equipment receives a unique digital identifier on the blockchain.

### Institution Verification Contract
Establishes a secure system for validating research institutions through credential verification, reputation tracking, and compliance certification. Prevents unauthorized access while building a trusted network of participants.

### Scheduling Contract
Manages the reservation and scheduling of equipment access across multiple institutions. Handles time slots, priorities, conflict resolution, and automated approvals based on predefined criteria.

### Usage Tracking Contract
Documents equipment utilization including duration, purpose, research objectives, and outcomes. Enables performance analysis and supports the calculation of usage-based cost sharing.

## Usage Examples

### Registering Equipment
```javascript
const equipmentRegistry = await EquipmentRegistrationContract.deployed();
await equipmentRegistry.registerEquipment(
  "Advanced Mass Spectrometer XL-5000",
  "High-resolution molecular analysis system",
  "https://ipfs.io/ipfs/QmXoypizjW3WknFiJnKLwHCnL72vedxjQkDDP1mXWo6uco/specs.json",
  "Lab Building 3, Room 405, University Medical Center",
  650000, // value in USD
  "2024-01-15" // last maintenance date
);
```

### Scheduling Equipment Use
```javascript
const scheduler = await SchedulingContract.deployed();
await scheduler.requestReservation(
  "EQUIP-1234", // equipment ID
  "INST-5678", // institution ID
  1714924800, // start timestamp (Unix format)
  1715011200, // end timestamp (Unix format)
  "Protein biomarker identification in lung cancer samples",
  2 // priority level
);
```

## Features

- **Resource Optimization**: Maximizes utilization of expensive equipment across institutions
- **Transparent Verification**: Ensures all participating entities meet quality and security standards
- **Efficient Scheduling**: Streamlines equipment access while preventing conflicts
- **Comprehensive Tracking**: Documents usage patterns, research applications, and outcomes
- **Fair Cost Sharing**: Enables data-driven allocation of operational expenses

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

For questions or support, please contact: support@medicalequipmentsharing.org
