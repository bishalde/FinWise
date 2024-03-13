import { useRef } from "react"
import { useLocation } from "react-router-dom"

export default function Backdrop() {
    const back = useRef(null)
    const loc = useLocation()
    return (
    <div className="w-[100%] h-[100%] fixed -z-1 text-white">
            <div ref={back} className="w-[100%] h-[100%] backdrop-blur-[4px] backdrop-brightness-[0.55] z-0 fixed"/>
            {(loc.pathname!="/" ) &&
                <span>
                    <svg width="1920" height="1080" viewBox="0 0 1920 1080" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <g clipPath="url(#clip0_2_4044)">
                        <rect width="1920" height="1080" fill="#010725"/>
                        <g filter="url(#filter0_f_2_4044)">
                        <path d="M960 1122.88C1266.47 1122.88 1514.92 896.155 1514.92 616.481C1514.92 336.807 1266.47 110.086 960 110.086C653.526 110.086 405.079 336.807 405.079 616.481C405.079 896.155 653.526 1122.88 960 1122.88Z" fill="#010D50"/>
                        </g>
                        </g>
                        <defs>
                        <filter id="filter0_f_2_4044" x="5.0791" y="-289.914" width="1909.84" height="1812.79" filterUnits="userSpaceOnUse" colorInterpolationFilters="sRGB">
                        <feFlood floodOpacity="0" result="BackgroundImageFix"/>
                        <feBlend mode="normal" in="SourceGraphic" in2="BackgroundImageFix" result="shape"/>
                        <feGaussianBlur stdDeviation="200" result="effect1_foregroundBlur_2_4044"/>
                        </filter>
                        <clipPath id="clip0_2_4044">
                        <rect width="1920" height="1080" fill="white"/>
                        </clipPath>
                        </defs>
                    </svg>
                </span>
            }

            
        </div>
  )
}
