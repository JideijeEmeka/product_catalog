# product_catalog_app

A Stackbuld Technical assessment project.

## Getting Started

This project is a starting point for a Flutter Product Catalog Application.

**i. Project Overview**


**_This is a product catalog mobile application built using flutter framework
    in conjunction with the dart programming language. In this app users can add 
    new products with various options of adding an image, and selecting a category 
    for each product. The user experience of this app is awesome and makes it easier 
    for users to also edit, delete and view all available products and the product details. 
    Filtering of products by its category was not left out as it was also implemented 
    to help users filter and view only products with the selected category of their choice.
    It was built from scratch to deployment to Github by _Emeka Jideije,_ a seasoned 
    mobile developer with 3+ years of building mobile applications using Flutter._**

## Testing Guide
**_Steps to run the application._**
### Cloning Repo
Clone the project
```bash
  https://github.com/JideijeEmeka/product_catalog.git
```

Go to the project directory

```bash
  cd product_catalog_app
```

Install dependencies (project currently runs on Flutter 3.19/Dart 3.3.0)
```bash
  flutter pub get
```

Run project
```bash
  cd run
```

### Notes on design decisions, optimizations, and trade-offs
- The best and simplest user experience was chosen and implemented.
- The best and simplest state management(Provider) was chosen and implemented.
- The best and simplest designs and color mixes was chosen and implemented.
- The best and simplest optimizations technique of using only set-state to rebuild screens was chosen and implemented.
- The best and simplest trade-offs technique of using provider in few scenarios in order to free more memory and also ensure the app is optimized.

### Explanation of state management used
The state management approach used in this app is the provider, 
it was used in only saving and retrieving products list, updating the products filter
and displaying loader state.
