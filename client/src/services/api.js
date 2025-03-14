import axios from 'axios';

const API_URL = 'http://localhost:5001/api';

// Tạo instance axios với cấu hình mặc định
const api = axios.create({
  baseURL: API_URL,
  headers: {
    'Content-Type': 'application/json',
  },
  timeout: 10000
});

// API cho Nhà sản xuất
export const nsxAPI = {
  getAll: () => api.get('/nsx'),
  getById: (id) => api.get(`/nsx/${id}`),
  create: (data) => api.post('/nsx', data),
  update: (id, data) => api.put(`/nsx/${id}`, data),
  delete: (id) => api.delete(`/nsx/${id}`),
};

// API cho PC
export const pcAPI = {
  getAll: () => api.get('/pc'),
  getById: (id) => api.get(`/pc/${id}`),
  create: (data) => api.post('/pc', data),
  update: (id, data) => api.put(`/pc/${id}`, data),
  delete: (id) => api.delete(`/pc/${id}`),
};

// API cho Laptop
export const laptopAPI = {
  getAll: () => api.get('/laptop'),
  getById: (id) => api.get(`/laptop/${id}`),
  create: (data) => api.post('/laptop', data),
  update: (id, data) => api.put(`/laptop/${id}`, data),
  delete: (id) => api.delete(`/laptop/${id}`),
};

// API cho Dashboard
export const dashboardAPI = {
  getStats: () => api.get('/dashboard/stats'),
  getStatsByManufacturer: () => api.get('/dashboard/stats/manufacturer'),
};

export default api; 