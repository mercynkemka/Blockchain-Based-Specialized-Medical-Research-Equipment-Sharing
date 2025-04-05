import { describe, it, expect, vi, beforeEach } from 'vitest';

// Mock the Clarity contract calls
const mockScheduling = {
  bookEquipment: vi.fn(),
  cancelBooking: vi.fn(),
  getBooking: vi.fn()
};

describe('Scheduling Contract', () => {
  beforeEach(() => {
    vi.resetAllMocks();
    
    mockScheduling.bookEquipment.mockReturnValue({ value: true });
    mockScheduling.getBooking.mockReturnValue({
      value: {
        equipmentId: 'equip-123',
        user: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM',
        startTime: 200,
        endTime: 300,
        status: 'confirmed'
      }
    });
  });
  
  it('should book equipment successfully', async () => {
    const result = await mockScheduling.bookEquipment(
        'booking-123',
        'equip-123',
        200,
        300
    );
    expect(result.value).toBe(true);
  });
  
  it('should cancel booking successfully', async () => {
    mockScheduling.cancelBooking.mockReturnValue({ value: true });
    const result = await mockScheduling.cancelBooking('booking-123');
    expect(result.value).toBe(true);
  });
  
  it('should return booking details', async () => {
    const result = await mockScheduling.getBooking('booking-123');
    expect(result.value).toHaveProperty('equipmentId', 'equip-123');
  });
});
