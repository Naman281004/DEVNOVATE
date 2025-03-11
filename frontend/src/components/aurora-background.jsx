import React from "react";
import { motion } from "framer-motion";
import { cn } from "../../utils/cn";

export const AuroraBackground = ({
  className,
  children,
  showRadialGradient = true,
}) => {
  return (
    <>
      <div
        className={cn(
          "fixed inset-0 w-full bg-black overflow-hidden",
          className
        )}
      >
        <div className="absolute inset-0 z-0 opacity-50">
          <div className="absolute inset-0 z-0">
            <div className="absolute top-0 left-0 right-0 bottom-0">
              <motion.div
                initial={{ opacity: 0.5, width: "25%", height: "25%", borderRadius: "100%" }}
                animate={{
                  opacity: [0.5, 0.8, 0.5],
                  width: ["25%", "30%", "25%"],
                  height: ["25%", "30%", "25%"],
                  borderRadius: ["100%", "100%", "100%"],
                }}
                transition={{
                  duration: 5,
                  repeat: Infinity,
                  ease: "easeInOut",
                }}
                className="absolute top-[calc(20%-10%)] right-[calc(30%-10%)] bg-purple-500 blur-[120px]"
              />
              <motion.div
                initial={{ opacity: 0.5, width: "30%", height: "30%", borderRadius: "100%" }}
                animate={{
                  opacity: [0.5, 0.8, 0.5],
                  width: ["30%", "35%", "30%"],
                  height: ["30%", "35%", "30%"],
                  borderRadius: ["100%", "100%", "100%"],
                }}
                transition={{
                  duration: 7,
                  repeat: Infinity,
                  ease: "easeInOut",
                }}
                className="absolute top-[calc(40%-10%)] left-[calc(40%-10%)] bg-blue-500 blur-[120px]"
              />
              <motion.div
                initial={{ opacity: 0.5, width: "20%", height: "20%", borderRadius: "100%" }}
                animate={{
                  opacity: [0.5, 0.8, 0.5],
                  width: ["20%", "25%", "20%"],
                  height: ["20%", "25%", "20%"],
                  borderRadius: ["100%", "100%", "100%"],
                }}
                transition={{
                  duration: 6,
                  repeat: Infinity,
                  ease: "easeInOut",
                }}
                className="absolute top-[calc(80%-10%)] left-[calc(20%-10%)] bg-pink-500 blur-[120px]"
              />
              <motion.div
                initial={{ opacity: 0.5, width: "20%", height: "20%", borderRadius: "100%" }}
                animate={{
                  opacity: [0.5, 0.8, 0.5],
                  width: ["20%", "25%", "20%"],
                  height: ["20%", "25%", "20%"],
                  borderRadius: ["100%", "100%", "100%"],
                }}
                transition={{
                  duration: 8,
                  repeat: Infinity,
                  ease: "easeInOut",
                }}
                className="absolute top-[calc(50%-10%)] right-[calc(10%-10%)] bg-cyan-500 blur-[120px]"
              />
            </div>
          </div>
        </div>
        {showRadialGradient && (
          <div className="absolute inset-0 z-0 bg-black [mask-image:radial-gradient(transparent,white)] opacity-90" />
        )}
      </div>
      <div className="relative z-10 min-h-screen w-full">
        {children}
      </div>
    </>
  );
}; 