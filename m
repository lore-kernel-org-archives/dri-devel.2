Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1832FC61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F9A10E7A4;
	Mon, 31 Aug 2026 09:28:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="efjQK8dN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DA5810E7A2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:28:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AC81C6013A;
 Mon, 31 Aug 2026 09:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414571F000E9;
 Mon, 31 Aug 2026 09:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788168533;
 bh=EEvoIphWXwZQTdbQDECuH3q8RDrmxSuBnzYox3JRWqI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=efjQK8dNfEneanqsuB4uZ3Dg+fLNZRw0NnymbLyCq0XXRCa8KlHZihZRhAncm27Ac
 MnFJMbh14rAIte7g24XuzPzVXtDINezBlCyVvX3DGIUGRY/VsIuY7IhvYCeZNpFd0O
 yIPu7fdjTvSlZST9J43rj7GOhVZqBHluhSGGbSel/Pm1uICcRdyCL/l+tP/S7HwIYd
 JfAFLstXrCRz6nXaQWJjE6UTjsQQuhBM8GhzTFeme1WeXcgYpy945dUZhtCMNa6+B2
 jiWHajgwVHk81WGj8CwtldOrB0M3jShhwBckhPSAMCE8saR1bzzrZUAreCaAcW/2Ub
 YlJjjLHOze83Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 17/29] drm/msm/dp: add msm_dp_display_get_panel() to
 initialize DP panel
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-msm-dp-mst-v6-17-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-17-c91d35d6fb9e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:28:52 +0000
Message-Id: <20260831092853.414571F000E9@smtp.kernel.org>
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
- [High] msm_dp_display_get_panel() blindly allocates a duplicate panel str=
ucture for a given stream ID, leading to desynchronized internal state.
- [High] Missing NULL pointer check for optional pixel_base resource leads =
to a kernel panic during stream setup.
--

commit 09c5d687d7add705558b0ff0b93169b01fc6922e
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: add msm_dp_display_get_panel() to initialize DP panel

This commit adds the msm_dp_display_get_panel API to initialize and
return a DP panel structure for use by the DP MST module.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 90e3d2c4ef478..6952f83db0065 100644
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
Does this inadvertently create a duplicate panel structure that lacks
initialized state?

When an MST stream is enabled, this dynamically allocates a new panel struct
where link_info is zeroed. Since the primary panel usually populates dpcd a=
nd
link_info (via msm_dp_panel_read_link_caps()), bandwidth calculations in
msm_dp_panel_get_supported_bpp() will evaluate to 0 for this secondary pane=
l.
Will this permanently degrade the display to the minimum 18bpp fallback?

[Severity: High]
Can dp->pixel_base[stream_id] be NULL here?

The pixel_base memory regions are explicitly handled as optional in
msm_dp_display_get_io(). If the device tree specifies a pixel clock but
omits the corresponding register region, passing dp->pixel_base[stream_id]
as NULL to msm_dp_panel_get() stores a NULL panel->pixel_base.=20

When the display pipeline attempts to configure the panel timings later
(e.g., via msm_dp_write_pn()), could it dereference this NULL pointer and
cause a panic?

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-msm-dp-mst=
-v6-0-c91d35d6fb9e@oss.qualcomm.com?part=3D17
