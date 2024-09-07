
import 'package:mysql1/mysql1.dart';

class ConnectionDB {


 Future<MySqlConnection> getCon() async {
      final Cons =
      ConnectionSettings(
        host: '127.0.0.1',
        port: 3306,
        user: 'root',
        password: '',
        db: 'database_caffe',
        timeout:Duration(seconds: 30),

      )

      


      ;
    return await MySqlConnection.connect(Cons);
    }


}