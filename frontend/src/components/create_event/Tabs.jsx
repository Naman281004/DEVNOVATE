import { TabsProvider } from "../../context/useTabs";

export default function Tabs({ children }) {
  return <TabsProvider>
    {children}
  </TabsProvider>
}
