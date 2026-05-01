<script setup lang="ts">
import type { IndexCollectionItem } from "@nuxt/content";

defineProps<{
  page: IndexCollectionItem;
}>();
</script>

<template>
  <UPageSection
    :title="page.experience.title"
    :ui="{
      container: 'py-2 w-full max-w-none px-2',
      title: 'text-left text-2xl font-semibold',
      description: 'text-left',
    }"
  >
    <template #description>
      <div class="flex flex-col gap-6">
        <Motion
          v-for="(experience, index) in page.experience.items"
          :key="index"
          :initial="{ opacity: 0, transform: 'translateY(20px)' }"
          :while-in-view="{ opacity: 1, transform: 'translateY(0)' }"
          :transition="{ delay: 0.2 * index }"
          :in-view-options="{ once: true }"
          class="flex flex-col gap-3 border-b border-gray-200 pb-6"
        >
          <!-- Header -->
          <div
            class="flex flex-col sm:flex-row sm:justify-between sm:items-start gap-2"
          >
            <!-- LEFT -->
            <div class="flex flex-col text-left">
              <!-- Company -->
              <div class="flex items-center gap-2 font-semibold text-base">
                <img
                  :src="experience.company.logo"
                  :alt="experience.company.name"
                  class="h-5 w-auto object-contain rounded-sm bg-white px-1"
                />
                <span :style="{ color: experience.company.color }">
                  {{ experience.company.name }}
                </span>
              </div>

              <!-- Position -->
              <span class="text-sm text-muted">
                {{ experience.position }}
              </span>
            </div>

            <!-- RIGHT (DATE) -->
            <span class="text-sm text-muted whitespace-nowrap">
              {{ experience.date }}
            </span>
          </div>

          <!-- Highlights -->
          <ul class="list-disc pl-5 text-sm text-muted space-y-1 text-left">
            <li v-for="(item, i) in experience.highlights" :key="i">
              {{ item }}
            </li>
          </ul>

          <!-- Tech stack -->
          <div class="flex flex-wrap gap-2 pl-5">
            <UBadge
              v-for="(tech, i) in experience.tech"
              :key="i"
              size="xs"
              variant="soft"
            >
              {{ tech }}
            </UBadge>
          </div>
        </Motion>
      </div>
    </template>
  </UPageSection>
</template>

<style scoped>
</style>
