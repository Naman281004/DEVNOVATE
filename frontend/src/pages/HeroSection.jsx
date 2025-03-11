import React from 'react'
import { SignedIn, SignedOut, SignInButton, UserButton } from '@clerk/clerk-react'
import { AuroraBackground } from '../components/aurora-background'
export default function HeroSection() {
  return (
    <div className="h-screen w-full">
      <header>
      <SignedOut>
        <SignInButton />
      </SignedOut>
      <SignedIn>
        <UserButton />
      </SignedIn>
    </header>
      <AuroraBackground>
        <div className="flex flex-col items-center justify-center h-full w-full text-white">
          <h1 className="text-7xl font-bold mb-4">Devnovate</h1>
        </div>
      </AuroraBackground>
    </div>
  )
}
