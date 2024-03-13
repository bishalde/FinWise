import { Route, Routes } from "react-router-dom"
import Hero from "./Homepage/Hero"
import Offerings from "./Homepage/Offerings"
// import Login from "./Login/Login"
import Register from "./Register/Register"
import Analyzer from "./Budget_analyzer/Analyzer"
// import Expense from "./Expense_manager/Expense"
// import Adviser from "./AI_adviser/Adviser"

export default function Layout() {
  return (
    <>
        <Routes>
            <Route path="/" element = {
                <>
                    <Hero/>
                    <Offerings/>
                </>
            } />
            {/* <Route path="/login" element = {
                <Login/>
            } /> */}
            <Route path="/register" element = {
                <Register/>
            } />
            <Route path="/budget_analyze" element = {
                <Analyzer/>
            } />
            {/* <Route path="/expense_manager" element = {
                <Expense/>
            } /> */}
            {/* <Route path="/ai_adviser" element = {
                <Adviser/>
            } /> */}
        </Routes>
    </>
  )
}

 