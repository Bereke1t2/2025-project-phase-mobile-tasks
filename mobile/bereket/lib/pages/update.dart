import 'package:e_commerce/models/product.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:e_commerce/models/product.dart';
import 'dart:io';
import 'package:e_commerce/data/dataRepo.dart';

// Convert UpdatePage to StatefulWidget to handle form state
class UpdatePage extends StatefulWidget {
  final Product? product;
  const UpdatePage({super.key, this.product});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  File? _image;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _categoryController = TextEditingController(text: widget.product?.category ?? '');
    _priceController = TextEditingController(text: widget.product?.price?.toString() ?? '');
    _descriptionController = TextEditingController(text: widget.product?.description ?? '');
    if (widget.product?.imageUrl != null && widget.product!.imageUrl.isNotEmpty) {
      _image = File(widget.product!.imageUrl);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  
  void _onAdd() {
  if (_formKey.currentState?.validate() ?? false) {
    final newProduct = Product(
      id: widget.product?.id ?? DateTime.now().millisecondsSinceEpoch,
      name: _nameController.text,
      category: _categoryController.text,
      price: double.tryParse(_priceController.text) ?? 0.0,
      description: _descriptionController.text,
      imageUrl: _image?.path ?? '',
      rating: widget.product?.rating ?? 0.0,
    );
    ProductList.add(newProduct);

    print('Product updated:');
    print('Name: ${newProduct.name}');
    print('Category: ${newProduct.category}');
    print('Price: ${newProduct.price}');
    print('Description: ${newProduct.description}');
    print('Image: ${newProduct.imageUrl}');

    // TODO: Save to database or state
    GoRouter.of(context).go('/home'); // maybe go back to home
  }
}


  void _onDelete() {
    // Delete product logic here
    // Example: print('Deleted');
    print('Deleted');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Add Product', style: TextStyle(fontSize: 16)),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Color(0xFF3F51F3)),
          onPressed: () {
            GoRouter.of(context).go('/home');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                InputImage(
                  image: _image,
                  onImagePicked: (file) {
                    setState(() {
                      _image = file;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Input(
                  label: "Name",
                  controller: _nameController,
                  validator: (value) => value == null || value.isEmpty ? 'Enter name' : null,
                ),
                const SizedBox(height: 20),
                Input(
                  label: "Category",
                  controller: _categoryController,
                  validator: (value) => value == null || value.isEmpty ? 'Enter category' : null,
                ),
                const SizedBox(height: 20),
                Input(
                  label: "Price",
                  controller: _priceController,
                  placeholder: "\$",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Enter price';
                    if (double.tryParse(value) == null) return 'Enter valid number';
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Input(
                  label: "Description",
                  controller: _descriptionController,
                  height: 60,
                  maxLines: 3,
                  validator: (value) => value == null || value.isEmpty ? 'Enter description' : null,
                ),
                const SizedBox(height: 20),
                Button(
                  onPressed: _onAdd,
                  name: "ADD",
                  color: const Color(0xFF3F51F3),
                  textColor: Colors.white,
                ),
                const SizedBox(height: 20),
                Button(
                  onPressed: _onDelete,
                  name: "DELETE",
                  borderColor: const Color.fromRGBO(255, 19, 19, 0.79),
                  textColor: const Color.fromRGBO(255, 19, 19, 0.79),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InputImage extends StatelessWidget {
  final File? image;
  final ValueChanged<File?> onImagePicked;
  const InputImage({super.key, this.image, required this.onImagePicked});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onImagePicked(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickImage(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFF3F3F3),
        ),
        height: 190,
        width: double.infinity,
        child: image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(height: 10),
                  Icon(Icons.image, color: Color(0xFF3E3E3E), size: 48),
                  SizedBox(height: 10),
                  Text(
                    'upload image',
                    style: TextStyle(
                        color: Color(0xFF3E3E3E), fontSize: 14),
                  ),
                ],
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  image!,
                  width: double.infinity,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}

class Input extends StatelessWidget {
  final String label;
  final int height;
  final String placeholder;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;

  const Input({
    super.key,
    required this.label,
    this.height = 15,
    this.placeholder = '',
    this.controller,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3E3E3E),
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFF3F3F3),
            hintText: placeholder,
            hintStyle: const TextStyle(
              color: Color(0xFFB0B0B0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(6),
            ),
            contentPadding: EdgeInsets.symmetric(
                horizontal: 10, vertical: height.toDouble()),
          ),
          style: const TextStyle(fontSize: 16),
          textAlignVertical: TextAlignVertical.center,
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  final String name;
  final double height;
  final double width;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final VoidCallback onPressed;
  const Button({
    super.key,
    this.name = 'Add Product',
    this.height = 50,
    this.width = double.infinity,
    this.color = Colors.white,
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1),
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          name,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}