import 'package:flutter/material.dart';
import 'package:flutter_statemanagement_using_provider/pages/new_customer.dart';
import 'package:flutter_statemanagement_using_provider/providers/customers.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
   home: ChangeNotifierProvider<CustomerList>(
        
        builder: (_) => CustomerList(
              customers: [
                Customer(name: "Rajeev R", age: 30),
              ],
            ),
        child: MyHomePage(title: 'Provider State Management'),
      ),
   );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final customerList = Provider.of<CustomerList>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: customerList.getCustomers().length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${customerList.getCustomers()[index].name}'),
            subtitle: Text('${customerList.getCustomers()[index].age}'),
            trailing: Container(
              width: 50,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      customerList.removeCustomer(index);
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewCustomer(customerList: customerList)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
