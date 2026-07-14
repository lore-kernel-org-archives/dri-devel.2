Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FFBC44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DB1A10E095;
	Tue, 14 Jul 2026 13:57:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HrCrsGik";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02B1610E095
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:57:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1746860254;
 Tue, 14 Jul 2026 13:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990481F000E9;
 Tue, 14 Jul 2026 13:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784037462;
 bh=0KaAF0kClUbWdLxRdVIdlkDOd9WedSGIozRki+L0Kzs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HrCrsGik5bWCVYCGfhWASaW9rcXAyOHOiDiBD+u5cvagQzO7e9SNLp6u9C9iUx7b1
 Dfhj5/YUh8ezxYmMN13/nbfAjVxoo+h5kB6cxrswBML9utSZ4V33Ide7xPaMUpsZFu
 aIva3KD7jYGsoMOVE1EZ9nKKcPlFl30MIiVIln9exa5HRsXmwM8rXYTYQKAosI5Itk
 RbMhqFU3dp1c60zEsVmQQMnsu2xxqOqm0eeQp6eOESBfwjCzTpC+/pbSAIBZHlpJvu
 oaCjMicVN+Ce5/A8hx6u2g87gS7VNN2rNDUe74oVQhBfFgXfcCqipkqtyG5DJO7lLK
 cujTJjukLGSFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for drm-misc-fixes 1/2] drm/hisilicon/hibmc: Modify the
 method of obtaining the hpd_status
To: "Yongbang Shi" <shiyongbang@huawei.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260714132051.993356-2-shiyongbang@huawei.com>
References: <20260714132051.993356-1-shiyongbang@huawei.com>
 <20260714132051.993356-2-shiyongbang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 13:57:42 +0000
Message-Id: <20260714135742.990481F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Hardcoding the initial HPD status to `HIBMC_HPD_OUT` and unconditi=
onally exiting in `hibmc_dp_detect()` breaks boot-time display detection fo=
r monitors connected before the driver loads.
- [High] Gating `hibmc_dp_encoder_enable` on HPD status breaks the DRM conn=
ector 'force on' functionality.
- [High] Reading the HPD state immediately in the hard IRQ handler without =
waiting for it to settle can read transient states, permanently discarding =
hotplug events.

Pre-existing issues:
- [High] Unconditional dereference of `dp->dp_dev` in the shared interrupt =
handler causes a kernel panic when the DP block is uninitialized.
- [Medium] Unprotected concurrent access to shared IRQ state variables (`ir=
q_status` and `hpd_status`) can lead to TOCTOU races and dropped interrupts.
--

--- Patch [1]: [PATCH for drm-misc-fixes 1/2] drm/hisilicon/hibmc: Modify t=
he method of obtaining the hpd_status ---
commit 7415e727057e1237039f87fc5bb416de2f8548f4
Author: Lin He <helin52@huawei.com>
drm/hisilicon/hibmc: Modify the method of obtaining the hpd_status

This commit changes how the HPD (Hot Plug Detect) status is retrieved for
the DP connector. It replaces the polling mechanism in the lower-half
interrupt handler with a direct status read in the upper-half handler, and
sets the initial HPD status to disconnected.

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm=
/hisilicon/hibmc/dp/dp_hw.c
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
[ ... ]
> @@ -322,20 +326,25 @@ void hibmc_dp_set_cbar(struct hibmc_dp *dp, const s=
truct hibmc_dp_cbar_cfg *cfg)
> -bool hibmc_dp_check_hpd_status(struct hibmc_dp *dp, int exp_status)
> +int hibmc_dp_get_hpd_status(struct hibmc_dp *dp)
>  {
> +	int ret =3D HIBMC_HPD_UNKNOWN;
>  	u32 status;
> -	int ret;
> =20
> -	ret =3D readl_poll_timeout(dp->dp_dev->base + HIBMC_DP_HPD_STATUS, stat=
us,
> -				 FIELD_GET(HIBMC_DP_HPD_CUR_STATE, status) =3D=3D exp_status,
> -				 1000, 100000); /* DP spec says 100ms */
> -	if (ret) {
> -		drm_dbg_dp(dp->drm_dev, "wait hpd status timeout");
> -		return false;
> +	status =3D FIELD_GET(HIBMC_DP_HPD_CUR_STATE,
> +			   readl(dp->dp_dev->base + HIBMC_DP_HPD_STATUS));

[Severity: High]
This is a pre-existing issue, but could this dereference dp->dp_dev when it
is NULL?

If hibmc_kms_init() skips hibmc_dp_init(), dp->dp_dev remains NULL. If a
spurious or shared interrupt fires, the hardirq handler calls
hibmc_dp_get_hpd_status() and immediately dereferences dp->dp_dev->base
causing a kernel panic.

[Severity: High]
Could this instantaneous read capture a transient state and permanently drop
hotplug events?

The previous code used readl_poll_timeout() to wait up to 100ms for the
bouncing HPD signal to settle, as required by the DP spec.

If this read occurs during a physical signal bounce upon plug-in, could it
return HIBMC_HPD_UNKNOWN and cause the threaded handler to silently drop the
event instead of waiting for the signal to stabilize?

> +
> +	switch (status) {
> +	case 0: /* 0: unplug */
> +	case 3: /* 3: done */
> +		ret =3D HIBMC_HPD_OUT;
> +		break;
> +	case 1: /* plug */
> +		ret =3D HIBMC_HPD_IN;
> +		break;
> +	default:
> +		break;
>  	}
> =20
> -	dp->dp_dev->hpd_status =3D exp_status;
> -
> -	return true;
> +	return ret;
>  }
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu=
/drm/hisilicon/hibmc/hibmc_drm_dp.c
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> @@ -63,12 +63,8 @@ static int hibmc_dp_detect(struct drm_connector *conne=
ctor,
>  	struct hibmc_dp_dev *dp_dev =3D dp->dp_dev;
>  	int ret =3D connector_status_disconnected;
> =20
> -	if (dp->irq_status) {
> -		if (dp_dev->hpd_status !=3D HIBMC_HPD_IN) {
> -			ret =3D connector_status_disconnected;
> -			goto exit;
> -		}
> -	}
> +	if (dp->hpd_status !=3D HIBMC_HPD_IN)
> +		goto exit;

[Severity: High]
Does this unconditional exit prevent the detection of displays connected
before the driver loads?

Since the initial state is hardcoded to HIBMC_HPD_OUT and we never poll
the hardware register to get the actual physical state during initializatio=
n,
if a monitor is already plugged in at boot, no edge-triggered interrupt
will fire.

Will this cause hibmc_dp_detect() to unconditionally return
connector_status_disconnected for displays connected at boot time?

> =20
>  	if (!hibmc_dp_get_dpcd(dp_dev)) {
>  		ret =3D connector_status_disconnected;
[ ... ]
> @@ -166,6 +162,9 @@ static void hibmc_dp_encoder_enable(struct drm_encode=
r *drm_encoder,
>  	struct hibmc_dp *dp =3D container_of(drm_encoder, struct hibmc_dp, enco=
der);
>  	struct drm_display_mode *mode =3D &drm_encoder->crtc->state->mode;
> =20
> +	if (dp->hpd_status !=3D HIBMC_HPD_IN)
> +		return;
> +

[Severity: High]
Could this early return break the DRM connector force on functionality?

If userspace explicitly forces the DP connector on when the physical HPD is
disconnected or broken, the DRM core will commit a modeset expecting the
encoder to be programmed.

By returning early here based on the physical connection state, we bypass
the hardware programming, leaving it out of sync with the DRM atomic state.
Might this lead to VBLANK timeouts or pipeline hangs?

>  	if (hibmc_dp_prepare(dp, mode))
>  		return;
> =20
> @@ -189,24 +188,31 @@ irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
>  {
>  	struct drm_device *dev =3D (struct drm_device *)arg;
>  	struct hibmc_drm_private *priv =3D to_hibmc_drm_private(dev);
> -	int idx, exp_status;
> +	int status =3D priv->dp.hpd_status;
> +	int idx;
> =20
>  	if (!drm_dev_enter(dev, &idx))
>  		return -ENODEV;
> =20
>  	if (priv->dp.irq_status & DP_MASKED_SINK_HPD_PLUG_INT) {

[Severity: Medium]
This is a pre-existing issue, but could this lead to a race condition that
drops interrupts?

The hardirq handler writes to priv->dp.irq_status and priv->dp.hpd_status
without locks, while this threaded handler reads them non-atomically.

If a hardirq preempts the threaded handler after it reads priv->dp.hpd_stat=
us
into the local status variable but before evaluating priv->dp.irq_status,
it will compare a stale status against a new irq_status. Will this mismatch
trigger the error paths below and improperly discard the event?

>  		drm_dbg_dp(&priv->dev, "HPD IN isr occur!\n");
> +		if (status !=3D HIBMC_HPD_IN) {
> +			drm_err(&priv->dev, "HPD status (%d) error", status);
> +			goto exit;
> +		}
>  		hibmc_dp_hpd_cfg(&priv->dp);
[ ... ]
> @@ -223,6 +229,7 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
> =20
>  	dp->mmio =3D priv->mmio;
>  	dp->drm_dev =3D dev;
> +	dp->hpd_status =3D HIBMC_HPD_OUT;
> =20
>  	ret =3D hibmc_dp_hw_init(&priv->dp);

[Severity: High]
Does hardcoding the initial state to HIBMC_HPD_OUT without checking the
actual hardware register contribute to the boot-time detection issue
mentioned in hibmc_dp_detect() above?

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gp=
u/drm/hisilicon/hibmc/hibmc_drm_drv.c
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -63,6 +63,7 @@ static irqreturn_t hibmc_dp_interrupt(int irq, void *ar=
g)
>  	status =3D readl(priv->mmio + HIBMC_DP_INTSTAT);
>  	if (status) {
>  		priv->dp.irq_status =3D status;
> +		priv->dp.hpd_status =3D hibmc_dp_get_hpd_status(&priv->dp);
>  		writel(status, priv->mmio + HIBMC_DP_INTCLR);

[Severity: High]
This is a pre-existing issue, but as mentioned above, if hibmc_dp_init() was
skipped and the DP block is uninitialized, does calling
hibmc_dp_get_hpd_status() here result in a NULL pointer dereference on
dp->dp_dev?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714132051.9933=
56-1-shiyongbang@huawei.com?part=3D1
