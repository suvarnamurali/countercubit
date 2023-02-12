import 'package:counterapp/mycubit/counter_cubit/counter_cubit.dart';
import 'package:counterapp/mycubit/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final ThemeData dark = ThemeData.dark();

  final ThemeData light = ThemeData.light();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => CounterCubit(),
        )
      ],
      child: BlocBuilder<CounterCubit,CounterState>(
        
       builder: (context, state) {
        if (state.themeChanged == true ) {
          return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: dark,
          home: MyHomePage(title: 'Counter'),
        );
        }
        else{
            return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: light,
          home: MyHomePage(title: 'Counter'),
        );

        } },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocListener<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state.wasIncremented == true) {

            // SnackBar is depricated in scaffold class 
            // so ScaffoldMessenger is used insted 
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Incremented'),
                duration: Duration(seconds: 1),
              ),
            );
          }

          else if (state.wasDecremented == true) {

            // SnackBar is depricated in scaffold class 
            // so ScaffoldMessenger is used insted 
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Decremented'),
                duration: Duration(seconds: 1),
              ),
            );
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              BlocBuilder<CounterCubit, CounterState>(
                builder: (context, state) {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            FloatingActionButton(
              onPressed: BlocProvider.of<CounterCubit>(context).increment,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: BlocProvider.of<CounterCubit>(context).decrement,
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
            // FloatingActionButton(
            //    onPressed: () => context.read<ThemeCubit>().changeTheme,
            //    tooltip: 'change theme',
            //    child: const Icon(Icons.color_lens),
            // ),
          ],
        ),
      ),
    );
  }
}
