Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6A1606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bg+A94k5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2706E10ED18;
	Mon, 26 Oct 2026 09:28:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32D5E10ED15
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:28:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E3CD74126C;
 Mon, 26 Oct 2026 09:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B014C1F031E6;
 Mon, 26 Oct 2026 09:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793006901;
 bh=cutGszaFuMZo9I3EsyW/mE6CTYiecWpcL1sQApXc/RE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Bg+A94k5GZOPBebSdkzW61ARZclfbjBKNNcaV0PWoXkrI/EGy7HTeycIAQSSSfIND
 mEismJkNOvFDutIVKFABgZwgjQEOpdDVgzinMG/aJPd6DBcgGZjLpNQxOZ9NSka96w
 5AXngrgdAHE4iM9CDgMPa7X+c9AU8XEkBwlFYIFdDinKqJ72icSeZlxnIcosO4/IB+
 Bf//SUQO8IGyn9idRA/3ySQLtUO2gcQ+HrwGdF2cvi59101XyhIHIgZEhFDHvh+shn
 Shg0NgvB4wyiqsOwz9IsMWxkY0i4FAkPijJi5D3hyH0bZ4csIwyXZSPSohK9oYbWzw
 4KvS9F41fd1nw==
Message-ID: <sashiko-outbox-184790@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for drm-misc-fixes v4 1/2] drm/hisilicon/hibmc: Modify
 the method of obtaining the hpd_status
To: "Yongbang Shi" <shiyongbang@huawei.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261026060303.289737-2-shiyongbang@huawei.com>
References: <20261026060303.289737-1-shiyongbang@huawei.com>
 <20261026060303.289737-2-shiyongbang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 09:28:21 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/hisilicon/hibmc: lost HPD transitions between hardirq and thre=
aded ISR
- [Medium] drm/hisilicon/hibmc: race between hibmc_dp_hpd_cfg() and AUX tra=
nsfers
--

commit bbfebdb6730a49d33c7743f617c2581bd1dabe95
Author: Lin He <helin52@huawei.com>

drm/hisilicon/hibmc: Modify the method of obtaining the hpd_status

This commit replaces the HPD status polling in the threaded interrupt handl=
er
with reading HIBMC_DP_HPD_STATUS directly in the hardirq handler via
hibmc_dp_get_hpd_status(). It also initializes hpd_status to HIBMC_HPD_OUT =
and
skips connector detection when hpd_status is not HIBMC_HPD_IN.

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu=
/drm/hisilicon/hibmc/hibmc_drm_dp.c
> index 2e9403b8bf3c8..10290fd5f503f 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
[ ... ]
> @@ -61,13 +59,13 @@ static int hibmc_dp_detect(struct drm_connector *conn=
ector,
>  {
>  	struct hibmc_dp *dp =3D to_hibmc_dp(connector);
>  	struct hibmc_dp_dev *dp_dev =3D dp->dp_dev;
> +	int hpd_status =3D READ_ONCE(dp->hpd_status);
>  	int ret =3D connector_status_disconnected;
> =20
> -	if (dp->irq_status) {
> -		if (dp_dev->hpd_status !=3D HIBMC_HPD_IN) {
> -			ret =3D connector_status_disconnected;
> -			goto exit;
> -		}
> +	if (hpd_status !=3D HIBMC_HPD_IN) {
> +		drm_dbg_dp(dp->drm_dev, "dp detect skipped, hpd (%d)\n",
> +			   hpd_status);
> +		goto exit;
>  	}
> =20
>  	if (!hibmc_dp_get_dpcd(dp_dev)) {
> @@ -189,24 +187,26 @@ irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
>  {
>  	struct drm_device *dev =3D (struct drm_device *)arg;
>  	struct hibmc_drm_private *priv =3D to_hibmc_drm_private(dev);
> -	int idx, exp_status;
> +	int status =3D READ_ONCE(priv->dp.hpd_status);
> +	int idx;
> =20
>  	if (!drm_dev_enter(dev, &idx))
>  		return -ENODEV;
> =20
> -	if (priv->dp.irq_status & DP_MASKED_SINK_HPD_PLUG_INT) {
> +	if (status =3D=3D HIBMC_HPD_IN) {
>  		drm_dbg_dp(&priv->dev, "HPD IN isr occur!\n");
>  		hibmc_dp_hpd_cfg(&priv->dp);

[Severity: Medium]
Can hibmc_dp_hpd_cfg() race with active AUX transactions when
priv->dp.hpd_status is set to HIBMC_HPD_IN in the top-half handler before
hibmc_dp_hpd_isr() runs?

During hibmc_pci_probe(), hibmc_load() -> hibmc_dp_init() ->
hibmc_dp_hw_init() resets the DPTX block and sleeps 100 ms with msleep(100)
to latch the HPD interrupt. Next, drm_dev_register() calls
hibmc_dp_late_register() -> hibmc_dp_enable_int(), unmasking
HIBMC_DP_INTR_ENABLE. The latched HPD interrupt fires immediately in hardirq
context: hibmc_dp_interrupt() writes HIBMC_HPD_IN to priv->dp.hpd_status and
returns IRQ_WAKE_THREAD to schedule hibmc_dp_hpd_isr().

Right after drm_dev_register() returns, hibmc_pci_probe() calls
drm_client_setup() (or userspace calls GETCONNECTOR). Because
priv->dp.hpd_status is already HIBMC_HPD_IN, hibmc_dp_detect() proceeds into
hibmc_dp_get_dpcd(), hibmc_dp_connector_get_modes(), and
hibmc_dp_encoder_enable() -> hibmc_dp_mode_set() -> hibmc_dp_link_training(=
),
all of which perform AUX transfers via hibmc_dp_aux_xfer().

Concurrently, the IRQ thread hibmc_dp_hpd_isr() runs hibmc_dp_hpd_cfg()
without holding dev->mode_config.mutex or dp->aux.hw_mutex:

drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c:hibmc_dp_hpd_cfg() {
	hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_SYNC_L=
EN_SEL, 0x0);
	hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_TIMER_=
TIMEOUT, 0x1);
	hibmc_dp_reg_write_field(dp->dp_dev, HIBMC_DP_AUX_REQ, HIBMC_DP_CFG_AUX_MI=
N_PULSE_NUM, 0x9);
	...
	writel(HIBMC_DP_DPTX_RST, dp_dev->base + HIBMC_DP_DPTX_RST_CTRL);
}

In hibmc_dp_aux_xfer(), hibmc_dp_reg_write_field() sets HIBMC_DP_CFG_AUX_REQ
(BIT(0) of HIBMC_DP_AUX_REQ) to 1 under dp_dev->lock, then drops dp_dev->lo=
ck
and polls HIBMC_DP_AUX_REQ via readl_poll_timeout() until hardware clears
BIT(0). If hibmc_dp_hpd_cfg() performs its read-modify-writes on
HIBMC_DP_AUX_REQ while BIT(0) is 1 and writes the value back after hardware
clears BIT(0), it can re-trigger a spurious AUX transfer while
hibmc_dp_aux_xfer() reads the reply status/data, or mutate AUX timing fields
mid-transfer. Additionally, hibmc_dp_hpd_cfg() writes HIBMC_DP_DPTX_RST_CTRL
via raw writel() without holding dp_dev->lock, racing with the
read-modify-write in hibmc_dp_aux_reset().

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gp=
u/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 602930964e930..df4501bb076bc 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -63,7 +63,8 @@ static irqreturn_t hibmc_dp_interrupt(int irq, void *ar=
g)
> =20
>  	status =3D readl(priv->mmio + HIBMC_DP_INTSTAT);
>  	if (status) {
> -		priv->dp.irq_status =3D status;
> +		WRITE_ONCE(priv->dp.hpd_status,
> +			   hibmc_dp_get_hpd_status(&priv->dp));
>  		writel(status, priv->mmio + HIBMC_DP_INTCLR);
>  		return IRQ_WAKE_THREAD;
>  	}

[Severity: High]
Could overwriting the single priv->dp.hpd_status field in
hibmc_dp_interrupt() lose HPD transitions between the hardirq handler and
hibmc_dp_hpd_isr()?

First, in hibmc_dp_hpd_isr(), hibmc_dp_reset_link() is only called when
status =3D=3D HIBMC_HPD_OUT is observed by the threaded handler, and
hibmc_dp_reset_link() is the only place that resets
dp_dev->link.status.clock_recovered and channel_equalized to false. If an
HPD_OUT interrupt is followed by an HPD_IN interrupt before
hibmc_dp_hpd_isr() runs or while it is executing
drm_connector_helper_hpd_irq_event() (or if both unplug and plug bits are s=
et
in HIBMC_DP_INTSTAT when hibmc_dp_interrupt() runs), priv->dp.hpd_status is
overwritten with HIBMC_HPD_IN. Then hibmc_dp_hpd_isr() calls
hibmc_dp_hpd_cfg() without calling hibmc_dp_reset_link(), leaving
channel_equalized set to true so subsequent calls to hibmc_dp_mode_set() sk=
ip
hibmc_dp_link_training():

drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c:hibmc_dp_mode_set() {
	if (!dp_dev->link.status.channel_equalized) {
		ret =3D hibmc_dp_link_training(dp_dev);
		if (ret) {
			drm_err(dp->drm_dev, "dp link training failed, ret: %d\n", ret);
			return ret;
		}
	}
}

Second, when hibmc_dp_hpd_isr() handles HIBMC_HPD_IN, it calls
hibmc_dp_hpd_cfg() in threaded context:

drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c:hibmc_dp_hpd_cfg() {
	...
	writel(0, dp_dev->base + HIBMC_DP_INTR_ENABLE);
	writel(HIBMC_DP_INT_RST, dp_dev->base + HIBMC_DP_INTR_ORIGINAL_STATUS);
	writel(HIBMC_DP_INT_ENABLE, dp_dev->base + HIBMC_DP_INTR_ENABLE);
	...
}

Because HPD status is now sampled in hibmc_dp_interrupt() before
hibmc_dp_hpd_cfg() rather than after it, any unplug event that latches befo=
re
hibmc_dp_hpd_cfg() writes HIBMC_DP_INT_RST to HIBMC_DP_INTR_ORIGINAL_STATUS
(0x1e0728, the same register as HIBMC_DP_INTCLR) is cleared in hardware
without hibmc_dp_interrupt() updating priv->dp.hpd_status, leaving
priv->dp.hpd_status stuck at HIBMC_HPD_IN.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026060303.2897=
37-1-shiyongbang@huawei.com?part=3D1
