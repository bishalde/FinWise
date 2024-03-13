import axios from "axios"
import { useState } from "react"

type Info = {
    income : number;
    home : number;
    food : number;
    fun : number;
}

export default function Analyzer() {
    
    const [info,setInfo] = useState<Info>({
        income : Number(),
        home : Number(),
        food : Number(),
        fun : Number(),
    })

    const [indicator, setIndicator] = useState(false)

    const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        setInfo({
            ...info,
            [e.target.name]: e.target.value,
        });
    };


    const assess = async(e:React.MouseEvent<HTMLButtonElement>) => {
        e.preventDefault();
        setIndicator(!indicator)
        return 1;
    }

    return (
        <div className="w-[100%] min-h-[80vh] overflow-hidden flex justify-center items-center relative bg-[#46E0FE]">
            {!indicator &&
                <div className="w-full max-w-xs z-4">
                <form className="bg-white shadow-md px-8 pt-[16px] rounded-lg pb-10 mb-4 border-2 font-poppins">
                    <div className="mb-4">
                        <label className="block text-gray-700 text-md font-bold mb-2" htmlFor="username">
                            Income
                        </label>
                        <input type="number" value={info.income} onChange={handleChange} className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="income" placeholder="income" />
                    </div>
                    <div className="mb-6">
                        <label className="block text-gray-700 text-md font-bold mb-2" htmlFor="password">
                            Home Expenses
                        </label>
                        <input value={info.home} onChange={handleChange} className="shadow appearance-none border  rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline" id="home" type="number" placeholder="home expenses" />
                    </div>
                    <div className="mb-6">
                        <label className="block text-gray-700 text-md font-bold mb-2" htmlFor="password">
                            Food Expenses
                        </label>
                        <input value={info.food} onChange={handleChange} className="shadow appearance-none border  rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline" id="food" type="number" placeholder="food expenses"/>
                    </div>
                    <div className="mb-6">
                        <label className="block text-gray-700 text-md font-bold mb-2" htmlFor="password">
                            Entertainment Expenses
                        </label>
                        <input value={info.fun} onChange={handleChange} className="shadow appearance-none border  rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline" id="fun" type="number" placeholder="Entertainment expenses" />
                    </div>
                    <div className="flex items-center justify-between">
                        <button onClick={assess} className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" type="button">
                            Assess
                        </button>
                    </div>
                </form>
            </div>}
        </div>
    )
}
