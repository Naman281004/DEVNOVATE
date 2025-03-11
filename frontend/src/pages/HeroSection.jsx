import React from 'react'
import { SignedIn, SignedOut, SignInButton, UserButton } from '@clerk/clerk-react'
import { AuroraBackground } from '../components/aurora-background'
export default function HeroSection() {
  return (
    <div className="h-screen w-full">
      <header className="p-4 flex bg-transparent justify-end items-center fixed right-0 top-0 z-10 text-slate-300">
        <SignedOut>
          <SignInButton />
        </SignedOut>
        <SignedIn>
          <UserButton />
        </SignedIn>
      </header>
      <AuroraBackground>
        <div className="flex flex-col items-center justify-center h-full w-full text-white">
          <h1 className="text-9xl font-bold mb-4">Devnovate</h1>
        </div>
      </AuroraBackground>
    </div>
  )
}
