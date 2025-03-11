import HeroSection from './pages/HeroSection';
import Event from "./pages/Event";
import Layout from './pages/Layout';
import { Route, Routes } from 'react-router-dom';
const App = () => {
  return (
    <>
    <Routes>
      <Route path="/" element ={<Layout/>}>
          <Route path="" element={<HeroSection/>} />

          {/* protected route */}
          <Route path="event" element={<Event/>} />

      </Route>
    </Routes>
    
    </>
  );
};

export default App 