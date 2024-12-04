import React from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import Icon from 'react-native-vector-icons/MaterialIcons';
import { useAuth } from '@/context/AuthContext';

export const UserDashboard = () => {
  const { logout, user } = useAuth();

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Society Home</Text>
        <TouchableOpacity onPress={logout}>
          <Icon name="logout" size={24} color="#333" />
        </TouchableOpacity>
      </View>

      <ScrollView style={styles.content}>
        <View style={styles.welcomeCard}>
          <Text style={styles.welcomeText}>Welcome to Your Society</Text>
          <Text style={styles.userName}>{user?.name}</Text>
          <Text style={styles.userDetails}>Flat: {user?.flatNo}</Text>
          {!user?.isApproved && (
            <View style={styles.pendingApprovalBanner}>
              <Icon name="info" size={24} color="#fff" />
              <Text style={styles.pendingApprovalText}>
                Your account is pending approval from society admin
              </Text>
            </View>
          )}
        </View>

        {user?.isApproved ? (
          <View style={styles.quickActions}>
            <TouchableOpacity style={styles.actionCard}>
              <Icon name="people" size={32} color="#2196F3" />
              <Text style={styles.actionText}>Members</Text>
            </TouchableOpacity>

            <TouchableOpacity style={styles.actionCard}>
              <Icon name="event" size={32} color="#2196F3" />
              <Text style={styles.actionText}>Events</Text>
            </TouchableOpacity>

            <TouchableOpacity style={styles.actionCard}>
              <Icon name="announcement" size={32} color="#2196F3" />
              <Text style={styles.actionText}>Notices</Text>
            </TouchableOpacity>
          </View>
        ) : (
          <View style={styles.pendingContent}>
            <Text style={styles.pendingMessage}>
              You'll get access to all features once your account is approved
            </Text>
          </View>
        )}
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
  userName: {
    color: '#fff',
    fontSize: 18,
    marginTop: 5,
  },
  userDetails: {
    color: '#fff',
    fontSize: 16,
    marginTop: 5,
  },
  pendingApprovalBanner: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: 'rgba(0,0,0,0.2)',
    padding: 10,
    borderRadius: 8,
    marginTop: 10,
  },
  pendingApprovalText: {
    color: '#fff',
    marginLeft: 10,
    flex: 1,
  },
  quickActions: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    flexWrap: 'wrap',
    gap: 16,
  },
  actionCard: {
    backgroundColor: '#fff',
    padding: 16,
    borderRadius: 10,
    alignItems: 'center',
    width: '30%',
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 3.84,
    elevation: 5,
  },
  actionText: {
    marginTop: 8,
    color: '#333',
    fontSize: 12,
    textAlign: 'center',
  },
  pendingContent: {
    backgroundColor: '#fff',
    padding: 20,
    borderRadius: 10,
    alignItems: 'center',
  },
  pendingMessage: {
    textAlign: 'center',
    color: '#666',
    fontSize: 16,
  },
});