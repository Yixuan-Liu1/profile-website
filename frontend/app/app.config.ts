export default defineAppConfig({
  global: {
    picture: {
      dark: '/images/profile.png', // replace with your own image
      light: '/images/profile.png',
      alt: 'Haoming Luo profile picture'
    },
    meetingLink: 'https://cal.com/haomingluo', // update when ready
    email: 'haomingluo@gmail.com', // or your custom domain email
    available: true
  },

  ui: {
    colors: {
      primary: 'blue',
      neutral: 'neutral'
    },
    pageHero: {
      slots: {
        container: 'py-18 sm:py-24 lg:py-32',
        title: 'mx-auto max-w-xl text-pretty text-3xl sm:text-4xl lg:text-5xl',
        description:
          'mt-2 text-md mx-auto max-w-2xl text-pretty sm:text-md text-muted'
      }
    }
  },

  footer: {
    credits: `© ${new Date().getFullYear()} Haoming Luo.`,
    colorMode: true,
    links: [
      {
        icon: 'i-simple-icons-linkedin',
        to: 'https://linkedin.com/in/haomingluo', // update
        target: '_blank',
        'aria-label': 'LinkedIn'
      },
      {
        icon: 'i-simple-icons-github',
        to: 'https://github.com/jasonluo2024', // update
        target: '_blank',
        'aria-label': 'GitHub'
      },
      {
        icon: 'i-simple-icons-discord',
        to: 'https://discord.com/users/haomingluo',
        target: '_blank',
        'aria-label': 'Discord'
     }
    ]
  }
})
