import axios from 'axios';
import { API_URL, ENDPOINTS } from '../config/api';
import { AuthResponse, LoginCredentials, RegisterData, Society, User } from '../types/auth';

const api = axios.create({
  baseURL: API_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

class ApiService {
  async login(credentials: LoginCredentials): Promise<AuthResponse> {
    try {
      const { data } = await api.post<AuthResponse>(ENDPOINTS.LOGIN, credentials);
      return data;
    } catch (error) {
      if (axios.isAxiosError(error)) {
        throw new Error(error.response?.data?.error || 'Login failed');
      }
      throw error;
    }
  }

  async register(data: RegisterData): Promise<AuthResponse> {
    try {
      const response = await api.post<AuthResponse>(ENDPOINTS.REGISTER, data);
      return response.data;
    } catch (error) {
      if (axios.isAxiosError(error)) {
        throw new Error(error.response?.data?.error || 'Registration failed');
      }
      throw error;
    }
  }

  async verifySocietyCode(code: string): Promise<void> {
    try {
      await api.get(ENDPOINTS.VERIFY_SOCIETY(code));
    } catch (error) {
      if (axios.isAxiosError(error)) {
        throw new Error('Invalid society code');
      }
      throw error;
    }
  }

  async getSocietyResidents(societyCode: string): Promise<User[]> {
    try {
      const { data } = await api.get(ENDPOINTS.SOCIETY_RESIDENTS(societyCode));
      return data;
    } catch (error) {
      if (axios.isAxiosError(error)) {
        throw new Error(error.response?.data?.error || 'Failed to fetch residents');
      }
      throw error;
    }
  }

  async approveUser(societyCode: string, userId: string): Promise<void> {
    try {
      await api.post(ENDPOINTS.APPROVE_USER(societyCode, userId));
    } catch (error) {
      if (axios.isAxiosError(error)) {
        throw new Error(error.response?.data?.error || 'Failed to approve user');
      }
      throw error;
    }
  }

  setAuthToken(token: string | null) {
    if (token) {
      api.defaults.headers.common['Authorization'] = `Bearer ${token}`;
    } else {
      delete api.defaults.headers.common['Authorization'];
    }
  }
}

export const apiService = new ApiService();