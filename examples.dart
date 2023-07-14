// ==== Creating a new Component

class MyComponent extends StatelessWidget {
  final String displayString;

  @override
  Widget build(_) => Text(displayString);
}

// ==== Conditional Rendering

class ConditionalComponent extends StatelessWidget {
  final bool condition;

  @override
  Widget build(_) {
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

  @override
  Widget build(_) => IntermediateComponent(data: data);
}

class IntermediateComponent extends StatelessWidget {
  final String data;

  @override
  Widget build(_) => ChildComponent(data: data);
}

class ChildComponent extends StatelessWidget {
  final String data;

  @override
  Widget build(_) => Text("Received data: $data");
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
  Widget build(_) => RaisedButton(
    onPressed: () => setState(() => clicked = true),
    child: Text(clicked ? "Button clicked" : "Click me"),
  );
}

// ==== Handing user input

class TextInputComponent extends StatefulWidget {
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
  Widget build(_) => TextField(
    controller: _controller,
    decoration: const InputDecoration(labelText: "Enter text"),
  );
}

// ==== Lists & Looping

class ListComponent extends StatelessWidget {
  final List<String> items;

  @override
  Widget build(_) => ListView.builder(
    itemCount: items.length,
    itemBuilder: (_, index) => ListTile(title: Text(items[index])),
  );
}

// Usage
final items = ["Item 1", "Item 2", "Item 3"];
ListComponent(items: items)

// ==== List item keys

class Person {
  final String name;
  final int age;
  final String id;
}

class ItemKeysExample extends StatelessWidget {
  final List<Person> items;

  @override
  Widget build(_) => ListView.builder(
    itemCount: items.length,
    itemBuilder: (_, index) {
      final person = items[index];
      return ListTile(
        key: Key(person.id),
        title: Text('Name: ${person.name}, Age: ${person.age}'),
      );
    },
  );
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

  @override
  Widget build(_) => Column(children: [header, content]);
}

// Usage
Parent(header: Text("Header"), content: Child())

class Child extends StatelessWidget {
  @override
  Widget build(_) => Text("Child Content");
}

// ==== Modifiers

// In Flutter, you can wrap widgets with other widgets to achieve similar effects.
class ModifiersExample extends StatelessWidget {
  @override
  Widget build(_) => Container(
    padding: EdgeInsets.all(16.0),
    color: Colors.blue,
    child: Text('Hello, World!', style: TextStyle(color: Colors.white)),
  );
}

// ==== State

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  @override
  Widget build(_) => RaisedButton(
    onPressed: () => setState(() => count += 1),
    child: Text("Count: $count"),
  );
}

// ==== Scoped Data Propagation

class CustomInheritedWidget extends InheritedWidget {
  final String data;

  @override
  bool updateShouldNotify(CustomInheritedWidget oldWidget) =>
      oldWidget.data != data;
}

extension CustomInheritedWidgetContext on BuildContext {
  CustomInheritedWidget get customInheritedWidget =>
      dependOnInheritedWidgetOfExactType<CustomInheritedWidget>()!;
}

class Parent extends StatelessWidget {
  final String data;

  @override
  Widget build(_) => CustomInheritedWidget(
    data: data,
    child: Intermediate(),
  );
}

class Intermediate extends StatelessWidget {
  @override
  Widget build(_) => Child();
}

class Child extends StatelessWidget {
  @override
  Widget build(_) =>
      Text("Received data: ${context.customInheritedWidget.data}");
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
  Widget build(_) => Container(); // Other UI components
}
