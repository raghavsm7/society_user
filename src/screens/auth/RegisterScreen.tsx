import React, { useState } from 'react';
import { View, Text, StyleSheet, TextInput, TouchableOpacity, Alert, ScrollView } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { AuthScreenProps } from '@/types/navigation';
import { useAuth } from '@/context/AuthContext';
import { apiService } from '@/services/api';
import * as Yup from 'yup';

const validationSchema = Yup.object().shape({
  name: Yup.string().required('Name is required'),
  email: Yup.string().email('Invalid email').required('Email is required'),
  password: Yup.string().min(6, 'Password must be at least 6 characters').required('Password is required'),
  societyCode: Yup.string().required('Society code is required'),
  flatNo: Yup.string().required('Flat number is required'),
});

export const RegisterScreen: React.FC<AuthScreenProps<'Register'>> = ({ navigation }) => {
  const { register, isLoading } = useAuth();
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    password: '',
    societyCode: '',
    flatNo: '',
  });
  const [errors, setErrors] = useState<Record<string, string>>({});

  const handleRegister = async () => {
    try {
      await validationSchema.validate(formData, { abortEarly: false });
      
      // Verify society code exists
      try {
        await apiService.verifySocietyCode(formData.societyCode);
      } catch (error) {
        setErrors(prev => ({
          ...prev,
          societyCode: 'Invalid society code'
        }));
        return;
      }

      await register({
        ...formData,
        role: 'resident',
      });
      
      // After successful registration, user will be automatically redirected to UserDashboard
      // through the AppNavigator's auth state check
    } catch (error: unknown) {
      if (error instanceof Yup.ValidationError) {
        const newErrors: Record<string, string> = {};
        error.inner.forEach((err) => {
          if (err.path) {
            newErrors[err.path] = err.message;
          }
        });
        setErrors(newErrors);
      } else if (error instanceof Error) {
        Alert.alert('Error', error.message);
      } else {
        Alert.alert('Error', 'An unexpected error occurred');
      }
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView style={styles.scrollView}>
        <View style={styles.content}>
          <Text style={styles.title}>REGISTER</Text>
          <Text style={styles.subtitle}>Hello users, please create your account</Text>

          <View style={styles.inputContainer}>
            <View style={styles.inputWrapper}>
              <Icon name="person" size={24} color="#666" style={styles.icon} />
              <TextInput
                style={styles.input}
                placeholder="Full Name"
                value={formData.name}
                onChangeText={(text) => {
                  setFormData(prev => ({ ...prev, name: text }));
                  setErrors(prev => ({ ...prev, name: '' }));
                }}
              />
            </View>
            {errors.name && <Text style={styles.errorText}>{errors.name}</Text>}

            <View style={styles.inputWrapper}>
              <Icon name="email" size={24} color="#666" style={styles.icon} />
              <TextInput
                style={styles.input}
                placeholder="Email Address"
                value={formData.email}
                onChangeText={(text) => {
                  setFormData(prev => ({ ...prev, email: text }));
                  setErrors(prev => ({ ...prev, email: '' }));
                }}
                keyboardType="email-address"
                autoCapitalize="none"
              />
            </View>
            {errors.email && <Text style={styles.errorText}>{errors.email}</Text>}

            <View style={styles.inputWrapper}>
              <Icon name="lock" size={24} color="#666" style={styles.icon} />
              <TextInput
                style={styles.input}
                placeholder="Password"
                value={formData.password}
                onChangeText={(text) => {
                  setFormData(prev => ({ ...prev, password: text }));
                  setErrors(prev => ({ ...prev, password: '' }));
                }}
                secureTextEntry
              />
            </View>
            {errors.password && <Text style={styles.errorText}>{errors.password}</Text>}

            <View style={styles.inputWrapper}>
              <Icon name="apartment" size={24} color="#666" style={styles.icon} />
              <TextInput
                style={styles.input}
                placeholder="Society Code"
                value={formData.societyCode}
                onChangeText={(text) => {
                  setFormData(prev => ({ ...prev, societyCode: text.toUpperCase() }));
                  setErrors(prev => ({ ...prev, societyCode: '' }));
                }}
                autoCapitalize="characters"
              />
            </View>
            {errors.societyCode && <Text style={styles.errorText}>{errors.societyCode}</Text>}

            <View style={styles.inputWrapper}>
              <Icon name="home" size={24} color="#666" style={styles.icon} />
              <TextInput
                style={styles.input}
                placeholder="Flat Number"
                value={formData.flatNo}
                onChangeText={(text) => {
                  setFormData(prev => ({ ...prev, flatNo: text }));
                  setErrors(prev => ({ ...prev, flatNo: '' }));
                }}
              />
            </View>
            {errors.flatNo && <Text style={styles.errorText}>{errors.flatNo}</Text>}
          </View>

          <TouchableOpacity 
            style={[styles.registerButton, isLoading && styles.disabledButton]} 
            onPress={handleRegister}
            disabled={isLoading}
          >
            <Text style={styles.registerButtonText}>
              {isLoading ? 'Registering...' : 'Register'}
            </Text>
          </TouchableOpacity>

          <TouchableOpacity 
            style={styles.loginLink}
            onPress={() => navigation.navigate('Login')}
          >
            <Text style={styles.loginText}>
              Already have an account? <Text style={styles.loginTextBold}>Login</Text>
            </Text>
          </TouchableOpacity>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
  scrollView: {
    flex: 1,
  },
  content: {
    padding: 20,
    paddingBottom: 40,
  },
  title: {
    fontSize: 32,
    fontWeight: 'bold',
    marginBottom: 10,
    textAlign: 'center',
  },
  subtitle: {
    fontSize: 16,
    color: '#666',
    marginBottom: 30,
    textAlign: 'center',
  },
  inputContainer: {
    gap: 20,
    marginBottom: 30,
  },
  inputWrapper: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#f5f5f5',
    borderRadius: 10,
    paddingHorizontal: 15,
  },
  icon: {
    marginRight: 10,
  },
  input: {
    flex: 1,
    padding: 15,
    fontSize: 16,
  },
  registerButton: {
    backgroundColor: '#2196F3',
    padding: 15,
    borderRadius: 10,
    alignItems: 'center',
    marginBottom: 20,
  },
  disabledButton: {
    backgroundColor: '#cccccc',
  },
  registerButtonText: {
    color: '#fff',
    fontSize: 18,
    fontWeight: 'bold',
  },
  errorText: {
    color: 'red',
    fontSize: 12,
    marginTop: -15,
    marginLeft: 5,
  },
  loginLink: {
    alignItems: 'center',
  },
  loginText: {
    fontSize: 16,
    color: '#666',
  },
  loginTextBold: {
    color: '#2196F3',
    fontWeight: 'bold',
  },
});