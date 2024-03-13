import axios from "axios";
import { useState } from "react"

type FormState = {
    firstName: string;
    lastName: string;
    dob: string;
    email: string;
    password: string;
    phoneNumber: number;
    gender: string;
    address: string;
    city: string;
    state: string;
    country: string;
    zipCode: number;
};

export default function Register() {
    const [data, setData] = useState<FormState>({
        firstName: '',
        lastName: '',
        dob: '',
        email: '',
        password:'',
        phoneNumber: Number(),
        gender: '',
        address: '',
        city: '',
        state: '',
        country: '',
        zipCode: Number(),
    })

    const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        setData({
            ...data,
            [e.target.name]: e.target.value,
        });
    };

    const [fill, setFill] = useState(false)
    const handlesubmit = async(e:React.MouseEvent<HTMLButtonElement>) => {
        axios.post('http://10.5.144.157:8000/api/register/', data);
        setFill(!fill)
        console.log(data)
        e.preventDefault()
    }
    return (
        <div className="">
        <span className="w-[100vw] min-h-[100vh] z-[998] relative flex flex-col items-center p-4 bg-[#faf5ef]">
            <h1 className="text-3xl mt-8 mb-8 font-poppins text-black">
                Registration Form
            </h1>
            {!fill &&   
            <span className="p-[40px] border-[1px] rounded-lg border-gray-200 bg-gray-200">
                <form className="w-[40vw] ">
                    <div className="relative z-[3] w-full mb-6 group">
                        <input type="text" value={data.firstName} onChange={handleChange} name="firstName" id="firstName" className="block py-2.5 px-0 w-full text-lg text-gray-900 bg-transparent border-0 border-b-[1px] border-gray-300 appearance-none  dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder="" required />
                        <label htmlFor="floating_first_name" className="peer-focus:font-medium absolute text-xl text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">First Name</label>
                    </div>
                    <div className="relative z-[3] w-full mb-6 group">
                        <input type="text" value={data.lastName} onChange={handleChange} name="lastName" id="lastName" className="block py-2.5 px-0 w-full text-lg text-gray-900 bg-transparent border-0 border-b-[1px] border-gray-300 appearance-none  dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder="" required />
                        <label htmlFor="floating_first_name" className="peer-focus:font-medium absolute text-xl text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Last Name</label>
                    </div>
                    <div className="relative z-[3] w-full mb-6 group">
                        <input type="date" value={data.dob} onChange={handleChange} name="dob" id="dob" className="block py-2.5 px-0 w-full text-lg text-gray-900 bg-transparent border-0 border-b-[1px] border-gray-300 appearance-none  dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder="" required />
                        <label htmlFor="floating_first_name" className="peer-focus:font-medium absolute text-xl text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">DOB (DD-MM-YYYY)</label>
                    </div>
                    <div className="relative z-[3] w-full mb-6 group">
                        <input type="email" value={data.email} onChange={handleChange} name="email" id="email" className="block py-2.5 px-0 w-full text-lg text-gray-900 bg-transparent border-0 border-b-[1px] border-gray-300 appearance-none  dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder="" required />
                        <label htmlFor="floating_first_name" className="peer-focus:font-medium absolute text-xl text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Email</label>
                    </div>
                    <div className="relative z-[3] w-full mb-6 group">
                        <input type="password" value={data.password} onChange={handleChange} name="password" id="password" className="block py-2.5 px-0 w-full text-lg text-gray-900 bg-transparent border-0 border-b-[1px] border-gray-300 appearance-none  dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder="" required />
                        <label htmlFor="floating_first_name" className="peer-focus:font-medium absolute text-xl text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Password</label>
                    </div>
                    <div className="relative z-[3] w-full mb-6 group">
                        <input type="number" value={data.phoneNumber} onChange={handleChange} name="phoneNumber" id="phoneNumber" className="block py-2.5 px-0 w-full text-lg text-gray-900 bg-transparent border-0 border-b-[1px] border-gray-300 appearance-none  dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder="" required />
                        <label htmlFor="floating_first_name" className="peer-focus:font-medium absolute text-xl text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Phone Number</label>
                    </div>
                    <div className="relative z-[3] w-full mb-6 group">
                        <select value={data.gender} onChange={(e) => setData({...data,gender:e.target.value})} id="countries" className="bg-gray-50 border border-gray-300 text-gray-900 text-lg rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5  dark:focus:ring-blue-500 dark:focus:border-blue-500">
                            <option value="">-- Select Gender -- </option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Prefer not to say">Prefer not to say</option>
                        </select>
                    </div>
                    <div className="relative z-[3] w-full mb-6 group">
                        <input type="text" value={data.address} onChange={handleChange} name="address" id="address" className="block py-2.5 px-0 w-full text-lg text-gray-900 bg-transparent border-0 border-b-[1px] border-gray-300 appearance-none  dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder="" required />
                        <label htmlFor="floating_first_name" className="peer-focus:font-medium absolute text-xl text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Address</label>
                    </div>
                    <div className="relative z-[3] w-full mb-6 group">
                        <input type="text" value={data.city} onChange={handleChange} name="city" id="city" className="block py-2.5 px-0 w-full text-lg text-gray-900 bg-transparent border-0 border-b-[1px] border-gray-300 appearance-none  dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder="" required />
                        <label htmlFor="floating_first_name" className="peer-focus:font-medium absolute text-xl text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">City</label>
                    </div>
                    <div className="relative z-[3] w-full mb-6 group">
                        <input type="text" value={data.state} onChange={handleChange} name="state" id="state" className="block py-2.5 px-0 w-full text-lg text-gray-900 bg-transparent border-0 border-b-[1px] border-gray-300 appearance-none  dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder="" required />
                        <label htmlFor="floating_first_name" className="peer-focus:font-medium absolute text-xl text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">State</label>
                    </div>
                    <div className="relative z-[3] w-full mb-6 group">
                        <input type="text" value={data.country} onChange={handleChange} name="country" id="country" className="block py-2.5 px-0 w-full text-lg text-gray-900 bg-transparent border-0 border-b-[1px] border-gray-300 appearance-none  dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder="" required />
                        <label htmlFor="floating_first_name" className="peer-focus:font-medium absolute text-xl text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">Country</label>
                    </div>
                    <div className="relative z-[3] w-full mb-6 group">
                        <input type="number" value={data.zipCode} onChange={handleChange} name="zipCode" id="zipCode" className="block py-2.5 px-0 w-full text-lg text-gray-900 bg-transparent border-0 border-b-[1px] border-gray-300 appearance-none  dark:border-gray-600 dark:focus:border-blue-500 focus:outline-none focus:ring-0 focus:border-blue-600 peer" placeholder="" required />
                        <label htmlFor="floating_first_name" className="peer-focus:font-medium absolute text-xl text-gray-500 dark:text-gray-400 duration-300 transform -translate-y-6 scale-75 top-3 -z-10 origin-[0] peer-focus:left-0 peer-focus:text-blue-600 peer-focus:dark:text-blue-500 peer-placeholder-shown:scale-100 peer-placeholder-shown:translate-y-0 peer-focus:scale-75 peer-focus:-translate-y-6">ZipCode</label>
                    </div>
                    <button type="submit" onClick={handlesubmit} className="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Submit</button>
                </form>
            </span>
            }
            {fill &&
                <h1 className="text-2xl mt-8 mb-8 font-abel text-black">
                    Thank you for registering!
            </h1>
            }
        </span>
    </div>
  )
}