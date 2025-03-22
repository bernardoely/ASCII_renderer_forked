import React, { useLayoutEffect } from 'react'
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
        <div>xiru.dev</div>
        <div>
          <p>ai dev</p>
          <p>modernization boutique</p>
        </div>
      </Menu>
      <ContentContainer>
        <Content>
          <p>WE ARE REPLACING HUMANS</p>
          <h2>Nothing personal—</h2>
          <h1>It  is  happening now.</h1>
          <h3>We will thrive together.</h3>
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
    padding-top: 2.5em;  
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
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  display: flex;
  justify-content: space-between;
  padding: 4em;

  > div:first-child {
    font-size: 2rem;
    font-weight: bold;
    color: #f7057e;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
  }

  > div {
    text-align: right;
    font-size: 0.8rem;
    line-height: 1.3;

    > p:first-child {
      font-weight: bold;
    }

    > p:last-child {
      opacity: 0.5;
    }
  }

  @media only screen and (max-width: 600px) {
    > div:first-child {
      font-size: 1.5rem;
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
