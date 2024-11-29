importScripts("https://www.gstatic.com/firebasejs/9.23.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.23.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: 'AIzaSyDGgDmipEcAsgKEfz67cAjcm8dFZ_PHe30',
  appId: '1:806838503582:web:ca67e555a3af97733ed38f',
  messagingSenderId: '806838503582',
  projectId: 'my-gate-user',
  authDomain: 'my-gate-user.firebaseapp.com',
  storageBucket: 'my-gate-user.appspot.com',
  measurementId: 'G-QSCH67LTTR',
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage(function(payload) {
  console.log('Received background message:', payload);

  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/icons/Icon-192.png'
  };

  return self.registration.showNotification(notificationTitle, notificationOptions);
});