importScripts('https://www.gstatic.com/firebasejs/8.4.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.0/firebase-messaging.js');
firebase.initializeApp({
  apiKey: "AIzaSyCm8agS4fK_yPGGVsGAuohxjMZCpSnBTOs",
  authDomain: "esports-mini.firebaseapp.com",
  databaseURL: "https://esports-mini.firebaseio.com",
  projectId: "esports-mini",
  storageBucket: "esports-mini.appspot.com",
  messagingSenderId: "881527222867",
  appId: "1:881527222867:web:bade3c851f83866ab40ca6",
  measurementId: "G-CB3EDVN8SG"
});

const messaging = firebase.messaging();