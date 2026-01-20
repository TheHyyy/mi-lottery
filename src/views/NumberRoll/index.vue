<script setup lang="ts">
import { computed, onBeforeUnmount, onMounted, ref, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'

type DigitStatus = 'rolling' | 'stopped'

interface HistoryItem {
    value: string
    at: number
}

const router = useRouter()
const route = useRoute()

const digitCount = ref<3 | 4>(3)
const digits = ref<number[]>([0, 0, 0])
const statuses = ref<DigitStatus[]>(['stopped', 'stopped', 'stopped'])
const timers = ref<Array<number | null>>([null, null, null])

const history = ref<HistoryItem[]>([])

const isRollingAny = computed(() => statuses.value.includes('rolling'))
const isAllStopped = computed(() =>
    statuses.value.every(s => s === 'stopped'),
)

const displayValue = computed(() => digits.value.join(''))

function ensureArrayLength<T>(
    arr: T[],
    length: number,
    fillFactory: () => T,
): T[] {
    const next = arr.slice(0, length)
    while (next.length < length) next.push(fillFactory())
    return next
}

function clearTimer(index: number) {
    const id = timers.value[index]
    if (id != null) {
        window.clearInterval(id)
        timers.value[index] = null
    }
}

function clearAllTimers() {
    for (let i = 0; i < timers.value.length; i++) {
        clearTimer(i)
    }
}

function rollDigit(index: number) {
    clearTimer(index)
    statuses.value[index] = 'rolling'
    timers.value[index] = window.setInterval(() => {
        digits.value[index] = Math.floor(Math.random() * 10)
    }, 45)
}

function stopDigit(index: number) {
    if (statuses.value[index] !== 'rolling') {
        return
    }
    clearTimer(index)
    statuses.value[index] = 'stopped'

    if (isAllStopped.value) {
        history.value.unshift({ value: displayValue.value, at: Date.now() })
        history.value = history.value.slice(0, 10)
    }
}

function startRolling() {
    for (let i = 0; i < digitCount.value; i++) rollDigit(i)
}

function stopNext() {
    const idx = statuses.value.findIndex(s => s === 'rolling')
    if (idx === -1) {
        return
    }
    stopDigit(idx)
}

function resetAll() {
    clearAllTimers()
    digits.value = Array.from({ length: digitCount.value }, () => 0)
    statuses.value = Array.from({ length: digitCount.value }, () => 'stopped')
    timers.value = Array.from({ length: digitCount.value }, () => null)
}

function toggleStartOrStopNext() {
    if (!isRollingAny.value) {
        startRolling()
    }
    else {
        stopNext()
    }
}

function handleKeydown(e: KeyboardEvent) {
    if (e.key === ' ' || e.code === 'Space') {
        e.preventDefault()
        toggleStartOrStopNext()
    }
    else if (e.key === 'Enter') {
        e.preventDefault()
        if (!isRollingAny.value) {
            startRolling()
        }
    }
    else if (e.key.toLowerCase() === 'r') {
        e.preventDefault()
        resetAll()
    }
    else if (e.key === 'Escape') {
        // 如果本页不是首页，Esc 快速回首页
        if (route.path.includes('/number-roll')) {
            router.push('/log-lottery')
        }
    }
}

watch(digitCount, (next) => {
    digits.value = ensureArrayLength(digits.value, next, () => 0)
    statuses.value = ensureArrayLength(statuses.value, next, () => 'stopped')
    timers.value = ensureArrayLength(timers.value, next, () => null)
    resetAll()
})

onMounted(() => {
    window.addEventListener('keydown', handleKeydown)
})

onBeforeUnmount(() => {
    window.removeEventListener('keydown', handleKeydown)
    clearAllTimers()
})
</script>

<template>
  <div
    class="w-full h-full flex flex-col bg-gradient-to-b from-slate-950 via-slate-900 to-slate-950 text-slate-100"
  >
    <header class="px-6 pt-6 flex items-center justify-between">
      <div class="flex items-center gap-3">
        <button class="btn btn-sm" @click="router.push('/log-lottery')">
          返回主页
        </button>
        <div class="opacity-70 text-sm">
          空格：开始/停下一位｜Enter：开始｜R：重置
        </div>
      </div>

      <div class="flex items-center gap-2">
        <div class="join">
          <button
            class="btn btn-sm join-item"
            :class="digitCount === 3 ? 'btn-primary' : ''"
            @click="digitCount = 3"
          >
            3 位
          </button>
          <button
            class="btn btn-sm join-item"
            :class="digitCount === 4 ? 'btn-primary' : ''"
            @click="digitCount = 4"
          >
            4 位
          </button>
        </div>
        <button class="btn btn-sm btn-ghost" @click="history = []">
          清空记录
        </button>
      </div>
    </header>

    <main class="flex-1 flex flex-col items-center justify-center px-6">
      <div class="digits-wrap">
        <button
          v-for="(d, idx) in digits"
          :key="idx"
          class="digit-card"
          :class="
            statuses[idx] === 'rolling'
              ? 'digit-card-rolling'
              : 'digit-card-stopped'
          "
          @click="statuses[idx] === 'rolling' ? stopDigit(idx) : rollDigit(idx)"
        >
          {{ d }}
        </button>
      </div>

      <div class="mt-10 flex items-center gap-3">
        <button
          class="btn btn-lg btn-primary"
          :disabled="isRollingAny"
          @click="startRolling"
        >
          开始
        </button>
        <button
          class="btn btn-lg btn-accent"
          :disabled="!isRollingAny"
          @click="stopNext"
        >
          停下一位
        </button>
        <button class="btn btn-lg" @click="resetAll">
          重置
        </button>
      </div>

      <div class="mt-6 opacity-80 text-sm">
        点击某一位：滚动/停止（手动控制）
      </div>
    </main>

    <aside class="px-6 pb-6">
      <div class="flex items-center justify-between">
        <div class="text-sm opacity-70">
          当前结果：<span class="font-mono">{{ displayValue }}</span>
        </div>
        <div class="text-sm opacity-70">
          记录：{{ history.length }}/10
        </div>
      </div>

      <div
        v-if="history.length"
        class="mt-3 grid grid-cols-2 md:grid-cols-5 gap-2"
      >
        <div
          v-for="item in history"
          :key="item.at"
          class="px-3 py-2 rounded-lg bg-slate-200/10 border border-white/10 font-mono text-center"
        >
          {{ item.value }}
        </div>
      </div>
    </aside>
  </div>
</template>

<style scoped>
.digits-wrap {
 display: flex;
 gap: 18px;
}

.digit-card {
 width: clamp(110px, 12vw, 180px);
 height: clamp(150px, 18vw, 240px);
 border-radius: 18px;
 font-family:
 ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, "Liberation Mono",
 "Courier New", monospace;
 font-size: clamp(72px, 9vw, 140px);
 line-height: 1;
 display: inline-flex;
 align-items: center;
 justify-content: center;
 user-select: none;
 transition:
 transform 120ms ease,
 background-color 120ms ease,
 box-shadow 120ms ease;
 border: 1px solid rgba(255, 255, 255, 0.12);
 background: rgba(255, 255, 255, 0.06);
}

.digit-card:hover {
 transform: translateY(-2px);
}

.digit-card-rolling {
 box-shadow:
 0 0 0 2px rgba(59, 130, 246, 0.25),
 0 16px 40px rgba(0, 0, 0, 0.45);
}

.digit-card-stopped {
 box-shadow:
 0 0 0 1px rgba(255, 255, 255, 0.1),
 0 14px 32px rgba(0, 0, 0, 0.4);
}
</style>
