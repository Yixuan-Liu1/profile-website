<script setup lang="ts">
import type { IndexCollectionItem } from "@nuxt/content";

defineProps<{
  page: IndexCollectionItem;
}>();
</script>


<template>
  <UMarquee
    v-if="page?.certifications?.items?.length"
    :ui="{ root: '[--duration:35s]' }"
    class="py-2"
  >
    <div class="flex items-center gap-8">
      <div
        v-for="(cert, i) in page.certifications.items"
        :key="i"
        class="flex flex-col items-center gap-1 px-4"
      >
        <img
          :src="cert.image"
          :alt="cert.name"
          class="h-20 w-auto object-contain"
        />

        <span class="text-xs text-muted text-center">
          {{ cert.name }}
        </span>
      </div>
    </div>
  </UMarquee>
</template>
