
export default function hero() {

    return (
    <>
        <div className="text-white bg-black h-[90vh] max-xl:flex-col flex justify-between items-center py-[10px] px-[60px] relative overflow-hidden">
            <div className="">
                <h1 className=" text-[4.4rem] font-semibold leading-[65px] mb-[20px]">
                    Your next gen <br /> <span className="text-[#0000ff]">Finance</span> Agent
                </h1>
                <h3 className="text-[1.6rem] font-normal leading-[30px] mb-[20px] font-abel text-justify">
                    Buy stocks, invest in fixed deposits, and learn how to handle your
                    money. Purchase equities, put money into mutual funds, and develop
                    good money management skills.
                </h3>

                <button className=" font-medium inline-flex justify-center items-center my-[20px] py-[10px] pl-[20px] pr-[10px] text-[1.1rem] border-none bg-[#0000ff] text-white rounded-[20px] mr-[10px] hover:scale-[1.05] hover:bg-[#333ed385]">
                        Get started
                    <img className="ml-[4px] inline relative items-center rotate-90 w-[20px] h-[20px] text-white"
                    width="32"
                    height="32"
                    src="https://img.icons8.com/windows/32/ffffff/up-left-arrow.png"
                    alt="up-left-arrow"
                    />
                </button>

                <button className="ml-[10px] inline-flex justify-center items-center bg-transparent border-[1px] border-solid border-white text-[#f5deb3] rounded-[20px] pl-[20px] pr-[10px] py-[10px] my-[20px] hover:scale-[1.05] hover:bg-[#333ed385]">
                    Contact sales
                    <img className="ml-[4px] inline relative items-center rotate-90 w-[20px] h-[20px] text-white"
                    width="32"
                    height="32"
                    src="https://img.icons8.com/windows/32/ffffff/up-left-arrow.png"
                    alt="up-left-arrow"
                    />
                </button>
            </div>
            <div className="rightmainbox">
                <img className=" " src="/credit-cards.png" />
            </div>
        </div>
    </>
  )
}
