import React from 'react'
import { SignedIn, SignedOut, SignInButton, UserButton } from '@clerk/clerk-react'
import { AuroraBackground } from '../components/aurora-background'

export default function HeroSection() {
  // Sample hackathon data
  const hackathons = [
    {
      id: 1,
      title: "AI Innovation Hackathon",
      image: "https://images.unsplash.com/photo-1591453089816-0fbb971b454c?q=80&w=2070&auto=format&fit=crop",
      description: "Build the next generation of AI-powered applications in this 48-hour coding challenge.",
      isNew: true,
      tags: ["AI", "Machine Learning"]
    },
    {
      id: 2,
      title: "Web3 Blockchain Hackathon",
      image: "https://images.unsplash.com/photo-1639762681057-408e52192e55?q=80&w=2070&auto=format&fit=crop",
      description: "Create decentralized applications on blockchain technology and compete for crypto prizes.",
      isNew: false,
      tags: ["Blockchain", "Crypto", "Web3"]
    },
    {
      id: 3,
      title: "Mobile App Challenge",
      image: "https://images.unsplash.com/photo-1551650975-87deedd944c3?q=80&w=1974&auto=format&fit=crop",
      description: "Design and develop innovative mobile applications that solve real-world problems.",
      isNew: true,
      tags: ["Mobile", "UI/UX", "Swift"]
    }
  ];

  return (
    <div className="min-h-screen w-full">
      <header className="p-4 flex bg-transparent justify-end items-center fixed right-0 top-0 z-20 text-slate-300">
        <SignedOut>
          <SignInButton className="btn btn-ghost btn-lg" />
        </SignedOut>
        <SignedIn>
          <UserButton />
        </SignedIn>
      </header>

      {/* Hero Section */}
      <AuroraBackground>
        <div className="flex flex-col items-center justify-center min-h-screen w-full">
          <h1 className="text-8xl font-bold text-center text-white tracking-tighter mb-8">
            Devnovate
          </h1>
          <SignedOut>
            <SignInButton mode="modal">
              <button className="btn btn-primary btn-lg">
                Get Started
              </button>
            </SignInButton>
          </SignedOut>
        </div>
      </AuroraBackground>

      {/* Hackathons Section */}
      <section className="py-20 px-6 bg-gradient-to-b from-black to-gray-900">
        <div className="max-w-7xl mx-auto">
          <h2 className="text-4xl font-bold text-white mb-12 text-center tracking-tighter">Upcoming Hackathons</h2>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {hackathons.map((hackathon) => (
              <div key={hackathon.id} className="card bg-base-100 w-full shadow-xl hover:shadow-2xl transition-all duration-300 hover:-translate-y-2 text-white">
                <figure className="h-48 overflow-hidden">
                  <img
                    src={hackathon.image}
                    alt={hackathon.title}
                    className="w-full h-full object-cover"
                  />
                </figure>
                <div className="card-body">
                  <h2 className="card-title text-xl">
                    {hackathon.title}
                    {hackathon.isNew && (
                      <div className="badge badge-secondary bg-purple-600 text-white">NEW</div>
                    )}
                  </h2>
                  <p className="text-gray-300">{hackathon.description}</p>
                  <div className="card-actions justify-end mt-4">
                    {hackathon.tags.map((tag, index) => (
                      <div key={index} className="badge badge-outline border-gray-400 text-gray-300">{tag}</div>
                    ))}
                  </div>
                  <div className="mt-6">
                    <button className="btn btn-primary bg-blue-600 hover:bg-blue-700 border-none w-full">
                      Register Now
                    </button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>
    </div>
  )
}
