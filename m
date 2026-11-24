Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0794A606A339
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ndw2AIjM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B4F410E364;
	Tue, 24 Nov 2026 12:26:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19BE910E364
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:25:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C5B624309D;
 Tue, 24 Nov 2026 12:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BC91F000CF;
 Tue, 24 Nov 2026 12:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795523154;
 bh=4lLhFs2t5M9xhN1oaMSM/jExOmlugRqRZD2WX4w/xwU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ndw2AIjMTiRRgm8ancwONdsc9m1tf0f1TinUCe0M25VxpMzKvV5zffyhZaOEk1nEz
 l0yLti6IwO/bVJGQPcv07ntLCvzxfrL26JUNPDfkjKuAnOY3XGwtiN0Z+UqwGX/kht
 3SXqdbhbVjyJgn5n0un7Z4cHUSw7s5LJl/QY8z0e1sXvyxT1A3FhhiUNlL/khwzYtE
 zq8wh+sSD1qAI08g6irDJNjO121Z+HsfF0l2OGu7fKJhmT4kHjGnJKUNY1mUfCg9eL
 v3OgQhZVrOSEf6N7iHhiXwUD9e2VTNw/x6oGfnkpYAGJYpUCWikbuKC1A4NmeihJZu
 Y0gf+fsDiZCDQ==
Message-ID: <sashiko-outbox-231133@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/5] drm/bridge: trilinear: add the DPTX core and
 build glue
To: "Luo Liu" <Luo.Liu@cixtech.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261124120114.3273161-5-Luo.Liu@cixtech.com>
References: <20261124120114.3273161-1-Luo.Liu@cixtech.com>
 <20261124120114.3273161-5-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:25:53 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 12 potential
issues to consider:
- [High] drm/bridge: trilinear: stale connect state and lost HPD in
  dptx_detect()
- [Medium] drm/bridge: trilinear: missing abort return in
  dptx_hpd_event_work_func()
- [Medium] drm/bridge: trilinear: unhandled zero of_irq_get() return in
  dptx_get_irq()
- [Medium] drm/bridge: trilinear: device-wide poll toggling in
  dptx_pm_prepare()
- [Medium] drm/bridge: trilinear: missing host_enable() rollback in
  dptx_host_reset()
- [Medium] drm/bridge: trilinear: unlocked AUX access in
  dptx_replay_deferred_hotplug()
- [Medium] drm/bridge: trilinear: mixed workqueues used for
  hpd_event_work
- [Medium] drm/bridge: trilinear: suspend race with dptx_host_resume()
  in dptx_core
- [Medium] drm/bridge: trilinear: unabortable 10s poll in
  dptx_wait_phy_dp_mode()
- [Medium] drm/bridge: trilinear: stale force_hpd state across suspend
  and disconnect
- [Medium] drm/bridge: trilinear: race on irq_suspended and suspend
  state in dptx_core
- [Low] drm/bridge: trilinear: dptx_mode_configure() succeeds at
  downshift floor
--

commit 47f9a9a601a0b7e7e57799e4fe3c7bc053e417ba
Author: Luo Liu <Luo.Liu@cixtech.com>

drm/bridge: trilinear: add the DPTX core and build glue

This commit adds the core DisplayPort transmitter state machine, hotplug
workers, power management, and probe/build glue for the Trilinear DPTX
DRM bridge driver.

> diff --git a/drivers/gpu/drm/bridge/trilinear/dptx_core.c b/drivers/gpu/d=
rm/bridge/trilinear/dptx_core.c
> new file mode 100644
> index 0000000000000..cf0f6c13df700
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/trilinear/dptx_core.c
[ ... ]
> +static int dptx_mode_configure(struct dptx_dev *dp, int pclk, u8 bw, u8 =
bpp,
> +			       bool downshift)
> +{
> +	int max_rate =3D dp->link_max_rate;
> +	int lane_cnt;
> +	int bw_code;
> +	int link_rate;
> +
> +	if (!downshift)
> +		bw_code =3D bw;
> +	else
> +		switch (bw) {
> +		case DP_LINK_BW_8_1:
> +			bw_code =3D DP_LINK_BW_5_4;
> +			break;
> +		case DP_LINK_BW_5_4:
> +			bw_code =3D DP_LINK_BW_2_7;
> +			break;
> +		case DP_LINK_BW_2_7:
> +			bw_code =3D DP_LINK_BW_1_62;
> +			break;
> +		case DP_LINK_BW_1_62:
> +			bw_code =3D DP_LINK_BW_1_62;
> +			break;

[Severity: Low]
Should downshifting from DP_LINK_BW_1_62 return an error instead of
keeping DP_LINK_BW_1_62 and returning 0?

The inner loop in dptx_train_loop() only breaks when
dptx_mode_configure(..., true) returns a negative error, so when training
fails at 1.62 Gbps it repeats redundant link-training attempts at the
same 1.62 Gbps rate and lane count until j > 3.

[ ... ]

> +static int dptx_host_reset(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	dp->hw->ops->reset(dp->hw, true);
> +	usleep_range(10, 20);
> +	dp->hw->ops->reset(dp->hw, false);
> +
> +	ret =3D dp->hw->ops->phy_reset(dp->hw);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(100, 200);
> +	dp->hw->ops->host_enable(dp->hw, true);
> +
> +	return dp->hw->ops->phy_init(dp->hw);
> +}
> +
> +static int dptx_host_init(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	if (dp->state & DPTX_STATE_INITIALIZED)
> +		return 0;
> +
> +	ret =3D dp->hw->ops->apb_clock(dp->hw, true);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D dptx_host_reset(dp);
> +	if (ret) {
> +		dp->hw->ops->apb_clock(dp->hw, false);
> +		return ret;
> +	}

[Severity: Medium]
If phy_init() fails in dptx_host_reset(), does this leave the transmitter
enabled and hardware HPD interrupts unmasked when dptx_host_init() gates
the APB clock?

host_enable(dp->hw, true) enables the transmitter and unmasks interrupts
in DPTX_INTERRUPT_MASK.  Without rolling back via
host_enable(dp->hw, false) before apb_clock(dp->hw, false), an HPD
interrupt firing while the IRQ is active (for instance during
dptx_prepare() or dptx_host_resume()) will read MMIO registers in
dptx_irq_handler() with apb_clk disabled.

[ ... ]

> +static int dptx_handle_connect(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&dp->lock);
> +
> +	if (dp->state & DPTX_STATE_CONNECTED)
> +		return 0;
> +
> +	if (dp->state & DPTX_STATE_SUSPENDED)
> +		return 0;
> +
> +	ret =3D dptx_read_sink_caps(dp);
> +	if (!ret)
> +		dp->state |=3D DPTX_STATE_CONNECTED;
> +
> +	return ret;
> +}
> +
> +static int dptx_handle_disconnect(struct dptx_dev *dp)
> +{
> +	lockdep_assert_held(&dp->lock);
> +
> +	dp->state &=3D ~DPTX_STATE_CONNECTED;
> +
> +	return 0;
> +}

[Severity: Medium]
Does dptx_handle_disconnect() (and dptx_pm_prepare()) leave dp->force_hpd
stuck at connector_status_connected?

Once dptx_replay_deferred_hotplug() or dptx_hpd_notify() sets
dp->force_hpd =3D connector_status_connected on a USB-C port,
dptx_get_hpd_state() always returns true.  If the USB-C sink is unplugged
during system sleep, resume schedules hpd_event_work, which sees
dptx_get_hpd_state() =3D=3D true, fails DPCD reads in dptx_detect_status(),
and sets dp->status =3D connector_status_disconnected without clearing
dp->force_hpd.  Because dp->status is already disconnected, later
dptx_hpd_notify(..., connector_status_disconnected) calls also bail out on
hpd_state =3D=3D dp->status, so dptx_get_hpd_state() stays permanently true
and every later dptx_bridge_detect() call stalls on 32 failing AUX retries.

> +
> +static int dptx_detect(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	dptx_lock(dp);
> +
> +	if ((dp->state & DPTX_STATE_SUSPENDED) &&
> +	    current_work() =3D=3D &dp->hpd_event_work.work) {
> +		ret =3D -EBUSY;
> +		goto out;
> +	}
> +
> +	ret =3D dptx_host_resume(dp);
> +	if (ret)
> +		goto out;
> +
> +	if (!(dp->state & DPTX_STATE_INITIALIZED)) {
> +		dev_warn_once(dp->dev, "detect with uninitialized host\n");
> +		ret =3D -ENODEV;
> +		goto out;
> +	}
> +
> +	if (!dptx_get_hpd_state(dp)) {
> +		ret =3D -ENODEV;
> +		goto out;
> +	}
> +
> +	ret =3D dptx_handle_connect(dp);
> +
> +out:
> +	dptx_unlock(dp);
> +
> +	return ret;
> +}
> +
> +static enum drm_connector_status dptx_detect_status(struct dptx_dev *dp)
> +{
> +	enum drm_connector_status status;
> +	int ret;
> +
> +	ret =3D dptx_detect(dp);
> +	if (ret =3D=3D -EBUSY)
> +		status =3D connector_status_unknown;
> +	else if (ret)
> +		status =3D connector_status_disconnected;
> +	else
> +		status =3D connector_status_connected;
> +
> +	dptx_lock(dp);
> +	dp->status =3D status;
> +	dptx_unlock(dp);
> +
> +	return status;
> +}

[Severity: High]
When HPD is deasserted, dptx_detect() returns -ENODEV without calling
dptx_handle_disconnect(dp) to clear DPTX_STATE_CONNECTED.  Can this leave
DPTX_STATE_CONNECTED set across an unplug and replug?

If a disconnect is observed through .detect() (or if an unplug/replug
coalesces before hpd_event_work runs for the disconnect),
DPTX_STATE_CONNECTED remains set; when a new monitor is plugged in,
dptx_handle_connect() returns 0 without calling dptx_read_sink_caps(),
keeping stale link_max_rate, link_max_lanes, and DPCD capabilities from
the previous sink.

In addition, because dptx_detect_status() updates dp->status in a separate
lock acquisition even when called from drm_bridge_funcs.detect, any userspa=
ce
GETCONNECTOR or poll call that runs before dptx_hpd_event_work_func() (or
before dptx_hpd_notify() in drm_bridge_connector_detect_ctx()) overwrites
dp->status early, causing old_status !=3D status (and hpd_state !=3D dp->st=
atus)
to evaluate to false and suppressing drm_bridge_hpd_notify().

[ ... ]

> +static void dptx_wait_phy_dp_mode(struct dptx_dev *dp)
> +{
> +	enum phy_mode mode;
> +
> +	if (read_poll_timeout(dp->hw->ops->phy_mode, mode, mode =3D=3D PHY_MODE=
_DP,
> +			      100 * USEC_PER_MSEC,
> +			      DP_HPD_MAX_TRIES * 100 * USEC_PER_MSEC, false,
> +			      dp->hw))
> +		dev_dbg(dp->dev, "PHY did not enter DP mode\n");
> +}
> +
> +static void dptx_hpd_event_work_func(struct work_struct *work)
> +{
> +	struct dptx_dev *dp =3D container_of(work, struct dptx_dev,
> +					 hpd_event_work.work);
> +	enum drm_connector_status old_status;
> +	enum drm_connector_status status;
> +	bool hpd;
> +
> +	dptx_lock(dp);
> +	old_status =3D dp->status;
> +	if (dptx_hpd_work_aborted(dp)) {
> +		dptx_unlock(dp);
> +		return;
> +	}
> +
> +	hpd =3D dptx_get_hpd_state(dp);
> +	dptx_unlock(dp);
> +
> +	if (hpd && dp->hw->ops->phy_mode(dp->hw) !=3D PHY_MODE_INVALID)
> +		dptx_wait_phy_dp_mode(dp);
> +
> +	dptx_detect_status(dp);

[Severity: Medium]
Does dptx_wait_phy_dp_mode() block for the full 10 seconds when the USB-C
PHY stays out of DP mode or when HPD is deasserted, and then proceed into
dptx_detect_status() anyway?

read_poll_timeout() only checks mode =3D=3D PHY_MODE_DP without checking
dp->hpd_stopped, DPTX_STATE_SUSPENDED, or !dptx_get_hpd_state(dp), so
cancel_delayed_work_sync(&dp->hpd_event_work) in suspend, shutdown, or
bridge detach can stall for 10 seconds.  Because the timeout error is
discarded, dptx_hpd_event_work_func() also attempts DPCD AUX reads in
dptx_detect_status() even when the PHY never entered DP mode.

> +
> +	dptx_lock(dp);
> +	status =3D dp->status;
> +	if (!dptx_hpd_work_aborted(dp)) {
> +		if (status =3D=3D connector_status_connected)
> +			dptx_handle_connect(dp);
> +		else
> +			dptx_handle_disconnect(dp);
> +	}
> +
> +	dptx_unlock(dp);
> +
> +	if (old_status !=3D status && dp->bridge.dev)
> +		drm_bridge_hpd_notify(&dp->bridge, status);
> +}

[Severity: Medium]
Should dptx_hpd_event_work_func() return after unlocking when
dptx_hpd_work_aborted(dp) is true?

If dptx_pm_prepare() suspends the device while dptx_hpd_event_work_func()
is unlocked in dptx_wait_phy_dp_mode(), dptx_detect() returns -EBUSY and
dptx_detect_status() sets dp->status =3D connector_status_unknown.  Falling
through when dptx_hpd_work_aborted(dp) is true calls
drm_bridge_hpd_notify(&dp->bridge, connector_status_unknown) during
suspend or bridge detach, which invokes dptx_hpd_notify() while
DPTX_STATE_SUSPENDED is set and overwrites dp->force_hpd to
connector_status_disconnected.

[ ... ]

> +static void dptx_replay_deferred_hotplug(struct dptx_dev *dp)
> +{
> +	bool hpd;
> +
> +	dptx_lock(dp);
> +	if (!dptx_deferred_hotplug_pending(dp)) {
> +		dptx_unlock(dp);
> +		return;
> +	}
> +
> +	hpd =3D dptx_get_hpd_state(dp);
> +	dptx_unlock(dp);
> +
> +	if (hpd) {
> +		schedule_delayed_work(&dp->hpd_event_work, 0);
> +		return;
> +	}
> +
> +	if (dp->hw->ops->phy_mode(dp->hw) !=3D PHY_MODE_DP)
> +		return;
> +
> +	dptx_lock(dp);
> +	if (!dptx_deferred_hotplug_pending(dp)) {
> +		dptx_unlock(dp);
> +		return;
> +	}
> +
> +	dptx_unlock(dp);
> +
> +	if (!dp->hw->ops->sink_present(dp->hw))
> +		return;
> +
> +	dptx_lock(dp);
> +	if (!dptx_regs_accessible(dp)) {
> +		dptx_unlock(dp);
> +		return;
> +	}
> +
> +	dp->force_hpd =3D connector_status_connected;
> +	dp->status =3D connector_status_unknown;
> +	dptx_unlock(dp);
> +
> +	schedule_delayed_work(&dp->hpd_event_work, 0);
> +}

[Severity: Medium]
Can dropping dp->lock around dp->hw->ops->sink_present(dp->hw) race with
dptx_host_deinit()?

CPU0                                  CPU1
dptx_replay_deferred_hotplug()
  dptx_lock(dp)
  dptx_deferred_hotplug_pending(dp)
  dptx_unlock(dp)
                                      dptx_pm_prepare()
                                        ...
                                        dptx_lock(dp)
                                        dptx_host_deinit(dp)
                                          apb_clock(dp->hw, false)
                                        dptx_unlock(dp)
  dp->hw->ops->sink_present(dp->hw)
    /* AUX MMIO access with apb_clk off */

In addition, after sink_present() succeeds and dp->lock is re-acquired,
only dptx_regs_accessible(dp) is checked rather than
dptx_deferred_hotplug_pending(dp), which can clobber a concurrent
dp->force_hpd update from dptx_hpd_notify().

> +
> +static irqreturn_t dptx_irq_handler(int irq, void *data)
> +{
> +	struct dptx_dev *dp =3D data;
> +
> +	return dp->hw->ops->irq(dp->hw);
> +}
> +
> +static void dptx_queue_hpd_event(void *data)
> +{
> +	struct dptx_dev *dp =3D data;
> +
> +	if (!READ_ONCE(dp->hpd_stopped))
> +		queue_delayed_work(system_freezable_wq, &dp->hpd_event_work, 0);
> +}

[Severity: Medium]
dptx_queue_hpd_event() queues dp->hpd_event_work onto system_freezable_wq,
whereas dptx_replay_deferred_hotplug() and dptx_pm_complete() queue the
same dp->hpd_event_work onto system_wq via schedule_delayed_work().  Can
queuing the same work item onto two different workqueues allow
dptx_hpd_event_work_func() to run concurrently on two CPUs and bypass
workqueue freezing during suspend?

Using dptx_queue_hpd_event() consistently for dp->hpd_event_work would
keep it on system_freezable_wq.

> +
> +static void dptx_queue_hpd_irq(void *data)
> +{
> +	struct dptx_dev *dp =3D data;
> +
> +	if (!READ_ONCE(dp->hpd_stopped))
> +		queue_delayed_work(system_freezable_wq, &dp->hpd_irq_work, 0);
> +}
> +
> +static void dptx_irq_off(struct dptx_dev *dp)
> +{
> +	if (READ_ONCE(dp->irq_suspended))
> +		return;
> +
> +	disable_irq(dp->irq);
> +	WRITE_ONCE(dp->irq_suspended, true);
> +}
> +
> +static void dptx_cancel_hpd_works(struct dptx_dev *dp)
> +{
> +	cancel_delayed_work_sync(&dp->sw_hpd_irq_work);
> +	cancel_delayed_work_sync(&dp->hpd_irq_work);
> +	cancel_delayed_work_sync(&dp->hpd_event_work);
> +}
> +
> +static void dptx_quiesce_hpd(struct dptx_dev *dp)
> +{
> +	bool irq_off;
> +
> +	dptx_lock(dp);
> +	WRITE_ONCE(dp->hpd_stopped, true);
> +	dptx_unlock(dp);
> +
> +	irq_off =3D READ_ONCE(dp->irq_suspended);
> +	if (!irq_off)
> +		disable_irq(dp->irq);
> +
> +	dptx_cancel_hpd_works(dp);
> +
> +	if (!irq_off)
> +		enable_irq(dp->irq);
> +}

[Severity: Medium]
Can unsynchronized access to dp->irq_suspended in dptx_irq_off() and
dptx_quiesce_hpd() race with dptx_host_resume()?

CPU0                                  CPU1
dptx_detect()
  dptx_lock(dp)
  dptx_host_resume(dp)
    if (READ_ONCE(dp->irq_suspended))
      enable_irq(dp->irq)
                                      dptx_pm_prepare()
                                        dptx_irq_off(dp)
                                          if (READ_ONCE(dp->irq_suspended))
                                            return;  <-- skips disable_irq()
      WRITE_ONCE(dp->irq_suspended, false)
  dptx_unlock(dp)

Because dptx_irq_off() and dptx_quiesce_hpd() inspect and update
dp->irq_suspended outside dp->lock, dptx_irq_off() can observe
dp->irq_suspended =3D=3D true right after dptx_host_resume() re-enabled the
IRQ, leaving dp->irq enabled while dptx_pm_prepare() powers down the host.

> +
> +static int dptx_pm_prepare(struct dptx_dev *dp)
> +{
> +	if (dp->bridge.dev && dp->bridge.dev->mode_config.poll_enabled)
> +		drm_kms_helper_poll_disable(dp->bridge.dev);
> +
> +	dptx_irq_off(dp);
> +
> +	dptx_lock(dp);
> +	dp->state |=3D DPTX_STATE_SUSPENDED;
> +	dptx_unlock(dp);
> +
> +	dptx_cancel_hpd_works(dp);
> +
> +	dptx_lock(dp);
> +	if (!dp->active_stream_cnt)
> +		dptx_host_deinit(dp);
> +	dp->status =3D connector_status_unknown;
> +	dp->state &=3D ~DPTX_STATE_CONNECTED;
> +	dptx_unlock(dp);
> +
> +	return 0;
> +}
> +
> +static int dptx_pm_complete(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	dptx_lock(dp);
> +	ret =3D dptx_host_resume(dp);
> +	dptx_unlock(dp);
> +	if (ret)
> +		return ret;
> +
> +	if (dp->bridge.dev && dp->bridge.dev->mode_config.poll_enabled)
> +		drm_kms_helper_poll_enable(dp->bridge.dev);

[Severity: Medium]
Should an individual bridge's suspend and resume callbacks toggle
drm_kms_helper_poll_disable() and drm_kms_helper_poll_enable() on the
parent drm_device?

Output polling belongs to the KMS device as a whole.  When multiple
bridges share a drm_device or a bridge resumes before the display
controller, the first bridge to run dptx_pm_complete() re-enables HPD and
schedules output_poll_work across all connectors while sibling bridges and
the KMS driver are still suspended.

> +
> +	if (!READ_ONCE(dp->hpd_stopped) && READ_ONCE(dp->attached))
> +		schedule_delayed_work(&dp->hpd_event_work, 0);
> +
> +	return 0;
> +}
> +
> +static int dptx_prepare(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	dptx_lock(dp);
> +
> +	ret =3D dptx_host_resume(dp);
> +	if (ret)
> +		goto end;

[Severity: Medium]
Because dptx_detect() and dptx_prepare() unconditionally call
dptx_host_resume(dp), can a concurrent detect or modeset undo
DPTX_STATE_SUSPENDED while dptx_pm_prepare() is in flight or after the
bridge has suspended?

CPU0                                  CPU1
dptx_pm_prepare()
  dptx_irq_off(dp)
  dptx_lock(dp)
  dp->state |=3D DPTX_STATE_SUSPENDED
  dptx_unlock(dp)
  dptx_cancel_hpd_works(dp)
                                      dptx_detect() / dptx_prepare()
                                        dptx_lock(dp)
                                        dptx_host_resume(dp)
                                          enable_irq(dp->irq)
                                          dp->state &=3D ~DPTX_STATE_SUSPEN=
DED
                                        dptx_unlock(dp)
  dptx_lock(dp)
  dptx_host_deinit(dp)
    apb_clock(dp->hw, false)          <-- IRQ enabled with apb_clk off
  dptx_unlock(dp)

Even after dptx_pm_prepare() finishes (including via dptx_shutdown()),
any later dptx_detect() or dptx_prepare() call will also invoke
dptx_host_resume() and power the controller, clocks, PHY, and IRQ back on.

[ ... ]

> +static int dptx_get_irq(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	ret =3D of_irq_get(dp->dev->of_node, 0);
> +	if (ret < 0)
> +		return dev_err_probe(dp->dev, ret, "failed to get irq\n");
> +
> +	dp->irq =3D ret;
> +
> +	return 0;
> +}

[Severity: Medium]
of_irq_get() returns 0 on IRQ mapping failure (and when CONFIG_OF_IRQ is
disabled).  Should this check ret <=3D 0 so that dp->irq =3D 0 is not passed
to irq_set_status_flags() in dptx_init()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124120114.3273=
161-1-Luo.Liu@cixtech.com?part=3D4
