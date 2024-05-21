//Daniella Marie Costales 
//https://drive.google.com/file/d/1ilqxXrNGiFfntV2Z9p0i-RM-2zWiZ_rG/view
// FirebaseAuthAPI class: This class encapsulates Firebase authentication functionality. It provides methods for signing in, signing up, signing out, and getting the current user.
// auth static field: This field holds an instance of FirebaseAuth, which is the entry point for all Firebase authentication operations.
// getUser() method: returns the currently signed-in user, or null if no user is signed in.
// userSignedIn() method: returns a stream that emits the current user whenever their sign-in state changes. This is useful for listening to authentication state changes in real-time.
// signIn() method: attempts to sign in the user with the provided email and password. It returns a future that completes with an empty string if the sign-in is successful. If there's an error during sign-in, it catches FirebaseAuthException and handles specific error cases like invalid email, invalid credentials, or other errors.
// signUp() method: attempts to create a new user account with the provided email and password. It uses createUserWithEmailAndPassword method of FirebaseAuth. It handles errors such as email already in use and catches generic exceptions. If the sign-up is successful, it prints the UserCredential object returned by signInWithEmailAndPassword.
// signOut() method:  signs out the currently signed-in user by calling the signOut() method of FirebaseAuth.

//added users collection and its api
//added getUID


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthAPI {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  User? getUser() {
    return auth.currentUser;
  }

  Stream<User?> userSignedIn() {
    return auth.authStateChanges();
  }
  

  Future<String?> signIn(String email, String password) async {
    try {
      // Attempt to sign in the user
      await auth.signInWithEmailAndPassword(email: email, password: password);

      // Get the currently signed-in user's ID
      String userId = auth.currentUser!.uid;

      // Check Firestore collections where the user belongs to. 
      bool isOrg = await FirebaseFirestore.instance
          .collection('user_orgs')
          .doc(userId)
          .get()
          .then((doc) => doc.exists);

      bool isDonor = await FirebaseFirestore.instance
          .collection('user_donors')
          .doc(userId)
          .get()
          .then((doc) => doc.exists);

      // Determine the user type and return the appropriate string
      if (isOrg) {
        return "Org";
      } else if (isDonor) {
        return "Donor";
      } return "";

    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication errors
      if (e.code == 'invalid-email') {
        return e.message;
      } else if (e.code == 'invalid-credential') {
        return e.message;
      } else {
        return "Failed at ${e.code}: ${e.message}";
      }
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<String?> signUp(bool donor, String email, String password, Map<String, dynamic> userMap) async {
    //identify if the sign up is as org or as donor
    UserCredential credential;
    try {
      credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String newUserId = credential.user!.uid;
      if (donor) {
        addUser("user_donor", userMap, newUserId); //adds user to the database
      } else {
        addUser("user_org", userMap, newUserId);
      }
      return("User signed up successfully: ${credential.user!.uid}");
      // return credential.user!.uid; // Return the user UID
      // print(credential);
    } on FirebaseAuthException catch (e) {
      //possible to return something more useful
      //than just print an error message to improve UI/UX
      if (e.code == 'email-already-in-use') {
        return('The account already exists for that email.');
      }return null;
    } catch (e) {
      return("$e");
    }
  }

  Future<String?> addUser(String collection, Map<String, dynamic> userData, String uid) async {
      try {
        await db.collection(collection).doc(uid).set(userData); // Use user UID as document ID
        return "User data added successfully!";
      } on FirebaseException catch (e) {
        return "Error adding user data: ${e.message}";
      }
  }

Stream<Map<String, String>> getUserInfo() {
  String? uid = auth.currentUser?.uid;
  return db
      .collection("users")
      .doc(uid)
      .snapshots()
      .map((snapshot) {
        if (snapshot.exists) {
          var userData = snapshot.data()!;
          return {
            'first_name': userData['first_name'] ?? '',
            'last_name': userData['last_name'] ?? '',
            'email': userData['email'] ?? '',
          };
        } else {
          return {
            'first_name': '',
            'last_name': '',
            'email': '',
          };
        }
      });
  }


}//end of class declaration
