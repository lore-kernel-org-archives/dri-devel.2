Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA1BC9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCF7910ECCF;
	Tue, 29 Sep 2026 04:44:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BtG0NSsg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 369B710ECD9
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:44:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7CEC860210;
 Tue, 29 Sep 2026 04:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098D11F000FF;
 Tue, 29 Sep 2026 04:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790657096;
 bh=2RxnZM7cjCsq8M6+HmkT6QugwQD5l4YfV9OeVF+nF64=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BtG0NSsghKSqRQjrhGcl6p0wxDaY/xZbg5uxrMU3W/I8/QEihD+2qJS3wRpDXLko2
 OGCCV9M9QgfPCFNw9WhtZGNFIvDpRhxrBv5ez3QhLeFx30fMAs0EVJlOcMyTDPX/cq
 fx/WSkkiuR52c2wJxzhQEROD3cNpt22sJqrUv0FdGfYuAmLN8HnEfvyC4iLDuwS3pO
 JRuBa4SmoT6FFslqARWYDgXh7HLiPF4Ka2Pbs78rcOwD4LQLzLxJ6h5z/YYR/benOo
 rDYWhYAG9CtMpLGJ8BO4w+GpZ6oAtRIz18v6xPCvGdnPcX+yqaUgojJSTcVLOmMHLh
 0POEFTbGTDPgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 17/35] drm/msm/dp: add msm_dp_display_get_panel() to
 initialize DP panel
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-17-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-17-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:44:55 +0000
Message-Id: <20260929044456.098D11F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/msm/dp: null-deref in msm_dp_write_pn() due to optional pixel_=
base
- [Medium] drm/msm/dp: devm_kzalloc leak and state desync in msm_dp_display=
_get_panel()
--

commit 06b6470d2aa1e63fd1b8da09b3340d3557e87642
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: add msm_dp_display_get_panel() to initialize DP panel
   =20
Add an API msm_dp_display_get_panel() to initialize and return a DP
panel to be used by DP MST module. Since some of the fields of
DP panel are private, dp_display module needs to initialize these
parts and return the panel back.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 487c76e0f990d..1d1fb45024c6a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -529,6 +529,33 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_displ=
ay_private *dp)
>  	return rc;
>  }
> =20
> +struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_disp=
lay,
> +					      enum msm_dp_stream_id stream_id)
> +{
> +	struct msm_dp_display_private *dp;
> +	struct msm_dp_panel *dp_panel;
> +
> +	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
> +
> +	if (stream_id >=3D msm_dp_ctrl_get_stream_cnt(dp->ctrl)) {
> +		DRM_ERROR("invalid stream_id %d\n", stream_id);
> +		return NULL;
> +	}
> +
> +	dp_panel =3D msm_dp_panel_get(&dp->msm_dp_display.pdev->dev, dp->aux, d=
p->link,
> +				    dp->link_base, dp->mst2link_base, dp->mst3link_base,
> +				    dp->pixel_base[stream_id]);

[Severity: High]
Can this cause a NULL pointer dereference later in msm_dp_write_pn()?

If a device tree provides the clocks but not the optional pixel_base memory
regions, dp->pixel_base[stream_id] will be NULL here. The bounds check above
verifies against msm_dp_ctrl_get_stream_cnt() (the number of available cloc=
ks),
not the number of available memory regions.

When the stream is later enabled, msm_dp_panel_timing_cfg() calls
msm_dp_write_pn(), which blindly dereferences panel->pixel_base.

[Severity: Medium]
Does this unconditionally allocate a new panel and risk a memory leak?

Since msm_dp_panel_get() uses devm_kzalloc() tied to the DP device, if the =
KMS
component is unbound and rebound, this will leak memory since it lacks a fr=
eeing
mechanism for dynamic binds.

Furthermore, for DP_STREAM_0, does this create a duplicate panel alongside
dp->panel? The newly allocated panels bypass early initialization steps (su=
ch
as msm_dp_ctrl_reset() and msm_dp_panel_read_link_caps()), which leaves
critical fields empty and can cause features like msm_dp_panel_update_sdp()
to malfunction.

> +
> +	if (IS_ERR(dp_panel)) {
> +		DRM_ERROR("failed to initialize panel\n");
> +		return NULL;
> +	}
> +
> +	dp_panel->stream_id =3D stream_id;
> +
> +	return dp_panel;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D17
