import { TabsProvider, useTabs } from "../../context/useTabs";
import { cn } from "../../../utils/cn"
import { CirclePlus, X } from "lucide-react";

export function TabBtn({ name, id, deletor }) {
  const { currentTab, openTab } = useTabs();

  return <a role="tab" onClick={openTab(id)} className={cn("tab flex items-center gap-4", id === currentTab && "tab-active")}>
    {name}
    <button onClick={deletor}><X className="scale-90 cursor-pointer" /></button>
  </a>
}

export function Tab({ children, id }) {
  const { currentTab } = useTabs();

  if (id !== currentTab) return null;

  return <div>{children}</div>
}

export function Tabs({ tabs, children, addNewTab }) {
  return <TabsProvider>
    <div className="tabs tabs-lift" role="tablist">
      {tabs.map(tab => <TabBtn {...tab} key={tab.id} />)}
      <button className="btn btn-ghost rounded-full btn-square p-0 grid place-items-center" onClick={addNewTab}><CirclePlus /></button>
    </div>

    {children}
  </TabsProvider>
}
