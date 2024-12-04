import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, Alert } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { useAuth } from '@/context/AuthContext';
import { apiService } from '@/services/api';
import { User } from '@/types/auth';

export const AdminDashboard = () => {
  const { logout, user } = useAuth();
  const [residents, setResidents] = useState<User[]>([]);
  const [isLoading, setIsLoading] = useState(false);

  useEffect(() => {
    loadResidents();
  }, []);

  const loadResidents = async () => {
    if (!user?.societyCode) return;
    
    try {
      setIsLoading(true);
      const data = await apiService.getSocietyResidents(user.societyCode);
      setResidents(data);
    } catch (error) {
      Alert.alert('Error', 'Failed to load residents');
    } finally {
      setIsLoading(false);
    }
  };

  const handleApproveUser = async (userId: string) => {
    if (!user?.societyCode) return;

    try {
      await apiService.approveUser(user.societyCode, userId);
      await loadResidents(); // Reload the list after approval
      Alert.alert('Success', 'User approved successfully');
    } catch (error) {
      Alert.alert('Error', 'Failed to approve user');
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Admin Dashboard</Text>
        <TouchableOpacity onPress={logout}>
          <Icon name="logout" size={24} color="#333" />
        </TouchableOpacity>
      </View>

      <ScrollView style={styles.content}>
        <View style={styles.welcomeCard}>
          <Text style={styles.welcomeText}>Welcome Society Admin</Text>
          <Text style={styles.adminEmail}>{user?.email}</Text>
          <Text style={styles.societyCode}>Society Code: {user?.societyCode}</Text>
        </View>

        <View style={styles.residentsSection}>
          <Text style={styles.sectionTitle}>Society Residents</Text>
          {isLoading ? (
            <Text style={styles.loadingText}>Loading residents...</Text>
          ) : (
            residents.map((resident) => (
              <View key={resident._id} style={styles.residentCard}>
                <View style={styles.residentInfo}>
                  <Text style={styles.residentName}>{resident.name}</Text>
                  <Text style={styles.residentDetails}>
                    Flat: {resident.flatNo} • {resident.email}
                  </Text>
                  <Text style={[
                    styles.approvalStatus,
                    resident.isApproved ? styles.approved : styles.pending
                  ]}>
                    {resident.isApproved ? 'Approved' : 'Pending Approval'}
                  </Text>
                </View>
                {!resident.isApproved && (
                  <TouchableOpacity 
                    style={styles.approveButton}
                    onPress={() => handleApproveUser(resident._id)}
                  >
                    <Text style={styles.approveButtonText}>Approve</Text>
                  </TouchableOpacity>
                )}
              </View>
            ))
          )}
        </View>
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  headerTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#333',
  },
  content: {
    flex: 1,
    padding: 16,
  },
  welcomeCard: {
    backgroundColor: '#2196F3',
    padding: 20,
    borderRadius: 10,
    marginBottom: 20,
  },
  welcomeText: {
    color: '#fff',
    fontSize: 24,
    fontWeight: 'bold',
  },
  adminEmail: {
    color: '#fff',
    fontSize: 16,
    marginTop: 5,
  },
  societyCode: {
    color: '#fff',
    fontSize: 16,
    marginTop: 5,
  },
  residentsSection: {
    backgroundColor: '#fff',
    padding: 16,
    borderRadius: 10,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 16,
    color: '#333',
  },
  loadingText: {
    textAlign: 'center',
    color: '#666',
    padding: 20,
  },
  residentCard: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  residentInfo: {
    flex: 1,
  },
  residentName: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333',
  },
  residentDetails: {
    fontSize: 14,
    color: '#666',
    marginTop: 4,
  },
  approvalStatus: {
    fontSize: 12,
    marginTop: 4,
  },
  approved: {
    color: '#4CAF50',
  },
  pending: {
    color: '#FFC107',
  },
  approveButton: {
    backgroundColor: '#4CAF50',
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 5,
    marginLeft: 10,
  },
  approveButtonText: {
    color: '#fff',
    fontSize: 14,
    fontWeight: 'bold',
  },
});