import { StackScreenProps } from '@react-navigation/stack';

export type RootStackParamList = {
  Login: undefined;
  Register: undefined;
  AdminDashboard: undefined;
  UserDashboard: undefined;
};

export type AuthScreenProps<T extends keyof RootStackParamList> = StackScreenProps<RootStackParamList, T>;