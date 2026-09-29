Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652A8C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B74A210ECDA;
	Tue, 29 Sep 2026 04:55:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aesn34Do";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B9A610ECDA
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:55:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8788B60210;
 Tue, 29 Sep 2026 04:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC631F000FF;
 Tue, 29 Sep 2026 04:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790657747;
 bh=kAIpyHnnTqbR+vXOejuiWFfsC7qZDjogJc9NIOqAS7M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aesn34DoxBBPabWAcKLANInYUHgOZWP/4rRKdWvsi5ryvqi22+q3HJr+xjk58DYxY
 YxlnRIe5j7wK0zO+ZAE39x867oPlFI6zHR7qejAhbVmUPxQNx53rrTmGDHhtOteFFM
 7ZnRBpcOV6OzjWLEq70ha00mRNAyZYO5AyAk4LYnEg4uy/7vmvoJWqhbvuFbJKuRvo
 6x26TXsQgrG7/WpaI/oOs6awbBwCLDq86Qvv8DY5eWbQqOGJmnp+FawFinVWMWtBFk
 HmLN92z3Gfux3lfagP7qt/B7JS+bW4X+hTQUVBqIZMO1JGy1Nfltk6Qx0RGfrp1aoq
 OothyW73GZISQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 27/35] drm/msm/dp: add HPD callback for dp MST
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-27-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-27-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:55:46 +0000
Message-Id: <20260929045547.1DC631F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm/dp: MST HPD IRQ handler ignores link retraining requests
--

commit ffbe0cc166ce3c30ce80d665c8cda6f1db08b01e
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: add HPD callback for dp MST
   =20
Add HPD callback for the MST module which shall be invoked from the
dp_display's HPD handler to perform MST specific operations in case
of HPD. In MST case, route the HPD messages to MST module.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 4a3ca1bf05a03..71c5e6bef02fc 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -516,12 +518,18 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_disp=
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
[Severity: High]
Does returning early here bypass msm_dp_link_process_request() for MST
links?

If the DisplayPort link loses synchronization, the sink requests link
retraining by issuing an HPD short pulse and setting the LINK_STATUS_CHANGED
bit in ESI[3]. By skipping msm_dp_link_process_request(), the driver fails
to retrain the link or check for compliance test requests.

Could this cause a permanent loss of display output (black screen) until the
display is physically replugged?

> +
>  	/* check for any test request issued by sink */
>  	rc =3D msm_dp_link_process_request(dp->link);
>  	if (!rc) {
[ ... ]
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp=
/dp_mst_drm.c
> index fd8fd6fd10bdf..4c0ad3dc57935 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
[ ... ]
> @@ -357,6 +361,40 @@ int msm_dp_mst_attach_encoder(struct msm_dp *dp_disp=
lay, unsigned int stream_id,
>  	return 0;
>  }
> =20
> +void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
> +{
> +	int rc;
> +	struct msm_dp_mst *mst =3D dp_display->msm_dp_mst;
> +	unsigned int esi_res =3D DP_SINK_COUNT_ESI + 1;
> +	int i;
> +
> +	guard(mutex)(&mst->hpd_irq_lock);
> +
> +	for (i =3D 0; i < MSM_DP_MST_HPD_IRQ_MAX_TRIES; i++) {
> +		u8 ack[8] =3D {};
> +		u8 esi[4];
> +		bool handled;
> +
> +		rc =3D drm_dp_dpcd_read_data(mst->dp_aux, DP_SINK_COUNT_ESI, esi, 4);
> +		if (rc < 0) {
> +			DRM_ERROR("DPCD sink status read failed, rlen=3D%d\n", rc);
> +			return;
> +		}
> +
> +		rc =3D drm_dp_mst_hpd_irq_handle_event(&mst->mst_mgr, esi, ack, &handl=
ed);
> +		if (!handled)
> +			break;
> +
> +		rc =3D drm_dp_dpcd_write_byte(mst->dp_aux, esi_res, ack[1]);
[Severity: High]
Does this MST handler silently ignore link status changes and CP IRQs
indicated in esi[3]?

The function reads 4 bytes of ESI (0x2002-0x2005) into the esi array and
passes it to drm_dp_mst_hpd_irq_handle_event(). That DRM helper function
only inspects esi[0] (sink count) and esi[1] (message readiness).

If the interrupt was triggered by LINK_STATUS_CHANGED in esi[3], the helper
returns handled =3D false. The loop then breaks without acknowledging the
interrupt (since it only writes back ack[1]) and bypassing the required link
status evaluation and retraining.

> +		if (rc < 0) {
> +			DRM_ERROR("DPCD esi_res failed. rc=3D%d\n", rc);
> +			return;
> +		}
> +
> +		drm_dp_mst_hpd_irq_send_new_request(&mst->mst_mgr);
> +	}
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D27
