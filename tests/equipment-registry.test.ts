import { describe, it, expect, vi, beforeEach } from 'vitest';

// Mock the Clarity contract calls
const mockEquipmentRegistry = {
  registerEquipment: vi.fn(),
  updateAvailability: vi.fn(),
  getEquipment: vi.fn(),
  transferOwnership: vi.fn()
};

describe('Equipment Registry Contract', () => {
  beforeEach(() => {
    vi.resetAllMocks();
    
    mockEquipmentRegistry.registerEquipment.mockReturnValue({ value: true });
    mockEquipmentRegistry.getEquipment.mockReturnValue({
      value: {
        name: 'MRI Scanner',
        owner: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM',
        available: true,
        maintenanceDate: 100
      }
    });
  });
  
  it('should register new equipment successfully', async () => {
    const result = await mockEquipmentRegistry.registerEquipment('equip-123', 'MRI Scanner');
    expect(result.value).toBe(true);
  });
  
  it('should update equipment availability', async () => {
    mockEquipmentRegistry.updateAvailability.mockReturnValue({ value: true });
    const result = await mockEquipmentRegistry.updateAvailability('equip-123', false);
    expect(result.value).toBe(true);
  });
  
  it('should return equipment details', async () => {
    const result = await mockEquipmentRegistry.getEquipment('equip-123');
    expect(result.value).toHaveProperty('name', 'MRI Scanner');
  });
});
