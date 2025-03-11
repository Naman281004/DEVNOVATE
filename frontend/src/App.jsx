import { createBrowserRouter, createRoutesFromElements, Route, RouterProvider } from 'react-router-dom';
import Home from './pages/Home';
import CreateEvent from './pages/CreateEvent';
import Layout from './pages/Layout';

const router = createBrowserRouter(
  createRoutesFromElements(
    <Route path={"/"} element={<Layout />}>
      <Route index element={<Home />} />
      <Route path={"/create"} element={<CreateEvent />}></Route>
    </Route>,
  )
)

const App = () => {
  return (
    <RouterProvider router={router} />
  );
};

export default App 
