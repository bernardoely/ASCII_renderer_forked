import { useRef, useEffect } from 'react'
import { Canvas, useFrame, useThree } from '@react-three/fiber'
import { AsciiRenderer } from '@react-three/drei'
import styled from 'styled-components'

export default function App() {
  return (
    <StyledCanvas className="canvas" frameloop="always" dpr={[1, 2]}>
      <color attach="background" args={['black']} />
      <spotLight position={[10, 10, 10]} angle={0.15} penumbra={1} />
      <pointLight position={[-10, -10, -10]} />
      <Torusknot />
      <AsciiRenderer 
        fgColor="white" 
        bgColor="transparent"
        resolution={0.2}
        charactersPerLine={60}
        characters=" .:-+*=%@#" 
        renderIndex={1}
      />
    </StyledCanvas>
  )
}

const StyledCanvas = styled(Canvas)`
  @media only screen and (max-width: 1200px) {
    margin-top: 2.5em !important;
  }
`

function Torusknot(props) {
  const ref = useRef()
  const viewport = useThree((state) => state.viewport)
  
  // Optimize animation for higher FPS
  useFrame((state, delta) => {
    ref.current.rotation.x += delta * 0.5
    ref.current.rotation.y += delta * 0.5
  })
  
  return (
    <mesh scale={Math.min(viewport.width, viewport.height) / 5} {...props} ref={ref}>
      <torusKnotGeometry args={[1, 0.2, 128, 32]} />
      <meshStandardMaterial color="red" />
    </mesh>
  )
}
