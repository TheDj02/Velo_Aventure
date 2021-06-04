import 'package:firebase_auth/firebase_auth.dart';
import 'package:projet/UserModels.dart';

class UserService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<UserModel> auth(UserModel userModel) async {
    UserCredential userCredential;
    print(userModel.toJson());
    try{
      userCredential = await _auth.signInWithEmailAndPassword(email: userModel.email4,
        password: userModel.password4,
      );
    } catch(e){
     userCredential =  await _auth.createUserWithEmailAndPassword(
        email: userModel.email4,
        password: userModel.password4,
      );
    }
     userModel.setUid = userCredential.user.uid;
    return userModel;
   }

  Future<void> logout() async{
    await _auth.signOut();
  }


  }



