import { Tab, Tabs } from "../components/create_event/Tabs";
import { useState } from "react";
import { useTabs } from "../context/useTabs";

export default function CreateEvent() {
  const [tabBtns, setTabBtns] = useState([
    { id: 0, name: "Hello exportld", deletor: deleteTab(0) },
    { id: 1, name: "World", deletor: deleteTab(1) },
    { id: 2, name: "Kono", deletor: deleteTab(2) },
    { id: 3, name: "Suba", deletor: deleteTab(3) },
  ]);

  const [tabs, setTabs] = useState([
    { id: 0, elem: <div className="p-4 bg-transparent">Hello</div> },
    { id: 1, elem: <div className="p-4 bg-transparent">wrolrd</div> },
    { id: 2, elem: <div className="p-4 bg-transparent">Hello</div> },
    { id: 3, elem: <div className="p-4 bg-transparent">Hello</div> },
  ]);

  const [imgUrl, setUrl] = useState("https://placehold.co/820x312");

  function setBanner(e) {
    const file = URL.createObjectURL(e.target.files[0]);

    setUrl(file);
  }

  function deleteTab(idx) {
    return () => {
      setTabBtns(tabs => tabs.filter(tab => tab.id !== idx));
      setTabs(tabs => tabs.filter(tab => tab.id !== idx));
    }
  }

  function addTab() {
    const uniqueId = Date.now();

    const newTabBtn = {
      id: uniqueId,
      name: "New Tab",
      deletor: deleteTab(uniqueId)
    };

    const newTab = {
      id: uniqueId,
      elem: <div className="p-4 bg-transparent">New Tab {uniqueId}</div>
    }

    setTabBtns(tabs => [...tabs, newTabBtn]);
    setTabs(tabs => [...tabs, newTab]);
  }

  return <>
    <label onChange={setBanner} htmlFor="banner-image-input" className="h-[70vh] w-full block">
      <input type="file" name="banner-image-input" id="banner-image-input" className="file-input" hidden />
      <img src={imgUrl} className="object-cover size-full" alt="hackathon banner" />
    </label>

    <Tabs tabs={tabBtns} addNewTab={addTab}>
      {tabs.map(tab => <Tab id={tab.id} key={tab.id}>{tab.elem}</Tab>)}
    </Tabs>
  </>
}
