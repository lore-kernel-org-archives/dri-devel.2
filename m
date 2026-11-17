Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CBF606A330
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZVOzoMqv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FE3D10E605;
	Tue, 17 Nov 2026 13:36:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C15F10E605
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:36:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E48DD435B8;
 Tue, 17 Nov 2026 13:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A881E1F000C4;
 Tue, 17 Nov 2026 13:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794922564;
 bh=SwPOniVYJ4ZBxuXgUQj7keGzB4GvezH5upoVj2xyPZY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZVOzoMqvDWyVMGIPPs3T4PJtPa12JsyrYiOtvFOaqMuriSIFXOuohMOPbVO4shS5f
 6XIYkdJAsP3IvffYcT7KxKGlg9UZtleh59sWH5Bqeme1r5zsS/4+mFcg/bJ+2rM8ai
 osiXwwSCpsb5CFuRbY8wLacqG4k21CglcJdxX96JGRVU+lGnpPGpcd06MyZOESh+f2
 q12xhP0jo6VOe0mc+CmQLrrO0B7xhhCzfxYKs7uRJHDGoWohXMtgQZFd430sWLnDP+
 FwI1y5N+gzo5Gtbhna/XAznJKbB/xCjVKJAZmy/xsvK4/BTJ592AQTMXhHpfjQveX5
 HWkNfZaCKpSvQ==
Message-ID: <sashiko-outbox-218888@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for drm-misc-fixes v5 1/2] drm/hisilicon/hibmc: Modify
 the method of obtaining the hpd_status
To: "Yongbang Shi" <shiyongbang@huawei.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261117130056.272609-2-shiyongbang@huawei.com>
References: <20261117130056.272609-1-shiyongbang@huawei.com>
 <20261117130056.272609-2-shiyongbang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 13:36:04 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/hisilicon/hibmc: lost hotplug event on unplug+plug in
  hibmc_dp_hpd_isr()
- [Medium] drm/hisilicon/hibmc: stale HIBMC_HPD_OUT breaks detect in
  hibmc_dp_detect()
- [Medium] drm/hisilicon/hibmc: race on link.status in
  hibmc_dp_reset_link()
--

commit 66c780066116f4c8c3ae6a3396cdf80d86327a1d
Author: Lin He <helin52@huawei.com>

drm/hisilicon/hibmc: Modify the method of obtaining the hpd_status

This commit replaces HPD status polling in the threaded IRQ handler with
reading the HPD state in the hardirq handler, skips connector detection
when hpd_status is not HIBMC_HPD_IN, and resets link status on unplug in
hardirq context.

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu=
/drm/hisilicon/hibmc/hibmc_drm_dp.c
> index 9cf0b6be15bdc..245d6b9e2836a 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
[ ... ]
> @@ -60,13 +58,13 @@ static int hibmc_dp_detect(struct drm_connector *conn=
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

[Severity: Medium]
Does unconditionally gating hibmc_dp_detect() on dp->hpd_status =3D=3D
HIBMC_HPD_IN break detection when dp->hpd_status has not been updated by
hibmc_dp_interrupt()?

hibmc_dp_init() sets dp->hpd_status to HIBMC_HPD_OUT, and only
hibmc_dp_interrupt() ever updates it.  If pci_alloc_irq_vectors() in
hibmc_msi_init() allocates only HIBMC_MIN_VECTORS (1), the HPD MSI handler
is never registered and dp->hpd_status stays HIBMC_HPD_OUT forever.  Even
with two MSI vectors, detection before the initial HPD MSI and threaded
handler complete after hibmc_dp_late_register(), or after a monitor change
across system suspend/resume, sees a stale dp->hpd_status and reports
connector_status_disconnected.

> @@ -188,24 +186,26 @@ irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
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
> +		/* Plug takes aux_lock, so it must run in the thread. */
>  		drm_dbg_dp(&priv->dev, "HPD IN isr occur!\n");
>  		hibmc_dp_hpd_cfg(&priv->dp);
> -		exp_status =3D HIBMC_HPD_IN;
> -	} else {
> +	} else if (status =3D=3D HIBMC_HPD_OUT) {
>  		drm_dbg_dp(&priv->dev, "HPD OUT isr occur!\n");
> -		hibmc_dp_reset_link(&priv->dp);
> -		exp_status =3D HIBMC_HPD_OUT;
> +	} else {
> +		drm_err(&priv->dev, "HPD status (%d) error\n", status);
> +		goto exit;
>  	}
> =20
> -	if (hibmc_dp_check_hpd_status(&priv->dp, exp_status))
> -		drm_connector_helper_hpd_irq_event(&priv->dp.connector);
> +	drm_connector_helper_hpd_irq_event(&priv->dp.connector);

[Severity: Medium]
Can an unplug followed by a plug before hibmc_dp_hpd_isr() runs still
drop the hotplug event and leave the DP link untrained?

<hardirq>                         irq/hpd
hibmc_dp_interrupt() [unplug]
  priv->dp.hpd_status =3D HIBMC_HPD_OUT
  hibmc_dp_reset_link()
    channel_equalized =3D false
hibmc_dp_interrupt() [plug]
  priv->dp.hpd_status =3D HIBMC_HPD_IN
                                  hibmc_dp_hpd_isr()
                                    drm_connector_helper_hpd_irq_event()
                                      check_connector_changed()
                                        hibmc_dp_detect() -> connected
                                        old_epoch_counter =3D=3D epoch_coun=
ter
                                        return false  <-- event dropped

Because hibmc_dp_detect() never ran while dp->hpd_status was
HIBMC_HPD_OUT, connector->status was already connector_status_connected,
so drm_helper_probe_detect_ctx() does not increment
connector->epoch_counter and drm_connector_helper_hpd_irq_event() sends no
hotplug event.  Since hibmc_dp_link_training() is only called from
hibmc_dp_mode_set(), clearing channel_equalized in hibmc_dp_reset_link()
without triggering a modeset or re-training leaves the display with an
untrained link.

Also, if hibmc_dp_hpd_isr() reads status =3D=3D HIBMC_HPD_OUT at entry and a
plug hardirq updates dp->hpd_status to HIBMC_HPD_IN before
hibmc_dp_detect() runs, hibmc_dp_detect() performs DPCD AUX transfers
before hibmc_dp_hpd_cfg() has configured the AUX block; and if both unplug
and plug latch before hibmc_dp_interrupt() reads HIBMC_DP_HPD_STATUS,
hibmc_dp_get_hpd_status() returns HIBMC_HPD_IN and skips
hibmc_dp_reset_link() while clearing both interrupt bits.

> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gp=
u/drm/hisilicon/hibmc/hibmc_drm_drv.c
> index 602930964e930..a110b5e15e596 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
> @@ -59,11 +59,18 @@ static irqreturn_t hibmc_dp_interrupt(int irq, void *=
arg)
>  {
>  	struct drm_device *dev =3D (struct drm_device *)arg;
>  	struct hibmc_drm_private *priv =3D to_hibmc_drm_private(dev);
> +	int hpd_status;
>  	u32 status;
> =20
>  	status =3D readl(priv->mmio + HIBMC_DP_INTSTAT);
>  	if (status) {
> -		priv->dp.irq_status =3D status;
> +		hpd_status =3D hibmc_dp_get_hpd_status(&priv->dp);
> +		WRITE_ONCE(priv->dp.hpd_status, hpd_status);
> +
> +		/* Reset here so a later plug cannot hide this unplug. */
> +		if (hpd_status =3D=3D HIBMC_HPD_OUT)
> +			hibmc_dp_reset_link(&priv->dp);

[Severity: Medium]
Can hibmc_dp_reset_link() in hardirq context race with
hibmc_dp_link_training_channel_eq() and leave
dp_dev->link.status.channel_equalized set to true after an unplug?

hibmc_dp_mode_set()
  hibmc_dp_link_training()
    hibmc_dp_link_training_channel_eq()
      drm_dp_dpcd_read_link_status(..., lane_status)
      <hardirq>
        hibmc_dp_interrupt()
          hibmc_dp_reset_link()
            channel_equalized =3D false
      if (drm_dp_channel_eq_ok(lane_status, ...))
        channel_equalized =3D true  <-- overwrites unplug reset

hibmc_dp_link_training_channel_eq() then returns 0 using the pre-unplug
lane_status, leaving channel_equalized true so subsequent
hibmc_dp_mode_set() calls skip link training.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117130056.2726=
09-1-shiyongbang@huawei.com?part=3D1
