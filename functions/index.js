const functions = require("firebase-functions");
const admin= require("firebase-admin")

var serviceAccount = require("./serviceAccountAdmin.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});


exports.electeursCreated = functions.firestore
.document('electeurs/{docId}')
.onCreate((snap, context) => { 
const mat=snap.data().matricule.toString().split(" ").join("_").replace("/","_")
//const mt=context.params.docId
console.log("************************************");
console.log(mat);
return admin.auth().createUser(
    {
        email:`${mat}@gmail.com`,
        password:'123423'
    })
 });
