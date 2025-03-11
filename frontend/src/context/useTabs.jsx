import { useContext } from "react";
import { createContext, useState } from "react";

const tabContext = createContext(null);

export function useTabs() {
  return useContext(tabContext);
}

export function TabsProvider({ children }) {
  const [currentTab, setCurrentTab] = useState(0);

  const openTab = tabId => {
    return () => setCurrentTab(() => tabId);
  }

  return <tabContext.Provider value={{
    currentTab,
    openTab
  }}>
    {children}
  </tabContext.Provider>
}
