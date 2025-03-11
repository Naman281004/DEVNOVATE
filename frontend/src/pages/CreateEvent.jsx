import { Plus } from "lucide-react";

export default function CreateEvent() {
  return <>
    <label htmlFor="banner-image-input" className="h-[70vh] grid place-items-center mockup-browser">
      <input type="file" name="banner-image-input" id="banner-image-input" className="file-input" hidden />
      <div className="flex items-center flex-col text-bold">
        Upload your banner image here
        <Plus />
      </div>
    </label>

    <Tabs></Tabs>
  </>
}
