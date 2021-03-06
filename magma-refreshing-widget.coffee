window.MagmaRefreshingWidget = 
  refreshSec: 60 * 10
  attached: () ->
    @_reloadLoop()
    window.addEventListener('resize', (=> @_onResize()))
    @_onResize()

  _reloadLoop: () ->
    @_changeWhenVisible =>
      @periodicReload()
      setTimeout((=> @_reloadLoop()), @refreshSec * 1000) if @refreshSec

  _lastWidgetSize: [0, 0]
  _onResize: () ->
    @_changeWhenVisible =>
      # currently this calls even if our element hasn't changed size,
      # but that would be nice to avoid
      
      # broken: this fires all the time still
      return unless @$.top
      
      newSize = [@$.top.offsetWidth, @$.top.offsetHeight]
      if @_lastWidgetSize[0] != newSize[0] or @_lastWidgetSize[1] != newSize[1]
        @resize(newSize[0], newSize[1])
        @_lastWidgetSize = newSize
    # Todo: it would be cool to get a callback when the resize is
    # done, so we don't sent overlapping calls during a smooth window
    # transition. Then, we should use css transforms to scale the
    # contents during such a transition so they appear to scale right
    # until the new contents are ready.

  _changeWhenVisible: (cb) ->
    if (document.hidden ||
        document.mozHidden ||
        document.msHidden ||
        document.webkitHidden)
      setTimeout((=> @_changeWhenVisible(cb)), 5000)
      return
    cb()

  # called every refreshSec (or less if tab is hidden)
  periodicReload: () ->
    console.log("magma-refreshing-widget: periodicReload", this.impl)

  # called when the widget has resized
  resize: (w, h) ->
    console.log("magma-refreshing-widget: resize", w, h)

    