export const mutationTypes = {
  ADD_NOTIFICATION: 'addNotification',
  CLEAR_NOTIFICATION: 'clearNotification',
  CLEAR_ALL: 'clearAll',
  CLEAR_BY_KEY: 'clearNotificationsByKey'
}

export const actionTypes = {
  ADD: 'add',
  ADD_WITH_TIMEOUT: 'addWithTimeout',
  CLEAR: 'clear'
}

export const getters = {
  getNotifications (state) {
    return state.list
  }
}

const util = {
  containsNotificationByKey (state, notificationKey) {
    if (!notificationKey || state.list.length === 0) return false
    return !state.list.every(element => element.key !== notificationKey)
  },
  containsNotification (state, notification) {
    if (!notification || state.list.length === 0) return false
    return (state.list.indexOf(notification) > -1)
  }
}

export const actions = {
  clear ({commit, state}, notification) {
    if (!notification) {
      commit(mutationTypes.CLEAR_ALL)
    } else if (typeof notification === 'string' && util.containsNotificationByKey(state, notification)) {
      commit(mutationTypes.CLEAR_BY_KEY, notification)
    } else if (util.containsNotification(state, notification)) {
      commit(mutationTypes.CLEAR_NOTIFICATION, notification)
    }
  },
  add ({commit, state}, notification) {
    if (!notification || util.containsNotificationByKey(state, notification.key)) return
    commit(mutationTypes.ADD_NOTIFICATION, notification)
  },
  addWithTimeout ({commit, state}, notification) {
    if (!notification || util.containsNotificationByKey(state, notification.key)) return
    commit(mutationTypes.ADD_NOTIFICATION, notification)
    setTimeout(() => {
      commit(mutationTypes.CLEAR_NOTIFICATION, notification)
    }, 5000)
  }
}

export const mutations = {
  addNotification (state, notification) {
    state.list.push(notification)
  },
  clearNotificationsByKey (state, key) {
    let arr = state.list
    let notification
    for (let i = arr.length - 1; i >= 0; i--) {
      notification = arr[i]
      if (notification.key === key) {
        arr.splice(i, 1)
      }
    }
  },
  clearNotification (state, notification) {
    let index = state.list.indexOf(notification)
    if (index > -1) {
      state.list.splice(index, 1)
    }
  },
  clearAll (state) {
    state.list = []
  }
}

const NotificationModule = {
  state: {
    list: []
  },
  actions,
  mutations,
  getters
}

export default NotificationModule
