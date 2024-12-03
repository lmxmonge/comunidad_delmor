// Please see this file for the latest firebase-js-sdk version:
// https://github.com/firebase/flutterfire/blob/master/packages/firebase_core/firebase_core_web/lib/src/firebase_sdk_version.dart
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyDeQn5RaKMK6T8MYRTsAnEAiEMGXh2gBVk",
  authDomain: "comunidad-delmor.firebaseapp.com",
  projectId: "comunidad-delmor",
  storageBucket: "comunidad-delmor.firebasestorage.app",
  messagingSenderId: "705808373390",
  appId: "1:705808373390:web:9f7e98cf376f7b8bbb5bdf",
  measurementId: "G-NPK8VQLVB5"
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);

});
