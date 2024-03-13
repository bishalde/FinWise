import { Link } from 'react-router-dom';

export default function Offerings() {
  return (
    <div className="relative w-[100%] h-[100%] bg-white mb-[20px]">
            <div className="relative flex-col justify-between items-center">
                <span>
                    <h1 className="text-[3.5rem] font-abel font-semibold leading-[70px] text-center mt-[20px]">Browse our set of finance <br /> services and offerings</h1>
                </span>
                <div className=" flex justify-center">
                    <button className=" font-medium inline-flex justify-center items-center my-[20px] py-[10px] pl-[20px] pr-[10px] text-[1.1rem] border-none bg-[#0000ff] text-white rounded-[20px] mr-[10px] hover:scale-[1.05] hover:bg-[#333ed385] hover:ease-in duration-300 ">
                            Get started
                        <img className="ml-[4px] inline relative items-center rotate-90 w-[20px] h-[20px] text-white"
                        width="32"
                        height="32"
                        src="https://img.icons8.com/windows/32/ffffff/up-left-arrow.png"
                        alt="up-left-arrow"
                        />
                    </button>

                    <button className="ml-[10px] inline-flex justify-center items-center bg-transparent border-[1px] border-solid border-black text-[#000000] rounded-[20px] pl-[20px] pr-[10px] py-[10px] my-[20px] hover:scale-[1.05] hover:bg-[#333ed385] hover:ease-in duration-300">
                        Contact sales
                        <img className="ml-[4px] inline relative items-center rotate-90 w-[20px] h-[20px]"
                        width="32"
                        height="32"
                        src="https://img.icons8.com/windows/32/000000/up-left-arrow.png"
                        alt="up-left-arrow"
                        />
                    </button>
                </div>
            </div>
            <div className="grid xl:grid-cols-3 lg:grid-cols-2 justify-items-center px-[50px] gap-[20px] gap-y-[40px] pt-[20px]">
                
                <span className="border-solid border-black max-w-[400px] border-[1px] rounded-[10px] hover:scale-[1.05] hover:bg-black hover:text-white hover:ease-in duration-300">
                    <Link to="#">
                        <div className="flex-col p-[28px]  text-center items-center ">
                            <h1 className="text-[1.9rem] font-abel font-semibold leading-[30px] text-center mb-[12px]">AI Advisor</h1>
                            <h3 className="text-[0.9rem] font-normal leading-[30px] mb-[20px] font-poppins text-justify">An AI advisor streamlines financial decisions with personalized recommendations.</h3>
                        </div>
                    </Link>
                </span>

                <span className="border-solid border-black max-w-[400px] border-[1px] rounded-[10px] hover:scale-[1.05] hover:bg-black hover:text-white hover:ease-in duration-300">
                    <Link to="/expense_manager">
                        <div className="flex-col p-[28px]  text-center items-center ">
                            <h1 className="text-[1.9rem] font-abel font-semibold leading-[30px] text-center mb-[12px]">Expense Manager</h1>
                            <h3 className="text-[0.9rem] font-normal leading-[30px] mb-[20px] font-poppins text-justify">Expense Manager helps you to understand your source of financial strain</h3>
                        </div>
                    </Link>
                </span>

                <span className="border-solid border-black max-w-[400px] border-[1px] rounded-[10px] hover:scale-[1.05] hover:bg-black hover:text-white hover:ease-in duration-300">
                    <Link to="#">
                        <div className="flex-col p-[28px]  text-center items-center ">
                            <h1 className="text-[1.9rem] font-abel font-semibold leading-[30px] text-center mb-[12px]">Budget Analyzer</h1>
                            <h3 className="text-[0.9rem] font-normal leading-[30px] mb-[20px] font-poppins text-justify">A budget analyzer provides a quick overview of your financial health and spending habits.</h3>
                        </div>
                    </Link>
                </span>

                <span className="border-solid border-black max-w-[400px] border-[1px] rounded-[10px] hover:scale-[1.05] hover:bg-black hover:text-white hover:ease-in duration-300">
                    <Link to="#">
                        <div className="flex-col p-[28px]  text-center items-center ">
                            <h1 className="text-[1.9rem] font-abel font-semibold leading-[30px] text-center mb-[12px]">Digital Wallet</h1>
                            <h3 className="text-[0.9rem] font-normal leading-[30px] mb-[20px] font-poppins text-justify">Carry your money around with you. Without a heavy wallet</h3>
                        </div>
                    </Link>
                </span>

                <span className="border-solid border-black max-w-[400px] border-[1px] rounded-[10px] hover:scale-[1.05] hover:bg-black hover:text-white hover:ease-in duration-300">
                    <Link to="#">
                        <div className="flex-col p-[28px]  text-center items-center ">
                            <h1 className="text-[1.9rem] font-abel font-semibold leading-[30px] text-center mb-[12px]">Fintech support</h1>
                            <h3 className="text-[0.9rem] font-normal leading-[30px] mb-[20px] font-poppins text-justify">Committed to 24x7 uptime and extensive financial services</h3>
                        </div>
                    </Link>
                </span>
            </div>
        </div>
  )
}
