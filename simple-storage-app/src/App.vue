<script setup lang="ts">
import { onMounted } from 'vue'
import { ethers } from 'ethers'
import type { Signer, AbstractProvider } from 'ethers'

let signer: Signer | null = null
let provider: AbstractProvider | null = null

async function initEthConfig() {
  const _window = window as any
  if (_window.ethereum == null) {
    provider = ethers.getDefaultProvider('sepolia', {
      infura: 'c5f492cc1f1e481cbe3a8ce88bcaf396'
    })
  } else {
    const browserProvider = new ethers.BrowserProvider(_window.ethereum)
    provider = browserProvider
    signer = await browserProvider.getSigner()
  }
}

onMounted(async () => {
  await initEthConfig()
})
</script>

<template>
  <header>
    <img alt="Vue logo" class="logo" src="@/assets/logo.svg" width="125" height="125" />
  </header>
</template>

<style scoped>
header {
  line-height: 1.5;
  max-height: 100vh;
}

.logo {
  display: block;
  margin: 0 auto 2rem;
}

</style>
