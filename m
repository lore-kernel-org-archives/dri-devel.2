Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7725AC4452F
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 13:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE77410E77F;
	Tue, 21 Jul 2026 13:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fhfQUPYH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD11610E77F
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:06:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C67EB406E2;
 Tue, 21 Jul 2026 13:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893D31F000E9;
 Tue, 21 Jul 2026 13:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784639204;
 bh=PHLB/yvqcDofwl8fAeuAAEqEck7vhTcu0WcSQanxzEk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fhfQUPYH0U7OPw2S/1MIYnMqpRrABuW9WyysfLEWaKRMIrPuXs9iX8bGqgtpgROSI
 RPJs83NU7LycRHUItQR1oOej1Qz+Y5axvY9aBNFvXeeIT4nNji9rYlfEPVLBSsHjRA
 5abEEpag9+HhFXmSkDosDPO1R5ezCFLj+308zhMT5nHYHDIyQtXX6RFIZ29jfJCGny
 nQAKxyFtsBCbeA64k1MjABfC4DpDb59zDngqT5Cma1YI6FEkrzRDqVz76Sxj/2DiM/
 HPuiGJMGPW9avRx95wspSG0M98Utkh0MAD10VqIdbcsyHwzqn3VYLH6b2+85X26ulk
 VyL58wE9ZJUAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for drm-misc-fixes v2 1/2] drm/hisilicon/hibmc: Modify
 the method of obtaining the hpd_status
To: "Yongbang Shi" <shiyongbang@huawei.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721124324.1885856-2-shiyongbang@huawei.com>
References: <20260721124324.1885856-1-shiyongbang@huawei.com>
 <20260721124324.1885856-2-shiyongbang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 13:06:44 +0000
Message-Id: <20260721130644.893D31F000E9@smtp.kernel.org>
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
- [High] Hardcoded initial HPD status breaks display detection for pre-conn=
ected monitors and ignores `force` probes.
- [High] Silently aborting `encoder_enable` when HPD is not IN breaks DRM a=
tomic state guarantees.
- [High] State overwriting and TOCTOU races between hardirq and threaded ha=
ndlers drop legitimate HPD events.
- [Medium] Instantaneous hardware read replaces 100ms debouncing loop, caus=
ing hotplug events to be dropped on contact bounce.

Pre-existing issues:
- [High] Unconditional NULL pointer dereference in the hard IRQ handler if =
DP initialization is skipped or fails.
--

--- Patch [1]: [PATCH for drm-misc-fixes v2 1/2] drm/hisilicon/hibmc: Modif=
y the method of obtaining the hpd_status ---
commit 9a953a788498e9cd1859698ff0b7eabd2a8009b2
Author: Lin He <helin52@huawei.com>

drm/hisilicon/hibmc: Modify the method of obtaining the hpd_status

To more accurately determine whether the current HPD status matches the
interrupt status, the polling mechanism in the lower half of the HPD
interrupt has been replaced with directly retrieving the interrupt
status in the upper half of the interrupt.

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm=
/hisilicon/hibmc/dp/dp_hw.c
> index d5bd3c45649b2..c9a113a1937d3 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
[ ... ]
> @@ -322,20 +326,26 @@ void hibmc_dp_set_cbar(struct hibmc_dp *dp, const s=
truct hibmc_dp_cbar_cfg *cfg)
>  	writel(HIBMC_DP_SYNC_EN_MASK, dp_dev->base + HIBMC_DP_TIMING_SYNC_CTRL);
>  }
> =20
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
This is a pre-existing issue, but does this code dereference a potentially
NULL pointer?

If DP initialization is skipped or fails, dp->dp_dev remains NULL. However,
hibmc_msi_init() unconditionally requests the DP interrupt. If the unclocked
DP hardware returns 0xFFFFFFFF when HIBMC_DP_INTSTAT is read, the hardirq
handler unconditionally calls hibmc_dp_get_hpd_status(), which dereferences
dp->dp_dev->base, potentially causing a panic.

[Severity: Medium]
Does replacing the 100ms debouncing loop with a single instantaneous read
cause hotplug events to be dropped due to contact bounce?

The DP specification mandates debouncing because physical hotplugs suffer f=
rom
mechanical bouncing. By removing the poll and taking a single instantaneous
read in the hardirq handler, the hardware read may capture an intermediate
state. The threaded ISR then compares irq_status against this incorrectly
sampled state and drops the event entirely if they do not match.

> +	switch (status) {
> +	case 0: /* idle */
[ ... ]
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu=
/drm/hisilicon/hibmc/hibmc_drm_dp.c
> index 2e9403b8bf3c8..23716d48149f2 100644
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
Does this hardcoded check ignore force probes and pre-connected monitors?

Because dp->hpd_status is initialized to HIBMC_HPD_OUT and relies entirely =
on
edge-triggered interrupts to update it, a monitor connected prior to boot
will not trigger an edge interrupt. This causes hibmc_dp_detect() to
unconditionally return connector_status_disconnected, ignoring the actual
hardware state.

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
Does silently aborting hardware enablement here break DRM atomic state
guarantees?

If userspace explicitly forces a disconnected connector to ON (e.g. via
xrandr), the DRM framework commits the atomic state and expects the driver =
to
enable the hardware pipeline. Silently returning from
hibmc_dp_encoder_enable() leaves the hardware disabled while the software
state tracks it as enabled, which can cause subsequent operations to fail
or time out.

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

[Severity: High]
Can a race condition between the hardirq handler and this threaded handler
cause legitimate HPD events to be permanently lost?

The threaded handler first reads a snapshot of priv->dp.hpd_status into the
status variable, then checks priv->dp.irq_status. If a new interrupt preemp=
ts
the threaded handler between these two reads, the hardirq handler updates
priv->dp.irq_status and priv->dp.hpd_status using direct assignments instead
of bitwise accumulation. This mismatch causes the threaded handler to fail
its state consistency check and completely drop the hotplug event.

>  		drm_dbg_dp(&priv->dev, "HPD IN isr occur!\n");
> +		if (status !=3D HIBMC_HPD_IN) {
> +			drm_err(&priv->dev, "HPD status (%d) error", status);
> +			goto exit;
> +		}
>  		hibmc_dp_hpd_cfg(&priv->dp);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721124324.1885=
856-1-shiyongbang@huawei.com?part=3D1
