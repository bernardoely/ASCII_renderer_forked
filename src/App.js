import React, { useLayoutEffect } from 'react'
import { Logo } from '@pmndrs/branding'
import styled from 'styled-components'
import Canvas from './Canvas'
import { Gradient } from './lib/Gradient'

export default function Overlay() {
  useLayoutEffect(() => {
    const gradient = new Gradient()
    gradient.initGradient('#gradient-canvas')
  }, [])

  return (
    <Main>
      <canvas id="gradient-canvas" data-transition-in />
      <Menu>
        <Logo color="#f7057e" />
        <div>
          <p>SECRET TEACHINGS OF ALL AGES</p>
          <p>30/11/22</p>
        </div>
      </Menu>
      <ContentContainer>
        <Content>
          <p>MODUS OPERANDI FOR THE INVOCATION OF SPIRITS</p>
          <h2>The Invocation—</h2>
          <h1>Behold the sign and the very Hallowed Names of God full of power. Obey the power of this our pentacle;</h1>
          <h3>The Complete Book of Magic Science</h3>
        </Content>
      </ContentContainer>
      <CanvasContainer>
        <Canvas />
      </CanvasContainer>
    </Main>
  )
}

const Main = styled.main`
  position: relative;
  display: flex;
  flex-direction: row;
  width: 100%;
  height: 100%;
  @media only screen and (max-width: 1200px) {
    flex-direction: column;
  }
`

const CanvasContainer = styled.div`
  position: relative;
  flex: 1 1 0;
  min-width: 0;
  min-height: 0;
  padding-right: 4em;

  @media only screen and (max-width: 1200px) {
    padding-right: 0;
    order: -1;
  }
`

const ContentContainer = styled.div`
  flex: 1 1 0;
  min-width: 0;
  min-height: 0;
  display: flex;
  flex-direction: column;
  margin-top: 14em;
  @media only screen and (max-width: 1200px) {
    margin-top: 0;
  }
`

const Menu = styled.div`
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  padding: 4em;

  > svg {
    width: 64px;
  }

  > div {
    text-align: right;
    font-size: 0.8rem;
    width: 100px;
    font-weight: bold;
  }

  @media only screen and (max-width: 1200px) {
    padding: 2em;
  }

  @media only screen and (max-width: 600px) {
    > svg {
      width: 44px;
    }
  }
`

const Content = styled.div`
  flex: 1;
  padding-left: 4em;

  h2 {
    color: #f7057e;
    font-size: 4rem;
    margin-top: 1.2em;
    padding: 0;
    line-height: 0;
    margin-bottom: 1.2em;
    white-space: nowrap;
  }

  h3 {
    float: right;
    text-align: right;
    width: 100px;
    font-size: 0.8rem;
  }

  h1 {
    font-size: 3.3rem;
    line-height: 3.8rem;
  }

  p {
    font-size: 0.8rem;
    width: 200px;
  }

  @media only screen and (max-width: 1200px) {
    width: 100%;
    padding-right: 2em;
    padding-left: 2em;
    h1 {
      font-size: 2.3rem;
      line-height: 2.8rem;
    }

    h2 {
      font-size: 2.3rem;
      line-height: 2.3rem;
      margin-bottom: 0.8rem;
    }
  }

  @media only screen and (max-width: 800px) {
    h1 {
      font-size: 1.6rem;
      line-height: 2rem;
    }

    h2 {
      font-size: 1.6rem;
      line-height: 1.6rem;
    }
  }

  @media only screen and (max-width: 600px) {
    h1 {
      font-size: 1.3rem;
      line-height: 1.8rem;
    }

    h2 {
      font-size: 1.3rem;
      line-height: 1.3rem;
    }
  }
`
