Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3460AC9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 08:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E69310F3AE;
	Thu, 24 Sep 2026 08:30:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WXgUtN2d";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B549310F3AE
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 08:30:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6CA7C43F51;
 Thu, 24 Sep 2026 08:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F441F000FF;
 Thu, 24 Sep 2026 08:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790238602;
 bh=aHJvEvZz6S0MxpYCQyVK0/h1JWL/qCyhf/wE1atn0oY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WXgUtN2dlMIOl6xb84AvXh1WK2rosO5TTTEO+v3Gvw+kFJ8QIDmbjFRmq3UnJLl1S
 d5Kb0A8xpchHQodygGtFAvtJ/Jq0PZjZOo5vI0RWBqpjx4U0p9PghgXsQdQm8siCCi
 Cd84aah9gqb4XZoqZPLgk98DCKm64dgzz+AuNVKKNJBEK8DAuSMWQB/fFiHmEYqPXO
 9peNvLl90Epnk8yPOU8z7NLEZTGcZSO6BzKr8wGnuw7TlvtNGFlHG/yJhVMQ5v2mWn
 4dIIrf16qGqZ+kHgRSZkNqmTQw7CeKURyzDZd9Zmp0+qrg897cEWbUV3kumRTPQsnX
 z3ZJRfqcBrYNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for drm-misc-fixes v3 1/2] drm/hisilicon/hibmc: Modify
 the method of obtaining the hpd_status
To: "Yongbang Shi" <shiyongbang@huawei.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260924080609.3681795-2-shiyongbang@huawei.com>
References: <20260924080609.3681795-1-shiyongbang@huawei.com>
 <20260924080609.3681795-2-shiyongbang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 08:30:01 +0000
Message-Id: <20260924083002.24F441F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/hisilicon: Hardcoded initial HPD_OUT state breaks boot display=
 detection
- [High] drm/hisilicon: Removal of HPD debounce causes DPCD read failures o=
n hotplug
- [Medium] drm/hisilicon: Early exit in encoder_enable breaks KMS forced mo=
desets
- [Low] drm/hisilicon: Data race on dp->hpd_status between hardirq and proc=
ess contexts
--

commit 19dc442443127128a0c2f9bcb0ceca722bb81f14
Author: Lin He <helin52@huawei.com>

drm/hisilicon/hibmc: Modify the method of obtaining the hpd_status

This commit replaces the polling mechanism in the lower half of the HPD
interrupt with a direct read of the interrupt status in the upper half.
It also skips detection and training if the status is not HPD_IN, and
initializes the state to HPD_OUT.

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm=
/hisilicon/hibmc/dp/dp_hw.c
> index d5bd3c45649b2..a4cd4cd8cc75e 100644
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
> +	int hpd_status =3D HIBMC_HPD_UNKNOWN;
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
> +	switch (status) {
> +	case 0: /* idle */
> +	case 3: /* unplug */
> +	case 4: /* unplug intermediate */
> +		hpd_status =3D HIBMC_HPD_OUT;
> +		break;
> +	case 1: /* plug */
> +	case 2: /* plug intermediate */
> +		hpd_status =3D HIBMC_HPD_IN;

[Severity: High]
Does mapping the 'plug intermediate' state (value 2) directly to HIBMC_HPD_=
IN
without the previous 100ms debounce loop cause DPCD read failures?=20

When the link is physically bouncing during a hotplug event, returning
HIBMC_HPD_IN immediately schedules hibmc_dp_detect(). The immediate AUX
transaction in hibmc_dp_get_dpcd() can then fail because the connection has
not stabilized, causing the hotplug event to be dropped.

> +		break;
> +	default:
> +		break;
>  	}
> =20
> -	dp->dp_dev->hpd_status =3D exp_status;
> -
> -	return true;
>  }
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu=
/drm/hisilicon/hibmc/hibmc_drm_dp.c
> index 2e9403b8bf3c8..1f8ea0b092537 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
[ ... ]
> @@ -63,11 +61,10 @@ static int hibmc_dp_detect(struct drm_connector *conn=
ector,
>  	struct hibmc_dp_dev *dp_dev =3D dp->dp_dev;
>  	int ret =3D connector_status_disconnected;
> =20
> -	if (dp->irq_status) {
> -		if (dp_dev->hpd_status !=3D HIBMC_HPD_IN) {
> -			ret =3D connector_status_disconnected;
> -			goto exit;
> -		}
> +	if (dp->hpd_status !=3D HIBMC_HPD_IN) {

[Severity: Low]
Is there a theoretical data race here when reading dp->hpd_status?=20

It appears to be modified in hardirq context by hibmc_dp_interrupt() and re=
ad
here in process context without WRITE_ONCE()/READ_ONCE() annotations or
locking.

> +		drm_dbg_dp(dp->drm_dev, "dp detect skipped, hpd (%d)\n",
> +			   dp->hpd_status);
> +		goto exit;
>  	}
> =20
>  	if (!hibmc_dp_get_dpcd(dp_dev)) {
[ ... ]
> @@ -166,6 +163,12 @@ static void hibmc_dp_encoder_enable(struct drm_encod=
er *drm_encoder,
>  	struct hibmc_dp *dp =3D container_of(drm_encoder, struct hibmc_dp, enco=
der);
>  	struct drm_display_mode *mode =3D &drm_encoder->crtc->state->mode;
> =20
> +	if (dp->hpd_status !=3D HIBMC_HPD_IN) {

[Severity: Medium]
Does this early exit break KMS forced modesets?=20

If a user overrides the connector to 'connected' (e.g., via sysfs or kernel
command line) and the DRM core attempts an atomic commit, this check will
refuse to program the hardware. This would desynchronize the KMS software
state from the actual hardware state.

> +		drm_dbg_dp(dp->drm_dev, "dp encoder enable skipped, hpd (%d)\n",
> +			   dp->hpd_status);
> +		return;
> +	}
> +
>  	if (hibmc_dp_prepare(dp, mode))
>  		return;
[ ... ]
> @@ -223,6 +228,7 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
> =20
>  	dp->mmio =3D priv->mmio;
>  	dp->drm_dev =3D dev;
> +	dp->hpd_status =3D HIBMC_HPD_OUT;

[Severity: High]
Will hardcoding the initial state to HIBMC_HPD_OUT break display detection
at boot?=20

During boot, drm_client_setup() runs detect() before or immediately after
interrupts are enabled in late_register(). Because detect() no longer queri=
es
the live hardware register and relies only on this cached value, it will re=
ad
HPD_OUT and silently force a disconnected state even if a monitor is already
connected.

> =20
>  	ret =3D hibmc_dp_hw_init(&priv->dp);
>  	if (ret) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924080609.3681=
795-1-shiyongbang@huawei.com?part=3D1
