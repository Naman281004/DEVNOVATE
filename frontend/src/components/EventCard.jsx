export default function EventCard({ image, id, title, isNew, tags, description }) {
  return <div key={id} className="card bg-base-100 w-full shadow-xl hover:shadow-2xl transition-all duration-300 hover:-translate-y-2 text-white">
    <figure className="h-48 overflow-hidden">
      <img
        src={image}
        alt={title}
        className="w-full h-full object-cover"
      />
    </figure>
    <div className="card-body">
      <h2 className="card-title text-xl">
        {title}
        {isNew && (
          <div className="badge badge-secondary bg-purple-600 text-white">NEW</div>
        )}
      </h2>
      <p className="text-gray-300">{description}</p>
      <div className="card-actions justify-end mt-4">
        {tags.map((tag, index) => (
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
}
