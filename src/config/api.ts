export const API_URL = 'http://192.168.29.173:3000/api';

export const ENDPOINTS = {
  LOGIN: '/login',
  REGISTER: '/register',
  SOCIETIES: '/societies',
  SOCIETY_RESIDENTS: (code: string) => `/societies/${code}/residents`,
  APPROVE_USER: (code: string, userId: string) => `/societies/${code}/users/${userId}/approve`,
  VERIFY_SOCIETY: (code: string) => `/societies/${code}`
};