<template>
  <div class="row" v-if="notifications.length">
    <div class="col-lg-12">
        <b-alert
          v-for="notification in notifications" :key="notification"
          v-bind:class="getVariant(notification)"
          @dismissible="notification.dismissible"
          show
          @dismissed="dismiss(notification)"
        >
          {{notification.message}}
        </b-alert>
    </div>
  </div>
</template>

<script>
import Notification from '../js/notifications'
import {actionTypes} from '../store/module.notification'

export default {
  name: 'notification',
  data () {
    return {
      title: 'Clustercode WebAdmin UI'
    }
  },
  computed: {
    notifications () {
      return this.$store.getters.getNotifications
    }
  },
  methods: {
    getVariant (notification) {
      return {
        'alert-danger': notification.level === Notification.LEVEL.ERROR,
        'alert-warning': notification.level === Notification.LEVEL.WARN,
        'alert-success': notification.level === Notification.LEVEL.SUCCESS,
        'alert-info': notification.level === Notification.LEVEL.INFO
      }
    },
    dismiss (notification) {
      this.$store.dispatch(actionTypes.CLEAR, notification)
    }
  }
}
</script>
