// ==== Creating a new Component

class MyComponent extends StatelessWidget {
  final String displayString;

  MyComponent({required this.displayString});

  @override
  Widget build(BuildContext context) {
    return Text(displayString);
  }
}

// ==== Conditional Rendering

class ConditionalComponent extends StatelessWidget {
  final bool condition;

  ConditionalComponent({required this.condition});

  @override
  Widget build(BuildContext context) {
    if (condition) {
      return Text("Condition is true");
    } else {
      return Text("Condition is false");
    }
  }
}

// Usage
ConditionalComponent(condition: true)

// ==== Prop/Parameter Drilling

class Parent extends StatelessWidget {
  final String data;

  Parent({required this.data});

  @override
  Widget build(BuildContext context) {
    return IntermediateComponent(data: data);
  }
}

class IntermediateComponent extends StatelessWidget {
  final String data;

  IntermediateComponent({required this.data});

  @override
  Widget build(BuildContext context) {
    return ChildComponent(data: data);
  }
}

class ChildComponent extends StatelessWidget {
  final String data;

  ChildComponent({required this.data});

  @override
  Widget build(BuildContext context) {
    return Text("Received data: $data");
  }
}

// Usage
Parent(data: "Some data")

// ==== Responding to events

class ClickableComponent extends StatefulWidget {
  @override
  _ClickableComponentState createState() => _ClickableComponentState();
}

class _ClickableComponentState extends State<ClickableComponent> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => setState(() => clicked = true),
      child: Text(clicked ? "Button clicked" : "Click me"),
    );
  }
}

// ==== Handing user input

class TextInputComponent extends StatefulWidget {
  const TextInputComponent({super.key});

  @override
  State<TextInputComponent> createState() => _TextInputComponentState();
}

class _TextInputComponentState extends State<TextInputComponent> {
  late final _controller = TextEditingController(text: "");

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(labelText: "Enter text"),
    );
  }
}

// ==== Lists & Looping

class ListComponent extends StatelessWidget {
  final List<String> items;

  ListComponent({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(title: Text(items[index]));
      },
    );
  }
}

// Usage
final items = ["Item 1", "Item 2", "Item 3"];
ListComponent(items: items)

// ==== List item keys

class Person {
  final String name;
  final int age;
  final String id;

  Person({required this.name, required this.age, required this.id});
}

class ItemKeysExample extends StatelessWidget {
  final List<Person> items;

  ItemKeysExample({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final person = items[index];
        return ListTile(
          key: Key(person.id),
          title: Text('Name: ${person.name}, Age: ${person.age}'),
        );
      },
    );
  }
}

// Usage
ItemKeysExample(items: [
  Person(name: 'John', age: 30, id: '1'),
  Person(name: 'Jane', age: 28, id: '2'),
  Person(name: 'Bob', age: 25, id: '3')
])

// ==== Slot APIs

class Parent extends StatelessWidget {
  final Widget header;
  final Widget content;

  Parent({required this.header, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        header,
        content,
      ],
    );
  }
}

// Usage
Parent(header: Text("Header"), content: Child())

class Child extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Child Content");
  }
}

// ==== Modifiers

// In Flutter, you can wrap widgets with other widgets to achieve similar effects.
class ModifiersExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.blue,
      child: Text('Hello, World!', style: TextStyle(color: Colors.white)),
    );
  }
}

// ==== State

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => setState(() => count += 1),
      child: Text("Count: $count"),
    );
  }
}

// ==== Scoped Data Propagation

class CustomInheritedWidget extends InheritedWidget {
  final String data;

  CustomInheritedWidget({required this.data, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(CustomInheritedWidget oldWidget) {
    return oldWidget.data != data;
  }

  static CustomInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomInheritedWidget>()!;
  }
}

class Parent extends StatelessWidget {
  final String data;

  Parent({required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomInheritedWidget(
      data: data,
      child: Intermediate(),
    );
  }
}

class Intermediate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Child();
  }
}

class Child extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = CustomInheritedWidget.of(context).data;
    return Text("Received data: $data");
  }
}

// Usage
Parent(data: "Some data")

// ==== Side Effects

class SideEffectOnLoadComponent extends StatefulWidget {
  @override
  _SideEffectOnLoadComponentState createState() =>
      _SideEffectOnLoadComponentState();
}

class _SideEffectOnLoadComponentState extends State<SideEffectOnLoadComponent> {
  @override
  void initState() {
    super.initState();
    // Perform side effect, e.g. fetch data, update external data source
  }

  @override
  Widget build(BuildContext context) {
    // Other UI components
    return Container();
  }
}
