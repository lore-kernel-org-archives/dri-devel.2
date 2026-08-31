Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2014C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B77A210E773;
	Mon, 31 Aug 2026 08:39:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ULykyjJ9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D71110E72D
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:39:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 916E460120;
 Mon, 31 Aug 2026 08:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B751F000E9;
 Mon, 31 Aug 2026 08:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788165560;
 bh=Z1nC9s45kUS9SCI3PfxOqPFRVuW1eHwrjGF6MCvT4w8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ULykyjJ9wctejrNvAFFoZpzaNSsXrxgemwh+gMW4Ro07or9nX72Wi0OBqMi1bL8gb
 ff8Es9Vp4SQcQY5TdsMDPX6/e+ztFyHQYdrIJifBeq/D8YYIWhCG1T6tKkTot7yAvb
 KBzyO+Jm+iaDPRVu2NyMpk2yLvL8OSjG6px1NrpyLlmoc65G2wOuPxqgLu75c8YRIx
 9eaWzEP+HVjGpuollS1DuvvkVzSKsePVe/4k/JUXAZHaHW95Be3+ckUms5f83z0YgY
 5KAcxWVuiu8uHrVqs/m9AdR1ocsqKDj9jJ4kgvGBRiJkx8IdX1fkNA5gcnoQGB7X2S
 FljhqLJ0RJyjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/29] drm/msm/dp: add support for programming
 p1/p2/p3 register blocks
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-msm-dp-mst-v6-5-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-5-c91d35d6fb9e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 08:39:19 +0000
Message-Id: <20260831083920.24B751F000E9@smtp.kernel.org>
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
- [High] NULL pointer dereference when an optional pixel register block is =
missing from the device tree.
--

commit 8cc66577964ef75238881b3b8e6ae294ad3ae4f2
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
drm/msm/dp: add support for programming p1/p2/p3 register blocks

Add support for additional pixel register blocks (p1, p2, p3) to enable
4-stream MST pixel clocks. Introduce the helper functions msm_dp_read_pn
and msm_dp_write_pn for pixel register programming.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index fb6607f65dedc..3dce9334d0c25 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -843,8 +843,13 @@ void msm_dp_snapshot(struct msm_disp_state *disp_sta=
te, struct msm_dp *dp)
>  				    msm_dp_display->aux_base, "dp_aux");
>  	msm_disp_snapshot_add_block(disp_state, msm_dp_display->link_len,
>  				    msm_dp_display->link_base, "dp_link");
> -	msm_disp_snapshot_add_block(disp_state, msm_dp_display->p0_len,
> -				    msm_dp_display->p0_base, "dp_p0");
> +
> +	for (int i =3D 0; i < DP_STREAM_MAX; i++) {
> +		if (!msm_dp_ctrl_stream_clks_on(msm_dp_display->ctrl, i))
> +			continue;
> +		msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
> +					    msm_dp_display->pixel_base[i], "dp_p%d", i);

[Severity: High]
Can this dereference a NULL pointer? If a device tree defines an MST stream=
's
pixel clock but omits its memory region (e.g., p1), msm_dp_display_get_io()
catches the -EINVAL and explicitly sets msm_dp_display->pixel_base[i] =3D N=
ULL.

However, the driver later successfully discovers the clock in msm_dp_ctrl_g=
et(),
meaning msm_dp_ctrl_stream_clks_on() will return true for the stream.

When this happens, this block passes the NULL pixel_base[i] to
msm_disp_snapshot_add_block(), which unconditionally dereferences it during
readl_relaxed().

> +	}
>  }
> =20
>  void msm_dp_display_set_psr(struct msm_dp *msm_dp_display, bool enter)
[ ... ]
> @@ -1165,10 +1171,22 @@ static int msm_dp_display_get_io(struct msm_dp_di=
splay_private *display)
>  		return PTR_ERR(display->link_base);
>  	}
> =20
> -	display->p0_base =3D msm_dp_ioremap(pdev, 3, &display->p0_len);
> -	if (IS_ERR(display->p0_base)) {
> -		DRM_ERROR("unable to remap p0 region: %pe\n", display->p0_base);
> -		return PTR_ERR(display->p0_base);
> +	display->pixel_base[0] =3D msm_dp_ioremap(pdev, 3, &display->pixel_len);
> +	if (IS_ERR(display->pixel_base[0]))
> +		return PTR_ERR(display->pixel_base[0]);
> +
> +	for (i =3D DP_STREAM_1; i < DP_STREAM_MAX; i++) {
> +		display->pixel_base[i] =3D msm_dp_ioremap(pdev, i + 3, &display->pixel=
_len);
> +		if (IS_ERR(display->pixel_base[i])) {
> +			int ret =3D PTR_ERR(display->pixel_base[i]);
> +
> +			if (ret =3D=3D -EINVAL) {
> +				/* optional resource not present in DT */
> +				display->pixel_base[i] =3D NULL;
> +				break;
> +			}
> +			return ret;
> +		}
>  	}
> =20
>  	return 0;
[ ... ]
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/d=
p_panel.c
> index 745ee69768979..7b5fc5bb16def 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.c
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.c
[ ... ]
> -static inline void msm_dp_write_p0(struct msm_dp_panel_private *panel,
> -			       u32 offset, u32 data)
> +static inline void msm_dp_write_pn(struct msm_dp_panel_private *panel,
> +				   u32 offset, u32 data)
>  {
>  	/*
> -	 * To make sure interface reg writes happens before any other operation,
> -	 * this function uses writel() instread of writel_relaxed()
> +	 * Use writel() instead of writel_relaxed() to ensure the interface
> +	 * register write reaches the hardware before subsequent operations.
>  	 */
> -	writel(data, panel->p0_base + offset);
> +	writel(data, panel->pixel_base + offset);

[Severity: High]
Does this code also cause a NULL pointer dereference? As noted above, if an
optional pixel register block is missing from the device tree, pixel_base c=
an
be NULL, which would cause this unconditional writel() to crash upon stream
enablement.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-msm-dp-mst=
-v6-0-c91d35d6fb9e@oss.qualcomm.com?part=3D5
