Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACE5C61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:00:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADDA910E28E;
	Mon, 31 Aug 2026 10:00:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bAjx0Vwl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8C4D10E287
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 10:00:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5D92A60200;
 Mon, 31 Aug 2026 10:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADB41F000E9;
 Mon, 31 Aug 2026 10:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788170450;
 bh=rc+W6G0p2gvYcacPRvTK9WxCgKP+00fS4xVYWHCaL2g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bAjx0Vwl9PEXwNsSlKVGlW0+u2SuLQ/JV5cuW/to3Jx+iiMrxX6yB6+feMuuUA9i9
 GetACCpLgC/JCv2ekEEXcofOGMHFfAye5RhJDEjW6/H5S86dluLLKW7/3pCnEOnVKb
 mx6/gKoT70M2w8N+aqpzM39ImHdVh0ODmHF+Uzh8mrD1MnoqR8Zz5+at8fz2e83C0r
 HFm+NxStGoj6+bZ7xEJ4Dm4gtOvnvMMQ5vksDK1iXXsjKFz3XXHaxUeIh95UEjqNWW
 5oWb8crF0GNyS63okNGMA+nbrNX+0Y+pm3d4BXy8jYIVBATDsfpyEeRFEM5MqURJuF
 jiKK1E/XCCuJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 24/29] drm/msm/dp: add HPD callback for dp MST
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-msm-dp-mst-v6-24-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-24-c91d35d6fb9e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:00:49 +0000
Message-Id: <20260831100049.DADB41F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Use-After-Free of `mst` structure in MST HPD IRQ handler after=
 DRM component unbind.
- [High] MST HPD IRQ handler reads ESI exactly once (no loop) and ignores l=
ink status updates (ESI[3]), breaking link recovery.
- [Medium] TOCTOU data race on `dp->plugged` and `mst_active` causes droppe=
d hotplug events.
--

commit 72fee25edd59966ac66b4a97ac13198745881f5c
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
   =20
drm/msm/dp: add HPD callback for dp MST
   =20
This patch adds HPD callback handling for the MST module, which is invoked =
from
the dp_display's HPD handler. It routes HPD messages to the MST module when
MST is active.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index c015af8688013..22b9252774620 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -416,6 +416,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_displ=
ay_private *dp)
>  			dp->msm_dp_display.connector_type,
>  			dp->link->sink_count);
> =20
> +	if (dp->plugged && dp->msm_dp_display.mst_active)
> +		return 0;
> +
>  	guard(mutex)(&dp->plugged_lock);

[Severity: Medium]
Could reading dp->plugged and mst_active outside of dp->plugged_lock cause a
race condition?

If a rapid plug/unplug sequence occurs, msm_dp_hpd_plug_handle() and
msm_dp_hpd_unplug_handle() could execute concurrently. If the unplug handler
holds the lock, the plug handler might see dp->plugged as true and return
early, skipping initialization. After the unplug handler finishes and sets
dp->plugged to false, the display would be physically plugged in but
uninitialized in software.

> =20
>  	ret =3D pm_runtime_resume_and_get(&pdev->dev);
[ ... ]
> @@ -506,12 +509,18 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_disp=
lay_private *dp)
>  {
>  	u32 sink_request;
>  	int rc =3D 0;
> +	struct msm_dp *msm_dp_display =3D &dp->msm_dp_display;
> =20
>  	/* irq_hpd can happen at either connected or disconnected state */
>  	drm_dbg_dp(dp->drm_dev, "Before, type=3D%d, sink_count=3D%d\n",
>  			dp->msm_dp_display.connector_type,
>  			dp->link->sink_count);
> =20
> +	if (msm_dp_display->mst_active) {
> +		msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
> +		return 0;
> +	}
> +

[Severity: High]
Does returning early here when MST is active bypass standard DP link loss a=
nd
test request processing?

In SST mode, msm_dp_link_process_request() handles DP link service IRQ
vectors (like link loss). When mst_active is true, this path is entirely
skipped, and it does not appear that msm_dp_mst_display_hpd_irq() handles
link status updates.

>  	/* check for any test request issued by sink */
>  	rc =3D msm_dp_link_process_request(dp->link);
>  	if (!rc) {
[ ... ]
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp=
/dp_mst_drm.c
> index 03f9c95ca6860..2e625a7db9819 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
[ ... ]
> @@ -326,6 +328,39 @@ int msm_dp_mst_attach_encoder(struct msm_dp *dp_disp=
lay, unsigned int stream_id,
>  	return 0;
>  }
> =20
> +void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
> +{
> +	int rc;
> +	struct msm_dp_mst *mst =3D dp_display->msm_dp_mst;
> +	u8 ack[8] =3D {};
> +	u8 esi[4];
> +	unsigned int esi_res =3D DP_SINK_COUNT_ESI + 1;
> +	bool handled;
> +
> +	guard(mutex)(&mst->hpd_irq_lock);

[Severity: Critical]
Can this dereference a freed mst pointer if the DRM master is unbound?

The mst structure is allocated with devm_kzalloc(dev->dev, ...) during
initialization. If the DRM master module is unloaded, devres will free this
memory.=20

However, if the DP IRQ was requested on the component device and remains
active, and mst_active isn't cleared, an incoming HPD interrupt could be
routed here, causing a use-after-free when locking mst->hpd_irq_lock.

> +
> +	rc =3D drm_dp_dpcd_read_data(mst->dp_aux, DP_SINK_COUNT_ESI, esi, 4);
> +	if (rc < 0) {
> +		DRM_ERROR("DPCD sink status read failed, rlen=3D%d\n", rc);
> +		return;
> +	}
> +
> +	drm_dbg_dp(dp_display->drm_dev, "MST HPD IRQ: esi=3D%*ph\n", 4, esi);
> +
> +	rc =3D drm_dp_mst_hpd_irq_handle_event(&mst->mst_mgr, esi, ack, &handle=
d);
> +
> +	if (handled) {
> +		rc =3D drm_dp_dpcd_write_byte(mst->dp_aux, esi_res, ack[1]);

[Severity: High]
Does this logic ignore link status updates and subsequent ESI messages?

The DP specification requires reading the ESI repeatedly until all status b=
its
are clear. This function reads the ESI exactly once, ignoring any subsequent
messages.

Additionally, this function only passes esi to
drm_dp_mst_hpd_irq_handle_event(). Because the legacy link processing in
msm_dp_irq_hpd_handle() is completely bypassed when mst_active is true,
esi[3] (DP_LINK_SERVICE_IRQ_VECTOR_ESI0) is entirely ignored. This means
the source could fail to detect link loss during MST operation and fail to
retrain the link.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-msm-dp-mst=
-v6-0-c91d35d6fb9e@oss.qualcomm.com?part=3D24
