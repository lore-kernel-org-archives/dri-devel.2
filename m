Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C77606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 04:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wmc1Ifwp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56BBC10E8AD;
	Wed, 25 Nov 2026 04:00:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87BC10E8AD
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 04:00:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8EBE443BC2;
 Wed, 25 Nov 2026 04:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D478B1F000C4;
 Wed, 25 Nov 2026 04:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795579201;
 bh=snNphkTPqXugMIQHUCugfdkOLg7AbzZRxfaehaJFjiY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wmc1IfwpSXdJ5YYETD4N2f3YubCQJNY7wThxrrVAbzhQlPgK6IUlfzCEAqQ0Qr3zW
 YLYJKwYfIImPtDEYalQyXy6Fp00ZXSnLMWHEs1TCgAa+avfTMlM02etF1j8j/d2Qa7
 gCTpR7G4WP1KyPwLMMC1qU0bOvdUkR2tjmkDuuRaIV09Fw8zo458oPbu7PHMFoS3Az
 cbO2mh76hzUIajyGh7nctw/U6ZY+VE72JpfgKGpEB5by0d/cNsnjQa6heox7nUApko
 kDX5dVgMNZhtZ6n1+nOZC0SjG9ThWmVkCaZfilTg1QwNKebCxbVGOol/mNBVjUCo/J
 CmaU9RUF6C9RA==
Message-ID: <sashiko-outbox-232544@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] drm/bridge: trilinear: add the DPTX core and
 build glue
To: "Luo Liu" <Luo.Liu@cixtech.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261125033238.3436046-5-Luo.Liu@cixtech.com>
References: <20261125033238.3436046-1-Luo.Liu@cixtech.com>
 <20261125033238.3436046-5-Luo.Liu@cixtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 04:00:00 +0000
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

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] drm/bridge: trilinear: missing status update in dptx_detect()
  breaks HPD
- [High] drm/bridge: trilinear: suspend race with dptx_prepare() and
  dptx_unprepare()
- [High] drm/bridge: trilinear: UAF and destroyed mutexes on unbind in
  dptx_probe()
- [High] drm/bridge: trilinear: unclocked AUX MMIO access after
  dptx_host_deinit()
- [Medium] drm/bridge: trilinear: DPTX_MAX_LINK_RATE clamps link rate to
  HBR2
- [Medium] drm/bridge: trilinear: stale force_hpd stalls PHY wait and
  USB-C unplug
- [Medium] drm/bridge: trilinear: missing host_enable() rollback in
  dptx_host_reset()
- [Low] drm/bridge: trilinear: unreachable dptx_host_resume() call in
  dptx_detect()
--

commit 5884b10a11ec4e3f84fff1f9d68ae7a14e195f9c
Author: Luo Liu <Luo.Liu@cixtech.com>

drm/bridge: trilinear: add the DPTX core and build glue

This commit adds the Trilinear DisplayPort transmitter core, including the
probe and system sleep paths, hotplug workers, stream state machine, and
Kconfig/Makefile integration.

> diff --git a/drivers/gpu/drm/bridge/trilinear/dptx.h b/drivers/gpu/drm/br=
idge/trilinear/dptx.h
> new file mode 100644
> index 0000000000000..78ebe0f14571d
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/trilinear/dptx.h
> @@ -0,0 +1,106 @@

[ ... ]

> +#define DPTX_MAX_FREQ 600000
> +#define DPTX_MAX_LINK_RATE drm_dp_bw_code_to_link_rate(DP_LINK_BW_5_4)
> +#define DP_MAX_TRAINING_LOOP 3

[Severity: Medium]
Should DPTX_MAX_LINK_RATE use DP_LINK_BW_8_1 instead of DP_LINK_BW_5_4?
Both dptx_probe() and dptx_read_sink_caps() clamp dp->link_max_rate to
DPTX_MAX_LINK_RATE, which caps the link at HBR2 (5.4 Gbps) and makes the
DP_LINK_BW_8_1 (HBR3) handling in dptx_mode_configure(), dptx_drm.c, and
dptx_hw.c unreachable.

> diff --git a/drivers/gpu/drm/bridge/trilinear/dptx_core.c b/drivers/gpu/d=
rm/bridge/trilinear/dptx_core.c
> new file mode 100644
> index 0000000000000..b59a47396b8ee
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/trilinear/dptx_core.c
> @@ -0,0 +1,1101 @@

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

[Severity: Medium]
If dp->hw->ops->phy_init() fails, does dptx_host_reset() leave the
transmitter enabled and hardware HPD interrupts unmasked?  dptx_host_init()
then disables apb_clk, so a subsequent HPD interrupt when the IRQ is live
(for example during dptx_prepare() or dptx_host_resume()) will read MMIO
registers in dptx_hw_irq() with apb_clk gated off.

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
> +
> +	dp->state |=3D DPTX_STATE_INITIALIZED;
> +
> +	return 0;
> +}
> +
> +static void dptx_host_deinit(struct dptx_dev *dp)
> +{
> +	if (dp->state & DPTX_STATE_READY)
> +		dptx_core_off(dp);
> +
> +	if (!(dp->state & DPTX_STATE_INITIALIZED))
> +		return;
> +
> +	dp->hw->ops->host_enable(dp->hw, false);
> +	dp->hw->ops->phy_exit(dp->hw);
> +
> +	dp->hw->ops->apb_clock(dp->hw, false);
> +
> +	dp->state &=3D ~(DPTX_STATE_INITIALIZED | DPTX_STATE_INIT_TRAIN);
> +}

[Severity: High]
Can dptx_hw_aux_transfer() access DPTX_AUX_* MMIO registers after
dptx_host_deinit() has gated apb_clk?

dptx_probe() exposes dp->hw->aux.ddc on the bridge and dptx_bridge_attach()
registers dp->hw->aux, but dptx_hw_aux_transfer() only takes
hw->aux.hw_mutex without checking whether the host is initialized:

drivers/gpu/drm/bridge/trilinear/dptx_hw.c:dptx_hw_aux_transfer() {
	struct dp_hw *hw =3D container_of(aux, struct dp_hw, aux);
    ...
	return dptx_hw_aux_cmd_submit(hw, msg->address, cmd, msg->buffer,
				      msg->size, &msg->reply);
}

Any AUX or I2C-over-AUX transaction that runs concurrently with or after
dptx_host_deinit() during suspend or shutdown will perform unclocked APB
register accesses.

[ ... ]

> +static int dptx_detect(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	dptx_lock(dp);
> +
> +	if (dp->state & DPTX_STATE_SUSPENDED) {
> +		ret =3D -EBUSY;
> +		goto out;
> +	}
> +
> +	ret =3D dptx_host_resume(dp);
> +	if (ret)
> +		goto out;

[Severity: Low]
Since dptx_detect() returns -EBUSY right above when DPTX_STATE_SUSPENDED is
set, and dptx_host_resume() immediately returns 0 when DPTX_STATE_SUSPENDED
is not set, is this dptx_host_resume() call dead code?

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
> +	return status;
> +}

[Severity: High]
Should dptx_detect() or dptx_detect_status() update dp->status to match the
detected connector status?

When drm_bridge_connector_detect_ctx() probes the connector, it calls
dptx_bridge_detect() -> dptx_detect_status() and immediately follows with
drm_bridge_connector_hpd_notify(), which calls dptx_hpd_notify():

drivers/gpu/drm/bridge/trilinear/dptx_drm.c:dptx_hpd_notify() {
    ...
	if (hpd_state !=3D dp->status) {
		dp->force_hpd =3D hpd_state;
		queue_delayed_work(system_freezable_wq, &dp->hpd_event_work, 0);
}

Because dp->status is still at its previous value (such as
connector_status_unknown after probe or suspend), dptx_hpd_notify() sees
hpd_state !=3D dp->status and sets dp->force_hpd =3D hpd_state.  On a nativ=
e DP
port with a monitor connected, that latches dp->force_hpd to
connector_status_connected.  From then on, dptx_get_hpd_state() always
returns true even after the cable is unplugged, and dptx_handle_connect()
returns 0 immediately because DPTX_STATE_CONNECTED is already set, leaving
the connector permanently stuck as connected.

[ ... ]

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
> +	if (hpd && dp->hw->ops->phy_mode(dp->hw) !=3D PHY_MODE_INVALID &&
> +	    !dptx_wait_phy_dp_mode(dp))
> +		return;
> +
> +	status =3D dptx_detect_status(dp);
> +
> +	dptx_lock(dp);
> +	if (dptx_hpd_work_aborted(dp)) {
> +		dptx_unlock(dp);
> +		return;
> +	}
> +
> +	dp->status =3D status;
> +	if (status =3D=3D connector_status_connected)
> +		dptx_handle_connect(dp);
> +	else
> +		dptx_handle_disconnect(dp);
> +
> +	dptx_unlock(dp);
> +
> +	if (old_status !=3D status && dp->bridge.dev)
> +		drm_bridge_hpd_notify(&dp->bridge, status);
> +}

[Severity: Medium]
Can dp->force_hpd get stuck at connector_status_connected on USB-C ports and
stall system_freezable_wq in dptx_wait_phy_dp_mode()?

dp->status is not updated to connector_status_connected until after
dptx_wait_phy_dp_mode() (which polls for up to 10 seconds) and
dptx_detect_status() complete.  If a USB-C sink is unplugged while
dptx_wait_phy_dp_mode() is polling (or after it times out and returns early=
),
dp->status is still connector_status_disconnected, so
dptx_hpd_notify(dp, connector_status_disconnected) sees
hpd_state =3D=3D dp->status and drops the disconnect without clearing
dp->force_hpd.  dptx_hpd_wait_aborted() then never sees
dptx_get_hpd_state() drop to false, stalling the workqueue for the full
10-second timeout and leaving dp->force_hpd stuck at
connector_status_connected.

Similarly, dptx_pm_prepare() resets dp->status to connector_status_unknown
without clearing dp->force_hpd; if a USB-C sink is unplugged during system
sleep, resume queues hpd_event_work with dp->force_hpd still set to
connector_status_connected, stalling dptx_wait_phy_dp_mode() for 10 seconds
and returning before dp->status is updated.

[ ... ]

> +static int dptx_pm_prepare(struct dptx_dev *dp)
> +{
> +	dptx_lock(dp);
> +	dptx_irq_off(dp);
> +	dp->state |=3D DPTX_STATE_SUSPENDED;
> +	dptx_unlock(dp);
> +
> +	dptx_cancel_hpd_works(dp);
> +
> +	dptx_lock(dp);
> +	if (!(dp->state & DPTX_STATE_SUSPENDED)) {
> +		dptx_irq_off(dp);
> +		dp->state |=3D DPTX_STATE_SUSPENDED;
> +	}
> +
> +	if (!dp->active_stream_cnt)
> +		dptx_host_deinit(dp);
> +	dp->status =3D connector_status_unknown;
> +	dp->state &=3D ~DPTX_STATE_CONNECTED;
> +	dptx_unlock(dp);
> +
> +	return 0;
> +}

[ ... ]

> +static int dptx_prepare(struct dptx_dev *dp)
> +{
> +	int ret;
> +
> +	dptx_lock(dp);
> +
> +	ret =3D dptx_host_resume(dp);
> +	if (ret)
> +		goto end;
> +
> +	if (dp->state & DPTX_STATE_ENABLED) {
> +		ret =3D 0;
> +		goto end;
> +	}
> +
> +	if (!(dp->state & DPTX_STATE_INITIALIZED)) {
> +		ret =3D dptx_host_init(dp);
> +		if (ret)
> +			goto end;
> +	} else if (dp->state & DPTX_STATE_READY) {
> +		/* core_on() finished, but the stream never became ENABLED. */
> +		dptx_core_off(dp);
> +	}
> +
> +	if (!dptx_get_hpd_state(dp)) {
> +		ret =3D -ENODEV;
> +		goto end;
> +	}
> +
> +	ret =3D dptx_handle_connect(dp);
> +
> +end:
> +	dptx_unlock(dp);
> +	return ret;
> +}
> +
> +static int dptx_unprepare(struct dptx_dev *dp)
> +{
> +	lockdep_assert_held(&dp->lock);
> +
> +	if (dp->active_stream_cnt)
> +		return 0;
> +
> +	if (!(dp->state & (DPTX_STATE_ENABLED | DPTX_STATE_READY)))
> +		return 0;
> +
> +	dptx_core_off(dp);
> +
> +	if (dp->state & DPTX_STATE_SUSPENDED)
> +		dptx_host_deinit(dp);
> +
> +	dp->state &=3D ~DPTX_STATE_ENABLED;
> +
> +	return 0;
> +}

[Severity: High]
Can an atomic enable racing with dptx_pm_prepare() leave the host
initialized, clocks enabled, and dp->irq armed across suspend?

CPU0 (suspend)                    CPU1 (atomic commit)
dptx_pm_prepare()
  dptx_lock()
  dptx_irq_off()
  dp->state |=3D DPTX_STATE_SUSPENDED
  dptx_unlock()
  dptx_cancel_hpd_works()
                                  dptx_bridge_atomic_enable()
                                    dptx_prepare()
                                      dptx_host_resume()
                                        dptx_host_init()
                                        enable_irq(dp->irq)
                                        dp->state &=3D ~DPTX_STATE_SUSPENDED
                                    ...
                                    dptx_encoder_enable(..., true)
                                      dp->active_stream_cnt++
  dptx_lock()
  if (!(dp->state & DPTX_STATE_SUSPENDED))
    dptx_irq_off()
    dp->state |=3D DPTX_STATE_SUSPENDED
  if (!dp->active_stream_cnt)
    /* skipped: active_stream_cnt =3D=3D 1 */
  dptx_unlock()

There are three related issues in this suspend synchronization:

First, if dptx_prepare() runs while dptx_pm_prepare() is in
dptx_cancel_hpd_works(), dptx_host_resume() re-enables dp->irq and clears
DPTX_STATE_SUSPENDED.  An interrupt can then re-queue hpd_event_work or
hpd_irq_work after dptx_cancel_hpd_works() has returned, and if
dptx_encoder_enable() finishes before dptx_pm_prepare() re-acquires
dp->lock, dptx_pm_prepare() sees dp->active_stream_cnt !=3D 0 and skips
dptx_host_deinit().

Second, if dptx_prepare() runs after dptx_pm_prepare() has already finished
its second locked block, dptx_host_resume() initializes the host, enables
dp->irq, and clears DPTX_STATE_SUSPENDED with nothing left to reinstate
DPTX_STATE_SUSPENDED or call dptx_host_deinit() and dptx_irq_off().

Third, in dptx_unprepare(), the early return when neither
DPTX_STATE_ENABLED nor DPTX_STATE_READY is set runs before checking
DPTX_STATE_SUSPENDED.  If dptx_bridge_atomic_enable() fails in
dptx_bridge_mode_set() or dptx_core_on() (which clears DPTX_STATE_READY on
error) and jumps to err_unprepare, dptx_unprepare() returns early without
calling dptx_host_deinit().

[ ... ]

> +static void dptx_deinit(struct dptx_dev *dp)
> +{
> +	if (!(dp->state & DPTX_STATE_CONFIGURED))
> +		return;
> +
> +	dptx_lock(dp);
> +	WRITE_ONCE(dp->hpd_stopped, true);
> +	dptx_irq_off(dp);
> +	dptx_unlock(dp);
> +
> +	dptx_cancel_hpd_works(dp);
> +
> +	dptx_lock(dp);
> +	dptx_stop_streams(dp);
> +	dptx_host_deinit(dp);
> +	dp->state &=3D ~(DPTX_STATE_CONFIGURED);
> +	dptx_unlock(dp);
> +
> +	mutex_destroy(&dp->lock);
> +}
> +
> +static void dptx_dev_release(void *res)
> +{
> +	struct dptx_dev *dp =3D res;
> +
> +	dptx_deinit(dp);
> +}

[ ... ]

> +struct dptx_dev *dptx_probe(struct device *dev,
> +			    const struct dptx_plat_data *soc_data,
> +			    void *priv)
> +{

[ ... ]

> +	ret =3D dptx_init(dp);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	ret =3D devm_add_action_or_reset(dev, dptx_dev_release, dp);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	dev_set_drvdata(dev, dp);
> +
> +	dp->bridge.of_node =3D dev->of_node;
> +	dp->bridge.ops =3D DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_MODES |
> +			 DRM_BRIDGE_OP_HPD;
> +	dp->bridge.type =3D DRM_MODE_CONNECTOR_DisplayPort;
> +	dp->bridge.ddc =3D &dp->hw->aux.ddc;
> +	dp->bridge.ycbcr_420_allowed =3D true;
> +
> +	ret =3D devm_drm_bridge_add(dev, &dp->bridge);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return dp;
> +}

[Severity: High]
Can unbinding the DPTX device cause a use-after-free on dp->hw and acquire
destroyed mutexes?

First, devm_add_action_or_reset(dev, dptx_dev_release, dp) is registered
before devm_drm_bridge_add(dev, &dp->bridge), so devres runs
drm_bridge_remove() before dptx_deinit().  drm_bridge_remove() destroys
bridge->hpd_mutex while dp->irq is still enabled and dp->hpd_event_work has
not been cancelled, so a concurrent dptx_hpd_event_work_func() calling
drm_bridge_hpd_notify() can lock the destroyed bridge->hpd_mutex.

Second, while struct dptx_dev is refcounted via devm_drm_bridge_alloc(),
dp->hw (which embeds struct drm_dp_aux aux) is allocated with devm_kzalloc()
on dev.  When the DPTX device is unbound while the bridge is attached to an
encoder, dptx_deinit() destroys dp->lock without unregistering dp->hw->aux
and devres frees dp->hw, leaving the registered AUX device and I2C adapter
in freed memory.  When encoder cleanup later runs dptx_bridge_detach(), it
locks the destroyed dp->lock in dptx_quiesce_hpd() and dereferences the
freed dp->hw in dp->hw->ops->aux_unregister(dp->hw).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125033238.3436=
046-1-Luo.Liu@cixtech.com?part=3D4
