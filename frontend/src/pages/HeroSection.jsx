import React from 'react'
import { SignedIn, SignedOut, SignInButton, UserButton } from '@clerk/clerk-react'
import { AuroraBackground } from '../components/aurora-background'
import { Link } from 'react-router-dom'

export default function HeroSection() {
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

      <AuroraBackground>
        <div className="flex flex-col items-center justify-center min-h-screen w-full">
          <h1 className="text-8xl font-bold text-center text-white tracking-tighter mb-8">
            Devnovate
          </h1>
          <div className="flex gap-2">
            <SignedOut>
              <SignInButton mode="modal">
                <button className="btn btn-primary btn-lg">
                  Get Started
                </button>
              </SignInButton>

              <SignInButton mode="modal">
                <Link to="/create" className="btn btn-lg">Host Event</Link>
              </SignInButton>
            </SignedOut>
          </div>
        </div>
      </AuroraBackground>
    </div>
  )
}
