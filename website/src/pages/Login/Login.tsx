import { useState } from "react"
import axios from "axios";

type Login = {
    email: string;
    password: string;
}

export default function Login() {
    const [login,setLogin] = useState<Login>({
        email: '',
        password: '',
    })
    const [sesh,setSesh] = useState({})
    const session = async(e:React.MouseEvent<HTMLButtonElement>) => {
        e.preventDefault();
        const response = await axios.post('http://10.5.144.157:8000/api/login/', login);
        const data = response.data;
        if(response.status != 200){
            alert("INVALID")
        }
        else{
            alert("OK")
        }
        e.preventDefault()
    }

    return (
        <div className="w-[100%] min-h-[80vh] overflow-hidden flex justify-center items-center bg-[#46E0FE]">
            <div className="w-full max-w-xs">
                <form className="bg-white shadow-md rounded px-8 pt-16 pb-20 mb-4 border-2">
                    <div className="mb-4">
                        <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="username">
                            Email
                        </label>
                    <input value={login.email} onChange={(e) => setLogin({...login,email:e.target.value})} className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" id="Email" type="text" placeholder="Email" />
                    </div>
                    <div className="mb-6">
                        <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="password">
                            Password
                        </label>
                        <input value={login.password} onChange={(e) => setLogin({...login,password:e.target.value})} className="shadow appearance-none border  rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline" id="password" type="password" placeholder="******************" />
                    </div>
                    <div className="flex items-center justify-between">
                        <button onClick={session} className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" type="button">
                            Sign In
                        </button>
                    </div>
                </form>
            </div>
        </div>
  )
}