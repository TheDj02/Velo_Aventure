import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projet/UserModels.dart';
import 'package:projet/UserServices.dart';

class Connexion extends StatefulWidget{

  @override
  _ConnexionState createState() => _ConnexionState();

}
class _ConnexionState extends State <Connexion>{
  void _submit(String email, String password, BuildContext ctx) async {
    UserCredential authResult;
    try {
      authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      String msg = "erreur";
      if (e.code == 'user-not-found') {
        msg = 'Aucun utilisateur trouvé pour cet email.';
      } else if (e.code == 'wrong-password') {
        msg = 'Mot de passe erroné fourni pour cet utilisateur.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      print(e);
    }
  }
  bool _sec=true;
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+");
  String _email;
  String _password;
  @override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Vélo Aventure',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.orange,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.orange,
                onPressed: () {}
            )),
        backgroundColor: Colors.white,
        body:
        Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 0.0,),
                Image.asset('images/HomePage.jpg'),
                SizedBox(
                  height: 0.0,),
                SizedBox(
                  height: 20.0,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('E-mail ', style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38
                        )),
                        TextFormField(
                            onChanged: (value) => setState(() => _email = value),
                            validator: (value) => value.isEmpty || !emailRegex.hasMatch(value) ? 'Entrer une adresse mail valide ' : null ,
                            decoration: InputDecoration(
                                hintText: 'Ex:admin@gmail.com',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none
                                )
                            )
                        ),
                        SizedBox(height: 20.0,),
                        Text('Mot de passe', style: TextStyle(
                            fontSize: 20.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38
                        )),
                        TextFormField(
                            onChanged: (value) => setState(() => _password = value),
                            validator: (value) => value.length<6 ? 'Entrer un mot de passe valide. 6 caractére minimum ' : null ,
                            obscureText: _sec,
                            decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: () => setState(() => _sec = !_sec),

                                  child: Icon(!_sec ? Icons.visibility : Icons.visibility_off),
                                ),
                                hintText: '*********',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none
                                )
                            )),
                      ],
                    )
                ),
                SizedBox( height: 40.0,),
                FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 50.0,vertical: 10.0),
                    color: Theme.of(context).primaryColor,

                    onPressed: ()async{
                  if(_formKey.currentState.validate())  {
                    print(_email);
                    print(_password);
                   await _submit(_email, _password, context);
                   Navigator.push(context, MaterialPageRoute(builder: (context) => FirstPage()));
                    }},
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                    child: Text('Connexion', style: TextStyle(
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),
                    )),
                SizedBox(height: 20.0),
                FlatButton(
                  padding: EdgeInsets.symmetric(horizontal: 38.0,vertical: 10.0),
                  color: Theme.of(context).primaryColor,

                  onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Guest()));
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                  child: Text('Créer Compte',
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    ),),
                ),
              ],
            ),
          ),
        )
    );

  }

}
  class Cpt extends StatefulWidget{
    final Function(int,String) onChangedStep;
    Cpt
        ({Key key,this.onChangedStep})
        :super(key: key);

  @override
  _CptState createState() => _CptState();

}
class _CptState extends State <Cpt>{
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(r"[a-z0-9\._-]+@[a-z0-9\._-]+\.[a-z]+");
  String _email2='' ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor:Colors.orange,
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
          ),
          title: Text("Creation d'un compte",
            style: TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),),
          centerTitle: true,
        ),
        body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [

                      RichText(text: TextSpan(
                        text: 'tout le monde a\n'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold
                        ),
                        children: [
                          TextSpan(
                            text:'des_connaissances\n'.toUpperCase(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          TextSpan(
                              text:'à partager'.toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              )),
                        ],
                      )),
                      SizedBox(height: 50.0,),
                      Text('Tout commence içi.',style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.black38,
                          fontSize: 20.0
                      ),),
                      SizedBox(height: 50.0,),
                      Form(child: Column(
                        key: _formKey,
                          crossAxisAlignment:CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 10.0,),
                            Text('Entrer votre E-mail', style: TextStyle(
                                fontSize: 20.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: Colors.black38
                            ),),
                            SizedBox(height: 10.0,),
                            TextFormField(
                                onChanged: (value1) => setState(() => _email2 = value1),


                              decoration: InputDecoration(
                                  hintText: '',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      borderSide: BorderSide(color: Colors.orange)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0.0),
                                      borderSide: BorderSide(color: Colors.orange)
                                  )
                              ),),
                            SizedBox(height: 10.0,),
                            RaisedButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15.0),
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                onPressed:  (){
                                        widget.onChangedStep(1,_email2);
                                 print(_email2);},

                                child: Text('Continuer'.toUpperCase(), style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                                )),
                          ]))
                    ]
                )
            ),
    ));
  }}
class Cpt1 extends StatefulWidget{
  final Function(int,String) onChangedStep;
  Cpt1
      ({Key key,this.onChangedStep})
      :super(key: key);

  @override
  _Cpt1State createState() => _Cpt1State();

}
class _Cpt1State extends State <Cpt1>{
  final GlobalKey<FormState> _formKey= GlobalKey<FormState>();
  String _password2 = '';
  bool _sec=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.orange,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () {
          widget.onChangedStep(0,null);
        },
      ),
      title: Text("Confirmation d'un compte",
        style: TextStyle(
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),),
      centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              Text('Mot de passe'.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontSize: 30.0,
                color:Colors.black38
              ),),
              SizedBox(height: 50.0,),
              Form(
                  key: _formKey,child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Entrez votre mot de passe',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle
                            .normal,
                        fontWeight: FontWeight
                            .bold,
                        color: Colors.black38
                    ),),
                  TextFormField(
                    onChanged: (value) => setState(() => _password2=value),
                    validator: (value) => value.length<6 ? 'Entrer un mot de passe valide. 6 caractére minimum ' : null ,
                    obscureText: _sec,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: () => setState(() => _sec = !_sec),

                          child: Icon(!_sec ? Icons.visibility : Icons.visibility_off),
                        ),
                        hintText: '',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            borderSide: BorderSide(color: Colors.orange)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0),
                            borderSide: BorderSide(color: Colors.orange)
                        )
                    ),),
                  SizedBox(height: 10.0,),
                  RaisedButton(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0),
                      color: Theme
                          .of(context)
                          .primaryColor,
                      onPressed: (){
                            if(_formKey.currentState.validate()) {
                              print(_password2);
                              widget.onChangedStep(2,_password2);}
                      },
                      child: Text('Confirmer'.toUpperCase(), style: TextStyle(
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      )),

                ]
              )
              ),
                ],
              ),)



      ),
    );}}

class Wlcm extends StatefulWidget{
  final Function(int) onChangedStep;
  Wlcm
      ({Key key,this.onChangedStep})
      :super(key: key);
  @override
  _WlcmState createState() => _WlcmState();

}
class _WlcmState extends State <Wlcm>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.orange,
              onPressed: () {

              }
          ),
        ),
        body:
        Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset('images/WlcmPage.jpg'),
                  SizedBox(height: 40.0),
                  Form(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Salut,',
                        style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 35.0
                        ),),
                      SizedBox(height: 20.0,),
                      Text('bienvenue dans notre application.',
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 30.0

                        ),),
                      SizedBox(height: 20.0,),
                      Text('Découvrez une application entièrement repensées afin de vous proposez une meilleure expérience et une utilisation Simple. ',
                        style: TextStyle(
                          color: Colors.black,
                        ),)
                    ],
                  )
                    ,),
                  SizedBox(height: 80.0,),
                  RaisedButton(
                      padding:EdgeInsets.symmetric(horizontal: 20.0),
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => FirstPage()));
                      },
                      child: Text('Commencer', style: TextStyle(
                          fontSize:18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic
                      ),
                      )),
                ],
              ),
            )

        )
    );
  }}



class FirstPage extends StatefulWidget{

  @override
  _FirstPageState createState() => _FirstPageState();

}
class _FirstPageState extends State <FirstPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Type de Vélo', style: TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
        backgroundColor: Colors.orange,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.orange,
            onPressed: () {}
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.account_box,
                color: Colors.white,
                size: 30.0,),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              }
          )
        ],

      ),
      body: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Column(

                children: [
                  SizedBox(height: 20.0),
                  Text('Veillez choisir un des types de vélo présenté :',
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: 20.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold
                    ),),
                  SizedBox(height: 20.0,),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.0,),
                        Image.asset('images/VéloNormal.jpg',
                          height: 150.0, width: 150.0,),
                      ],
                    ),
                  ),
                  SizedBox(height: 0.0,),
                  Container(
                    child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        color: Theme
                            .of(context)
                            .primaryColor,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => VeloNormal()));
                        },
                        child: Text('Classic', style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic
                        ),
                        )
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                    child: Image.asset('images/VéloElectrique.jpg',
                      height: 150.0, width: 180.0,),
                  ),
                  SizedBox(height: 1,),
                  Container(
                    child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        color: Theme
                            .of(context)
                            .primaryColor,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => VeloElectrique()));
                        },
                        child: Text('Electrique', style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic
                        ),
                        )
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Container(
                    child: Image.asset('images/VéloPliant.jpg',
                      height: 150.0, width: 150.0,),
                  ),
                  SizedBox(height: 1.0,),
                  Container(
                    child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        color: Theme
                            .of(context)
                            .primaryColor,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => VeloPliant()));
                        },
                        child: Text('Pliant', style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic
                        ),
                        )
                    ),

                  ),
                  SizedBox(height: 20.0,),
                  Container(
                    child: Image.asset(
                      'images/VéloCourse.jpg', height: 150, width: 150,),
                  ),
                  SizedBox(height: 1.0,),
                  Container(
                    child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        color: Theme
                            .of(context)
                            .primaryColor,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => VeloCourse()));
                        },
                        child: Text('Course', style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic
                        ),
                        )
                    ),

                  )
                ],
              ),
            ),
          )
      ),

    );
  }}

class Profile extends StatefulWidget{
  @override

  _Profile createState() => _Profile();

}
class _Profile extends State <Profile>{
UserService _userService = UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.orange,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }
          ),
        ),
        body:   Center(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                    crossAxisAlignment:CrossAxisAlignment.center,
                    children: [

                      RichText(text: TextSpan(
                        text: 'Une mise à jour\n'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold
                        ),
                        children: [
                          TextSpan(
                            text:'sera faite dans un temps proche\n'.toUpperCase(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          TextSpan(
                              text:'pour vous afficher votre profile'.toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              )),
                        ],
                      )),
                      SizedBox(height: 50.0,),

                      SizedBox(height: 50.0),
                      FlatButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0,horizontal: 35.0),
                          color: Theme
                              .of(context)
                              .primaryColor,
                          onPressed: ()async {
                            await _userService.logout();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Connexion()), (route) => false);
                          },
                          child: Text('Deconnexion'.toUpperCase(), style: TextStyle(
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                          )),
                    ]
                )
            )


        )
    );

  }

}
class VeloNormal extends StatefulWidget{
  @override

  _VeloNormal createState() => _VeloNormal();

}
class _VeloNormal extends State <VeloNormal>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Vélo Classic',style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold
          ),),
          centerTitle: true,
          backgroundColor: Colors.orange,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }
          )

      ),
      body: Column(
        children: [
          SizedBox(height: 40.0),
          Text('Veillez Sélectionner la taille du vélo que vous voulez :',style: TextStyle(
              fontSize: 25.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              color: Colors.black38
          ),),
          SizedBox(height: 200.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille1()));
          }, child: Text('XS',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),
          SizedBox(height: 20.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille2()));
          }, child: Text('S',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),
          SizedBox(height: 20.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille3()));
          }, child: Text('M',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),
          SizedBox(height: 20.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille4()));
          }, child: Text('L',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),
          SizedBox(height: 20.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille5()));
          }, child: Text('XL',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),
        ],
      ),
    );
  }
}

class VeloElectrique extends StatefulWidget{
  @override

  _VeloElectrique createState() => _VeloElectrique();

}
class _VeloElectrique extends State <VeloElectrique>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Vélo Electrique',style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold
          ),),
          centerTitle: true,
          backgroundColor: Colors.orange,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }
          )

      ),
      body: Column(
        children: [
          SizedBox(height: 40.0),
          Text('Veillez Sélectionner la taille du vélo que vous voulez :',style: TextStyle(
              fontSize: 25.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              color: Colors.black38
          ),),
          SizedBox(height: 200.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille1()));
          }, child: Text('XS',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),
          SizedBox(height: 20.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille2()));
          }, child: Text('S',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),
          SizedBox(height: 20.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille3()));
          }, child: Text('M',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),
          SizedBox(height: 20.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille4()));
          }, child: Text('L',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),
          SizedBox(height: 20.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille5()));
          }, child: Text('XL',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),


        ],
      ),
    );
  }
}

class VeloPliant extends StatefulWidget{
  @override

  _VeloPliant createState() => _VeloPliant();

}
class _VeloPliant extends State <VeloPliant>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Vélo Pliant',style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold
          ),),
          centerTitle: true,
          backgroundColor: Colors.orange,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }
          )

      ),
      body: Column(
        children: [
          SizedBox(height: 40.0),
          Text('Veillez Sélectionner la taille du vélo que vous voulez :',style: TextStyle(
              fontSize: 25.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              color: Colors.black38
          ),),
          SizedBox(height: 200.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille1()));
          }, child: Text('XS',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),
          SizedBox(height: 20.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille2()));
          }, child: Text('S',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),
          SizedBox(height: 20.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille3()));
          }, child: Text('M',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),
          SizedBox(height: 20.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille4()));
          }, child: Text('L',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),
          SizedBox(height: 20.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille5()));
          }, child: Text('XL',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),
        ],
      ),
    );
  }
}

class VeloCourse extends StatefulWidget{
  @override

  _VeloCourse createState() => _VeloCourse();

}
class _VeloCourse extends State <VeloCourse>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Vélo Course',style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold
          ),),
          centerTitle: true,
          backgroundColor: Colors.orange,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }
          )

      ),
      body: Column(
        children: [
          SizedBox(height: 40.0),
          Text('Veillez Sélectionner la taille du vélo que vous voulez :',style: TextStyle(
              fontSize: 25.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              color: Colors.black38
          ),),
          SizedBox(height: 200.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille1()));
          }, child: Text('XS',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),
          SizedBox(height: 20.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille2()));
          }, child: Text('S',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),
          SizedBox(height: 20.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille3()));
          }, child: Text('M',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),
          SizedBox(height: 20.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille4()));
          }, child: Text('L',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),
          SizedBox(height: 20.0),
          FlatButton(onPressed: () {
            Navigator.push(context,MaterialPageRoute(builder: (context) => Taille5()));
          }, child: Text('XL',style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20.0,fontStyle: FontStyle.normal
          ),),
            color:  Colors.orange,
          ),
        ],
      ),
    );
  }
}
class Taille1 extends StatefulWidget{
  @override

  _Taille1 createState() => _Taille1();

}
class _Taille1 extends State <Taille1>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Confirmation',
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),),
          centerTitle: true,
          backgroundColor: Colors.orange,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }
          )
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 150.0),
          Text('Vous choisi la taille XS Merci de confirmer votre choix :',style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.black38
          ),),
          SizedBox(height: 150.0),
          RaisedButton(onPressed:(){
            Navigator.push(context,MaterialPageRoute(builder: (context) => FinalPage()));
          } ,
              padding:EdgeInsets.symmetric(horizontal: 30.0),
              color: Theme.of(context).primaryColor,
              child: Text('Confirmer',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)
              )),
        ],
      ),

    );

  }
}

class Taille2 extends StatefulWidget{
  @override

  _Taille2 createState() => _Taille2();

}
class _Taille2 extends State <Taille2>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Confirmation',
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),),
          centerTitle: true,
          backgroundColor: Colors.orange,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }
          )
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 150.0),
          Text('Vous choisi la taille S Merci de confirmer votre choix :',style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.black38
          ),),
          SizedBox(height: 150.0),
          RaisedButton(onPressed:(){
            Navigator.push(context,MaterialPageRoute(builder: (context) => FinalPage()));
          } ,
              padding:EdgeInsets.symmetric(horizontal: 30.0),
              color: Theme.of(context).primaryColor,
              child: Text('Confirmer',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)
              )),
        ],
      ),

    );

  }
}
class Taille3 extends StatefulWidget{
  @override

  _Taille3 createState() => _Taille3();

}
class _Taille3 extends State <Taille3>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Confirmation',
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),),
          centerTitle: true,
          backgroundColor: Colors.orange,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }
          )
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 150.0),
          Text('Vous choisi la taille M Merci de confirmer votre choix :',style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.black38
          ),),
          SizedBox(height: 150.0),
          RaisedButton(onPressed:(){
            Navigator.push(context,MaterialPageRoute(builder: (context) => FinalPage()));
          } ,
              padding:EdgeInsets.symmetric(horizontal: 30.0),
              color: Theme.of(context).primaryColor,
              child: Text('Confirmer',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)
              )),
        ],
      ),

    );

  }
}
class Taille4 extends StatefulWidget{
  @override

  _Taille4 createState() => _Taille4();

}
class _Taille4 extends State <Taille4>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Confirmation',
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),),
          centerTitle: true,
          backgroundColor: Colors.orange,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }
          )
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 150.0),
          Text('Vous choisi la taille L Merci de confirmer votre choix :',style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.black38
          ),),
          SizedBox(height: 150.0),
          RaisedButton(onPressed:(){
            Navigator.push(context,MaterialPageRoute(builder: (context) => FinalPage()));
          } ,
              padding:EdgeInsets.symmetric(horizontal: 30.0),
              color: Theme.of(context).primaryColor,
              child: Text('Confirmer',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)
              )),
        ],
      ),

    );

  }
}
class Taille5 extends StatefulWidget{
  @override

  _Taille5 createState() => _Taille5();

}
class _Taille5 extends State <Taille5>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Confirmation',
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),),
          centerTitle: true,
          backgroundColor: Colors.orange,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }
          )
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 150.0),
          Text('Vous choisi la taille XL Merci de confirmer votre choix :',style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.black38
          ),),
          SizedBox(height: 150.0),
          RaisedButton(onPressed:(){
            Navigator.push(context,MaterialPageRoute(builder: (context) => FinalPage()));
          } ,
              padding:EdgeInsets.symmetric(horizontal: 30.0),
              color: Theme.of(context).primaryColor,
              child: Text('Confirmer',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)
              )),
        ],
      ),

    );

  }
}
class FinalPage extends StatefulWidget{
  @override
  _FinalPage createState() => _FinalPage();

}
class _FinalPage extends State <FinalPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }
          ),
        ),
        body: Container(
          child: Center(
              child: Column(
                children: [
                  SizedBox(height: 250.0,),
                  Text('Merci de votre confiance Notre livreur vous appelera le plutôt possible portez vous bien',

                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.orange,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold
                    ),),
                  SizedBox(height: 20.0,),
                  Icon(Icons.emoji_emotions_outlined,
                    color: Colors.orange,
                    size: 50.0
                    ,)
                ],
              )
          ),
        )


    );
  }
}
class Guest extends StatefulWidget{
  @override
  _GuestState createState() => _GuestState();

}
class _GuestState extends State <Guest>{
  UserService _userService = UserService();
  List<Widget> _Widgets = [];
  int _indexSelected = 0;
String _email3;
String _Password3;
  @override
  void initState() {
    super.initState();
    _Widgets.addAll([
      Cpt(onChangedStep: (index,value) => setState((){
          _indexSelected = index;
          _email3 = value;
          }),),
      Cpt1(onChangedStep: (index, value) => setState((){
        if(index != null){
          _indexSelected = index;
        }
        if(value != null){
          _userService.auth(UserModel(
              email4: _email3,
            password4: value,
          )).then((value) => print(value.toJson()));

        }

      })),
      Wlcm(),

    ]);
    
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      child: _Widgets.elementAt(_indexSelected),
    );


  }}
