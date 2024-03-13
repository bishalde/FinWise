import './App.css'
import Backdrop from './components/Backdrop'
import Navbar from './components/Navbar'
import Layout from './pages/Layout'

export default function App() {

  return (
    <div className="min-h-[100vh] overflow-hidden ">
      <Navbar/>
      <Layout/>
      <Backdrop/>
    </div>
  )
}

