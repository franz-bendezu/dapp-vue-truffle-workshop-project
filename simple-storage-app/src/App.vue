<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { ethers } from 'ethers'
import type { Signer, AbstractProvider } from 'ethers'
import SimpleStorage from '@/assets/SimpleStorage.json'

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

const contractAddress = '0x4F2Aad93c8B56BD89CBB55a88F87f377deb2ab25'

const getNumber = ref('')
async function numberGet() {
  try {
    const contract = new ethers.Contract(contractAddress, SimpleStorage.abi, provider)
    const result = await contract.get()
    getNumber.value = result.toString()
  } catch (error) {
    console.error('Error al obtener el número:', error)
  }
}

const newData = ref(0)
async function numberSet() {
  console.log(newData.value)
  try {
    const contract = new ethers.Contract(contractAddress, SimpleStorage.abi, signer)
    const transaction = await contract.set(newData.value)
    await transaction.wait()
    // Update state or show success message
  } catch (error) {
    console.error('Error setting number:', error)
  }
}

/* function handleChange(event: Event){
  const target = event.target as HTMLInputElement
  newData.value = target.value
}
*/
</script>

<template>
  <header>
    <img alt="Vue logo" class="logo" src="@/assets/logo.svg" width="125" height="125" />
  </header>
  <div class="card">
    <h2 class="subtitle">Obtener tu uint256</h2>
    <form class="form" @submit.prevent="numberGet">
      <button class="button" type="submit">Obtener</button>
      <label>
        Tu uint256:
        <input class="input" type="text" :value="getNumber" readonly />
      </label>
    </form>

    <h2 class="subtitle">Establecer tu uint256</h2>
    <form class="form" @submit.prevent="numberSet" >
      <label>
        Establece tu uint256: 
        <!-- {{ newData  }} -->
        <!-- 
          :value
          @input
         -->
         <!-- 
          <input class="input" type="text" v-bind:value="newData" v-on:input="handleChange($event)" />
          <input class="input" type="text" :value="newData" @input="handleChange($event)" />
          -->
        <input class="input" type="text" v-model.number="newData" />
      </label>
      <button class="button" type="submit">Confirmar</button>
    </form>
  </div>
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

.card {
  max-width: 500px;
  min-height: 50vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.form {
  height: 20vh;
  display: flex;
  justify-content: space-evenly;
  flex-direction: column;
}

.button {
  background-color: #00d1b2;
  border: none;
  border-radius: 5px;
  color: white;
  font-weight: bold;
  cursor: pointer;
  width: 100%;
}
</style>
