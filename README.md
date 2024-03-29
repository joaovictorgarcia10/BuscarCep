# Find CEP 

A simple Flutter project, structured following the Clean Architecture and Clean Code principles.


## Features

- [x] Authentication (Firebase Auth)
- [x] Http Requests to search the address in a public API (Dio) 
- [x] Address CRUD (Cloud Firestore)
- [x] Geolocation (Geolocator)
- [x] Redirect to Google Maps and shows the best route from your current location to the selected address (Url Launcher)


## Organization

### /modules

The main features of the application, here the principle of modularization was applied, so that each module implements everything necessary for its own operation.

### /shared

Here we'll have the fundamental functionality to all the modules, implementations like shared features, generic errors and some utilities that can be acessed to the entire application.

## Module Layers

Each module are divided in some layers, so that each layer has its responsibility, following the Clean Architecture standard.

- Presentation
- Domain
- Data


<div align="center"> 
  <img src="https://github.com/joaovictorgarcia10/clean_arch_aula/blob/master/assets/images/git/data-flow.png" width="500" height="500"/>
</div>

## Preview


<img src="https://github.com/joaovictorgarcia10/clean_arch_aula/blob/master/assets/images/preview/Screenshot_1657817565.png" width="400" height="650"/>
<img src="https://github.com/joaovictorgarcia10/clean_arch_aula/blob/master/assets/images/preview/Screenshot_1657817571.png" width="400" height="650"/>
<img src="https://github.com/joaovictorgarcia10/clean_arch_aula/blob/master/assets/images/preview/Screenshot_1657817575.png" width="400" height="650"/>
<img src="https://github.com/joaovictorgarcia10/clean_arch_aula/blob/master/assets/images/preview/Screenshot_1657817579.png" width="400" height="650"/> 
<img src="https://github.com/joaovictorgarcia10/clean_arch_aula/blob/master/assets/images/preview/Screenshot_1657817597.png" width="400" height="650"/>
<img src="https://github.com/joaovictorgarcia10/clean_arch_aula/blob/master/assets/images/preview/Screenshot_1657817617.png" width="400" height="650"/>
<img src="https://github.com/joaovictorgarcia10/clean_arch_aula/blob/master/assets/images/preview/Screenshot_1657817620.png" width="400" height="650"/>



