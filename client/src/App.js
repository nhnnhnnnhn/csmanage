import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import 'bootstrap/dist/css/bootstrap.min.css';
import './App.css';

// Components
import Navbar from './components/Navbar';
import Footer from './components/Footer';

// Pages
import Home from './pages/Home';
import Dashboard from './pages/Dashboard';
import ManufacturerList from './pages/manufacturer/ManufacturerList';
import ManufacturerForm from './pages/manufacturer/ManufacturerForm';
import PCList from './pages/pc/PCList';
import PCForm from './pages/pc/PCForm';
import LaptopList from './pages/laptop/LaptopList';
import LaptopForm from './pages/laptop/LaptopForm';

function App() {
  return (
    <Router>
      <div className="App">
        <Navbar />
        <main className="container py-4">
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/dashboard" element={<Dashboard />} />
            
            <Route path="/manufacturers" element={<ManufacturerList />} />
            <Route path="/manufacturers/add" element={<ManufacturerForm />} />
            <Route path="/manufacturers/edit/:id" element={<ManufacturerForm />} />
            
            <Route path="/pcs" element={<PCList />} />
            <Route path="/pcs/add" element={<PCForm />} />
            <Route path="/pcs/edit/:id" element={<PCForm />} />
            
            <Route path="/laptops" element={<LaptopList />} />
            <Route path="/laptops/add" element={<LaptopForm />} />
            <Route path="/laptops/edit/:id" element={<LaptopForm />} />
          </Routes>
        </main>
        <Footer />
      </div>
    </Router>
  );
}

export default App;
