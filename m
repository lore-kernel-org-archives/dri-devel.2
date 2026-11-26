Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747A4606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 03:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UOuJUe5K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABB9110E1D4;
	Thu, 26 Nov 2026 03:32:28 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B3310E1D4
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 03:32:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 470996156B;
 Thu, 26 Nov 2026 03:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BCD1F000D0;
 Thu, 26 Nov 2026 03:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795663940;
 bh=3XHTG7oc3cstLVMLcCGKLyaS/u3JyQy0V6hxWUqHu80=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UOuJUe5KdZd4hGNHZkitoo43QkdhSm/HevUCTGKzMgz6YiGUncLdW1jDEmM+WkOfB
 +XJ+TPKsF/gs1c1HwjYsRxbdZWct554gJP/aIf17R714wsu4RhpDRp9irNYI+G5BIJ
 MlB5PDAdbH/jNI1Leevf3alW0769+N4P08KHSO1ew4Qou8AUeZ/ubY+YYhhRJjuBuO
 Pr3Xq70beNgsRnR2I4bwmcIjcEfkgoID7+tlyL8erNCxTcGzcsHcmI3xotOKWsP47+
 usHTCsfKfpWPrtKXVIgmQ9a0JgT7iODL9pAmoPLL/6XpcKy4C7gMvcfYlDez1KZQLO
 Y4Wckcz6ZHjzw==
Message-ID: <sashiko-outbox-234699@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for drm-misc-fixes v6 1/2] drm/hisilicon/hibmc: Modify
 the method of obtaining the hpd_status
To: "Yongbang Shi" <shiyongbang@huawei.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126030648.3231196-2-shiyongbang@huawei.com>
References: <20261126030648.3231196-1-shiyongbang@huawei.com>
 <20261126030648.3231196-2-shiyongbang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 03:32:20 +0000
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
- [Medium] drm/hisilicon/hibmc: race on link.status in
  hibmc_dp_reset_link()
- [Medium] drm/hisilicon/hibmc: stale HIBMC_HPD_OUT breaks
  hibmc_dp_detect()
--

commit be71ebe3ac9a8ced23cdd19669fbac348e9d77c8
Author: Lin He <helin52@huawei.com>

drm/hisilicon/hibmc: Modify the method of obtaining the hpd_status

This commit samples the DisplayPort HPD state in the hardirq handler
hibmc_dp_interrupt() via hibmc_dp_get_hpd_status() instead of polling in
the threaded handler, and serializes AUX transfers against
hibmc_dp_hpd_cfg() with aux_lock.

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
Can dp->hpd_status remain stuck at HIBMC_HPD_OUT when hibmc_dp_detect()
runs, causing connected monitors to be reported as disconnected?

Previously, hibmc_dp_detect() only checked hpd_status after an HPD
interrupt had set dp->irq_status, and otherwise probed DPCD directly.
Now hibmc_dp_init() sets dp->hpd_status =3D HIBMC_HPD_OUT,
hibmc_dp_hw_init() sleeps 100 ms with HIBMC_DP_INTR_ENABLE masked without
calling hibmc_dp_get_hpd_status(), and only hibmc_dp_interrupt() ever
updates dp->hpd_status.

If pci_alloc_irq_vectors() in hibmc_msi_init() only allocates
HIBMC_MIN_VECTORS (1 vector), only the vblank interrupt is requested and
hibmc_dp_interrupt() is never registered, leaving dp->hpd_status at
HIBMC_HPD_OUT permanently.  dp->hpd_status is also not refreshed across
hibmc_pm_suspend() and hibmc_pm_resume() if a monitor is connected or
disconnected while suspended, or if connector detection runs during
registration before the HPD MSI fires.

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
Can an unplug followed by a plug before hibmc_dp_hpd_isr() runs still lose
the hotplug notification and leave the link untrained?

<hardirq>                             irq/hibmc-hpd
hibmc_dp_interrupt() [unplug]
  priv->dp.hpd_status =3D HIBMC_HPD_OUT
  hibmc_dp_reset_link(&priv->dp)
    channel_equalized =3D false
hibmc_dp_interrupt() [plug]
  priv->dp.hpd_status =3D HIBMC_HPD_IN
                                      hibmc_dp_hpd_isr()
                                        hibmc_dp_hpd_cfg()
                                        drm_connector_helper_hpd_irq_event()
                                          check_connector_changed()
                                            hibmc_dp_detect()
                                              returns connected
                                            old_status =3D=3D connected
                                            --> returns false (event droppe=
d)

Because hibmc_dp_detect() never ran while priv->dp.hpd_status was
HIBMC_HPD_OUT, connector->status is still connector_status_connected when
hibmc_dp_detect() runs for the new plug.  drm_helper_probe_detect_ctx()
only increments connector->epoch_counter when the status changes, so
check_connector_changed() returns false and
drm_connector_helper_hpd_irq_event() suppresses the hotplug event.
Without a hotplug event to trigger a modeset, hibmc_dp_mode_set() does not
run to re-train the link after hibmc_dp_reset_link() cleared
channel_equalized.

Also, if hibmc_dp_hpd_isr() reads status =3D=3D HIBMC_HPD_OUT at entry and =
the
plug hardirq updates priv->dp.hpd_status to HIBMC_HPD_IN before
hibmc_dp_detect() runs, hibmc_dp_detect() will perform DPCD AUX reads for
the newly plugged sink without hibmc_dp_hpd_cfg() having configured the
AUX and DPTX registers first.

[ ... ]

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
Can calling hibmc_dp_reset_link() from hardirq context race with ongoing
link training in hibmc_dp_mode_set()?

hibmc_dp_mode_set()
  hibmc_dp_link_training()
    hibmc_dp_link_training_channel_eq()
      drm_dp_dpcd_read_link_status(dp->aux, lane_status)
      <hardirq>
        hibmc_dp_interrupt()
          hibmc_dp_reset_link(&priv->dp)
            dp->link.status.clock_recovered =3D false
            dp->link.status.channel_equalized =3D false
      if (drm_dp_channel_eq_ok(lane_status, ...))
        dp->link.status.channel_equalized =3D true  <-- overwrites reset

hibmc_dp_reset_link() and hibmc_dp_link_training_channel_eq() update
dp->link.status without synchronization.  If an unplug interrupt arrives
just after drm_dp_dpcd_read_link_status() finishes,
hibmc_dp_link_training_channel_eq() sets channel_equalized back to true
from the pre-unplug lane_status.  Because hibmc_dp_reset_link() only runs
on HIBMC_HPD_OUT, channel_equalized stays true across a subsequent plug,
and hibmc_dp_mode_set() skips hibmc_dp_link_training().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126030648.3231=
196-1-shiyongbang@huawei.com?part=3D1
