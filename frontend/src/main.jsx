import React from 'react'
import ReactDOM from 'react-dom/client'
import App from "./App"
import './index.css'
import { ClerkProvider } from '@clerk/clerk-react'
import { BrowserRouter, Route, Routes } from "react-router-dom"
// Import your Publishable Key
const PUBLISHABLE_KEY = import.meta.env.VITE_CLERK_PUBLISHABLE_KEY

if (!PUBLISHABLE_KEY) {
  throw new Error('Add your Clerk Publishable Key to the .env file')
}

ReactDOM.createRoot(document.getElementById('root')).render(
  <BrowserRouter>
    <React.StrictMode>
      <ClerkProvider publishableKey={PUBLISHABLE_KEY} afterSignOutUrl="/">
        <Routes>
          <Route path='/*' element={<App />} />
        </Routes>
      </ClerkProvider>
    </React.StrictMode>
  </BrowserRouter>
)