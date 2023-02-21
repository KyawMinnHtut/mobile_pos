import 'package:flutter/material.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile POS'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.settings))
        ],
      ),
      body: Column(
        children: [
          Expanded(flex: 2,child: Container(),),
          Wrap(
            spacing: 4,
            children: [
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 7,
                    child: Container(
                      color: Colors.blue[100],
                      width: 100,
                      height: 100,
                      child: const Center(child: Text("Sales")),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.pushNamed(context, '/sale');
                },
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 7,
                    child: Container(
                      color: Colors.blue[100],
                      width: 100,
                      height: 100,
                      child: const Center(child: Text("Purchase")),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.pushNamed(context, '/purchase');
                },
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 7,
                    child: Container(
                      color: Colors.blue[100],
                      width: 100,
                      height: 100,
                      child: const Center(child: Text("Inventory")),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.pushNamed(context, '/inventory');
                },
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 7,
                    child: Container(
                      color: Colors.blue[100],
                      width: 100,
                      height: 100,
                      child: const Center(child: Text("Contacts")),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.pushNamed(context, '/contacts');
                },
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 7,
                    child: Container(
                      color: Colors.blue[100],
                      width: 100,
                      height: 100,
                      child: const Center(child: Text("Ex Manager")),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.pushNamed(context, '/expensemanager');
                },
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 7,
                    child: Container(
                      color: Colors.blue[100],
                      width: 100,
                      height: 100,
                      child: const Center(child: Text("Reports")),
                    ),
                  ),
                ),
                onTap: (){
                  Navigator.pushNamed(context, '/category');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
