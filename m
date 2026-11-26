Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282F6606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=moT4nAwR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E56E10E164;
	Thu, 26 Nov 2026 06:20:52 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27C9C10E2A5
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:20:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4A05D6125E;
 Thu, 26 Nov 2026 06:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF881F000D1;
 Thu, 26 Nov 2026 06:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795674045;
 bh=7AsEqIqBwmPNzMxGSW2qOQTcuIO5i20OQd78g1l9to4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=moT4nAwR4LQISbyRJ6WQ87ypRRIdf0SmJKEmke0ugxpL/aUPJhIYG1YQu0nz9EnMi
 VZg+a8I14U9CU61La5wgwnPJQ4TJokGva8zNmELLSjlfkrYH/NsnDCDyu6oc6cL445
 7DifJgMp08r8Xst4LIWVsUy6fBdjvRGMumY6VLOevzvoxGG9/DDEsOXVRlvMCJjmwH
 wdOCV0Hq8UNnP8J7YjU/dyFI6Za6fzVphBaJe19GIUB9+5H4M6XYP+l5NrW1bekdLx
 cbOHfFF9jqljPpMgCkirBlMV0mLQZEOgnNwU+5CPILQKNtXicwZf88WKhdmyVrV81s
 kZqmBurbLJ87g==
Message-ID: <sashiko-outbox-234833@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] drm/bridge: trilinear: add the DPTX core and
 build glue
To: "Luo Liu" <Luo.Liu@cixtech.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261126060003.3979478-5-Luo.Liu@cixtech.com>
References: <20261126060003.3979478-1-Luo.Liu@cixtech.com>
 <20261126060003.3979478-5-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:20:44 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/bridge: trilinear: suspend race in dptx_prepare() and
  dptx_unprepare()
- [Medium] drm/bridge: trilinear: dptx_pm_prepare() clears force_hpd
  before core_off
- [Medium] drm/bridge: trilinear: dptx_detect() race drops HPD
  notification in worker
- [Medium] drm/bridge: trilinear: dptx_host_deinit() disables host
  before AUX poweroff
--

commit e4c145e1af987165c679844b15b259c9b490d6af
Author: Luo Liu <Luo.Liu@cixtech.com>

drm/bridge: trilinear: add the DPTX core and build glue

This commit adds the Trilinear DPTX bridge core, including probe, system
sleep, hotplug workers, and stream state management, and hooks the driver
into the DRM bridge Kconfig and Makefile.

> diff --git a/drivers/gpu/drm/bridge/trilinear/dptx_core.c b/drivers/gpu/d=
rm/bridge/trilinear/dptx_core.c
> new file mode 100644
> index 0000000000000..532f4fe0577f2
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/trilinear/dptx_core.c
> @@ -0,0 +1,1080 @@

[ ... ]

> +static void dptx_host_deinit(struct dptx_dev *dp)
> +{
> +	if (dp->state & DPTX_STATE_READY)
> +		dptx_core_off(dp);
> +
> +	if (!(dp->state & DPTX_STATE_INITIALIZED))
> +		return;
> +
> +	dp->hw->ops->host_enable(dp->hw, false);
> +	phy_exit(dp->phy);
> +
> +	drm_dp_dpcd_set_powered(&dp->hw->aux, false);
> +	dp->hw->ops->apb_clock(dp->hw, false);
> +
> +	dp->state &=3D ~(DPTX_STATE_INITIALIZED | DPTX_STATE_INIT_TRAIN);
> +}

[Severity: Medium]
Should drm_dp_dpcd_set_powered(&dp->hw->aux, false) run before
host_enable(dp->hw, false) and phy_exit(dp->phy)?

DPCD transactions through /dev/drm_dp_auxN serialize on aux.hw_mutex and
aux.powered_down rather than dp->lock.  Disabling the transmitter and
exiting the PHY before marking the AUX channel powered down lets a
concurrent DPCD access run dptx_hw_aux_transfer() while the host and PHY
are being torn down.

[ ... ]

> +static int dptx_detect_locked(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	if (dp->released) {
> +		ret =3D -ENODEV;
> +		goto out;
> +	}
> +
> +	if (dp->state & DPTX_STATE_SUSPENDED) {
> +		ret =3D -EBUSY;
> +		goto out;
> +	}
> +
> +	if (!(dp->state & DPTX_STATE_INITIALIZED)) {
> +		dev_warn_once(dp->dev, "detect with uninitialized host\n");
> +		ret =3D -ENODEV;
> +		goto out;
> +	}
> +
> +	if (!dptx_get_hpd_state(dp)) {
> +		dptx_handle_disconnect(dp);
> +		ret =3D -ENODEV;
> +		goto out;
> +	}
> +
> +	ret =3D dptx_handle_connect(dp);
> +
> +out:
> +	dp->status =3D dptx_ret_to_status(ret);
> +
> +	return ret;
> +}

[ ... ]

> +static void dptx_hpd_event_work_func(struct work_struct *work)
> +{
> +	struct dptx_dev *dp =3D container_of(work, struct dptx_dev,
> +					 hpd_event_work.work);
> +	enum drm_connector_status old_status;
> +	enum drm_connector_status status;
> +	bool hpd;
> +
> +	scoped_guard(mutex, &dp->lock) {
> +		if (dptx_hpd_work_aborted(dp))
> +			return;
> +
> +		old_status =3D dp->status;
> +		hpd =3D dptx_get_hpd_state(dp);
> +	}
> +
> +	if (hpd && dp->oob_hpd && !dptx_wait_phy_dp_mode(dp))
> +		return;
> +
> +	scoped_guard(mutex, &dp->lock) {
> +		if (dptx_hpd_work_aborted(dp))
> +			return;
> +
> +		status =3D dptx_ret_to_status(dptx_detect_locked(dp));
> +	}
> +
> +	if (old_status !=3D status && dp->bridge.dev)
> +		dptx_notify_hpd(dp, status);
> +}

[Severity: Medium]
Can a concurrent dptx_detect() call update dp->status and cause
dptx_hpd_event_work_func() to drop its HPD notification?

CPU0 (hpd_event_work)             CPU1 (connector probe / modeset)
dptx_queue_hpd_event()
                                  dptx_detect()
                                    lock(&dp->lock)
                                    dptx_detect_locked()
                                      dp->status =3D connected
                                    unlock(&dp->lock)
dptx_hpd_event_work_func()
  lock(&dp->lock)
  old_status =3D dp->status
  ...
  status =3D dptx_detect_locked()
  unlock(&dp->lock)
  old_status !=3D status            <-- false, dptx_notify_hpd() skipped

The same mismatch can happen on OOB hotplug when dptx_hpd_event_work_func()
captures old_status =3D=3D connector_status_connected, drops dp->lock in
dptx_wait_phy_dp_mode(), and a concurrent dptx_bridge_detect() probes
before the PHY enters PHY_MODE_DP (setting dp->status and the DRM
connector to disconnected): once the PHY enters DP mode and
dptx_detect_locked() succeeds, status matches old_status and
dptx_notify_hpd() is skipped, leaving the DRM connector state disconnected.

[ ... ]

> +static int dptx_pm_prepare(struct dptx_dev *dp)
> +{
> +	scoped_guard(mutex, &dp->lock) {
> +		dptx_irq_off(dp);
> +		dp->state |=3D DPTX_STATE_SUSPENDED;
> +	}
> +
> +	dptx_cancel_hpd_works(dp);
> +
> +	scoped_guard(mutex, &dp->lock) {
> +		if (!(dp->state & DPTX_STATE_SUSPENDED)) {
> +			dptx_irq_off(dp);
> +			dp->state |=3D DPTX_STATE_SUSPENDED;
> +		}
> +
> +		if (!dp->active_stream_cnt)
> +			dptx_host_deinit(dp);
> +		dp->status =3D connector_status_unknown;
> +		dp->force_hpd =3D connector_status_unknown;
> +		dp->state &=3D ~DPTX_STATE_CONNECTED;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
When dp->active_stream_cnt is non-zero during dptx_pm_prepare(), does
clearing dp->force_hpd here prevent dptx_core_off() from powering down a
USB-C sink in D3?

When a stream is still active, dptx_pm_prepare() defers dptx_host_deinit()
to the suspend-time atomic disable commit in dptx_unprepare(), which calls
dptx_core_off() -> dpcd_power_down(dp->hw, dptx_get_hpd_state(dp)).  On
oob_hpd transmitters hardware HPD is not wired, so once dp->force_hpd is
reset to connector_status_unknown, dptx_get_hpd_state() returns false and
dptx_hw_dpcd_power_down() skips writing DP_SET_POWER_D3.

[ ... ]

> +static int dptx_prepare(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	guard(mutex)(&dp->lock);
> +
> +	if (dp->released)
> +		return -ENODEV;
> +
> +	/* The controller's resume commit can precede dptx_pm_complete(). */
> +	ret =3D dptx_host_resume(dp);
> +	if (ret)
> +		return ret;
> +
> +	if (dp->state & DPTX_STATE_ENABLED)
> +		return 0;
> +
> +	if (!(dp->state & DPTX_STATE_INITIALIZED)) {
> +		ret =3D dptx_host_init(dp);
> +		if (ret)
> +			return ret;
> +	} else if (dp->state & DPTX_STATE_READY) {
> +		/* core_on() finished, but the stream never became ENABLED. */
> +		dptx_core_off(dp);
> +	}
> +
> +	if (!dptx_get_hpd_state(dp)) {
> +		if (!dp->oob_hpd ||
> +		    dp->force_hpd !=3D connector_status_unknown ||
> +		    phy_get_mode(dp->phy) !=3D PHY_MODE_DP ||
> +		    !dp->hw->ops->sink_present(dp->hw))
> +			return -ENODEV;
> +
> +		dp->force_hpd =3D connector_status_connected;
> +	}
> +
> +	return dptx_handle_connect(dp);
> +}
> +
> +static int dptx_unprepare(struct dptx_dev *dp)
> +{
> +	if (dp->active_stream_cnt)
> +		return 0;
> +
> +	if (!(dp->state & (DPTX_STATE_ENABLED | DPTX_STATE_READY)))
> +		return 0;
> +
> +	dptx_core_off(dp);
> +
> +	/* dptx_pm_prepare() may have run before this suspend-time commit. */
> +	if (dp->state & DPTX_STATE_SUSPENDED)
> +		dptx_host_deinit(dp);
> +
> +	dp->state &=3D ~DPTX_STATE_ENABLED;
> +
> +	return 0;
> +}

[Severity: High]
Can an atomic enable racing with or running after dptx_pm_prepare() leave
the host initialized and dp->irq armed across system suspend or shutdown?

CPU0 (suspend / shutdown)         CPU1 (atomic enable)
dptx_pm_prepare()
  lock(&dp->lock)
  dptx_irq_off()
  dp->state |=3D DPTX_STATE_SUSPENDED
  unlock(&dp->lock)
  dptx_cancel_hpd_works()
                                  dptx_bridge_atomic_enable()
                                    dptx_prepare()
                                      lock(&dp->lock)
                                      dptx_host_resume()
                                        dptx_host_init()
                                        enable_irq(dp->irq)
                                        dp->state &=3D ~DPTX_STATE_SUSPENDED
                                      unlock(&dp->lock)
                                    <HPD IRQ queues hpd_event_work>
  lock(&dp->lock)
  dptx_irq_off()
  dp->state |=3D DPTX_STATE_SUSPENDED
  dptx_host_deinit()
  unlock(&dp->lock)
                                    dptx_bridge_mode_set()
                                      dptx_detect() -> -EBUSY
                                    dptx_unprepare()
                                      !(state & (ENABLED | READY))
                                      return 0  <-- skips dptx_host_deinit()

There are three related issues in this path:

First, if dptx_prepare() runs after dptx_pm_prepare() has already finished
(for example after trilinear_dptx_suspend() or trilinear_dptx_shutdown()),
dptx_host_resume() re-initializes the host, calls enable_irq(dp->irq), and
clears DPTX_STATE_SUSPENDED, and nothing reinstates DPTX_STATE_SUSPENDED
or disables dp->irq afterwards.

Second, in dptx_unprepare(), the early return when neither
DPTX_STATE_ENABLED nor DPTX_STATE_READY is set sits above the
DPTX_STATE_SUSPENDED check, so when dptx_bridge_atomic_enable() fails in
dptx_bridge_mode_set() or dptx_core_on() and jumps to err_unprepare,
dptx_unprepare() returns without calling dptx_host_deinit().

Third, when dptx_prepare() runs while dptx_pm_prepare() has dropped
dp->lock for dptx_cancel_hpd_works(), dptx_host_resume() re-enables
dp->irq without dp->hpd_stopped set, so an interrupt can re-queue
hpd_event_work or hpd_irq_work after dptx_cancel_hpd_works() has returned;
and if dptx_encoder_enable() finishes before dptx_pm_prepare() re-acquires
dp->lock, dp->active_stream_cnt is non-zero and dptx_pm_prepare() returns
without calling dptx_host_deinit().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126060003.3979=
478-1-Luo.Liu@cixtech.com?part=3D4
