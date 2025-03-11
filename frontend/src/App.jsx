import EventCard from './components/EventCard';
import HeroSection from './pages/HeroSection';

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

const App = () => {
  return (
    <>
      <HeroSection />

      <section className="py-20 px-6 bg-gradient-to-b from-black to-gray-900">
        <div className="max-w-7xl mx-auto">
          <h2 className="text-4xl font-bold text-white mb-12 text-center tracking-tighter">Upcoming Hackathons</h2>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {hackathons.map(hackathon => <EventCard {...hackathon} key={hackathon.id} />)}
          </div>
        </div>
      </section>
    </>
  );
};

export default App 
