import axios from "axios";

const apiUrl = window.RUNTIME_CONFIG?.VITE_APP_URL || "http://localhost:5001";

export const axiosInstance = axios.create({
  baseURL: `${apiUrl}/api`,
  withCredentials: true,
});
