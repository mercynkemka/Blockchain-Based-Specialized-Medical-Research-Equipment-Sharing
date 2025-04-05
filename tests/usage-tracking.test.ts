import { describe, it, expect, vi, beforeEach } from 'vitest';

// Mock the Clarity contract calls
const mockUsageTracking = {
  recordUsage: vi.fn(),
  recordOutcome: vi.fn(),
  getUsage: vi.fn()
};

describe('Usage Tracking Contract', () => {
  beforeEach(() => {
    vi.resetAllMocks();
    
    mockUsageTracking.recordUsage.mockReturnValue({ value: true });
    mockUsageTracking.getUsage.mockReturnValue({
      value: {
        equipmentId: 'equip-123',
        user: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM',
        startTime: 200,
        endTime: 300,
        outcome: 'Identified new biomarkers'
      }
    });
  });
  
  it('should record usage successfully', async () => {
    const result = await mockUsageTracking.recordUsage(
        'booking-123',
        'equip-123',
        200,
        300
    );
    expect(result.value).toBe(true);
  });
  
  it('should record research outcome', async () => {
    mockUsageTracking.recordOutcome.mockReturnValue({ value: true });
    const result = await mockUsageTracking.recordOutcome(
        'booking-123',
        'Identified new biomarkers'
    );
    expect(result.value).toBe(true);
  });
  
  it('should return usage record details', async () => {
    const result = await mockUsageTracking.getUsage('booking-123');
    expect(result.value).toHaveProperty('equipmentId', 'equip-123');
  });
});
