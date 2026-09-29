Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5703CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1025810ECD0;
	Tue, 29 Sep 2026 04:48:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZHfp9qsZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0D210ECCA
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:48:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DF9BD41387;
 Tue, 29 Sep 2026 04:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992D81F000FF;
 Tue, 29 Sep 2026 04:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790657302;
 bh=ciEGufpYSSFy7yf8N+CE4/Xg2rb3MuSmfyTfKRxyFxc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZHfp9qsZY1+xbdwcTIEXmZJDezkoICzvvE4dixXX2ugnw0GqM+XrpBdXV8UFJrRw/
 ELZdtq+S1bBGmst1L63x530+0gpGwdNcXm06s5TrUTpUORAx0RIRV0UlWCKXsnSuM8
 cXrbpemKuNrWi5ScPiSdgmOVXhePJJlXvXLyVdLuYEBUj0KPUeXfP+2XugJloJhAgK
 Ix7ZcxGpHCgOnVXnaFAVv+lk0DJX6l8jsGuN2WCOp/B/JSBShSJdFCs5bBEq7lWEtu
 GYGyKa3dg4ckdlBElZ3Cq3mI9Mm108nFWUznkyb/H6l1wQt8TflZ8AVkMyJd2BQTk+
 s4KAGavQCdx6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/35] drm/msm/dp: add stream-aware link register
 accessors
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-7-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-7-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:48:22 +0000
Message-Id: <20260929044822.992D81F000FF@smtp.kernel.org>
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
- [High] drm/msm/dp: null pointer dereference in stream-aware link accessors
- [High] drm/msm/dp: hardware register misrouting for MST video enable
- [High] drm/msm/dp: resource mapping corruption due to hardcoded DT indices
--

commit 55281b71e2076f4bad3f57eba868f53bb2700307
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: add stream-aware link register accessors

DisplayPort MST uses multiple stream-specific register spaces. Streams 0
and 1 share the primary link register block with different register offsets,
while streams 2 and 3 use dedicated MST link register blocks. Add
stream-aware register access helpers that translate stream-specific register
offsets and route accesses to the appropriate register space based on the
stream id.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index c0f5226dc383b..e1614bc49a7ca 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
[ ... ]
> @@ -172,6 +174,49 @@ static inline void msm_dp_write_link(struct msm_dp_c=
trl_private *ctrl,
>  	writel(data, ctrl->link_base + offset);
>  }
> =20
> +static inline u32 msm_dp_read_stream_link(struct msm_dp_ctrl_private *ct=
rl,
> +					   enum msm_dp_stream_id stream_id, u32 offset)
> +{
> +	offset =3D msm_dp_stream_reg(stream_id, offset);
> +	switch (stream_id) {
> +	case DP_STREAM_0:
> +	case DP_STREAM_1:
> +		return readl_relaxed(ctrl->link_base + offset);
> +	case DP_STREAM_2:
> +		return readl_relaxed(ctrl->mst2link_base + offset);

[Severity: High]
Can this regression lead to a NULL pointer dereference? If a platform has 3
or 4 pixel clocks but omits mst2link in the device tree,
msm_dp_ioremap_optional() returns NULL for mst2link_base. If a connected MST
sink or userspace modeset then triggers stream 2 initialization, this direct
read access without validation will panic the kernel.

> +	case DP_STREAM_3:
> +		return readl_relaxed(ctrl->mst3link_base + offset);
> +	default:
> +		DRM_ERROR("error stream_id\n");
> +		return 0;
> +	}
> +}
> +
> +static inline void msm_dp_write_stream_link(struct msm_dp_ctrl_private *=
ctrl,
> +					     enum msm_dp_stream_id stream_id, u32 offset, u32 data)
> +{
> +	/*
> +	 * To make sure link reg writes happens before any other operation,
> +	 * this function uses writel() instread of writel_relaxed()
> +	 */
> +	offset =3D msm_dp_stream_reg(stream_id, offset);
> +	switch (stream_id) {
> +	case DP_STREAM_0:
> +	case DP_STREAM_1:
> +		writel(data, ctrl->link_base + offset);
> +		break;
> +	case DP_STREAM_2:
> +		writel(data, ctrl->mst2link_base + offset);

[Severity: High]
Does this code risk a write to a NULL pointer? Similar to the read accessor
above, if mst2link_base fails to map or is omitted from the device tree, th=
is
direct write access will dereference a NULL pointer.

[Severity: High]
Is this a regression where MST streams 2 and 3 fail to enable video because
of a missed conversion to these new accessors?

Looking at msm_dp_ctrl_on_stream() in dp_ctrl.c:

	msm_dp_ctrl_setup_tr_unit(ctrl, panel);

	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);

	ret =3D msm_dp_ctrl_wait4video_ready(ctrl);

The code still unconditionally calls the non-stream-aware msm_dp_write_link=
()
which forces writes to ctrl->link_base (Stream 0/1's block) instead of using
msm_dp_write_stream_link(). This sends the video enable command for streams
2 and 3 to the wrong hardware register, causing silent corruption of stream
0's state.

> +		break;
> +	case DP_STREAM_3:
> +		writel(data, ctrl->mst3link_base + offset);
> +		break;
> +	default:
> +		DRM_ERROR("error stream_id\n");
> +		break;
> +	}
> +}
[ ... ]
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index d8b28a5626535..bb5e35e11b4d4 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -1208,6 +1222,14 @@ static int msm_dp_display_get_io(struct msm_dp_dis=
play_private *display)
>  			break;
>  	}
> =20
> +	display->mst2link_base =3D msm_dp_ioremap_optional(pdev, 7, &display->m=
st2link_len);

[Severity: High]
Can this hardcoded index cause a resource mapping regression? Device tree
'reg' arrays are contiguous. If a platform has only 3 pixel bases
(p0, p1, p2), they occupy indices 3, 4, and 5, making the mst2link resource
occupy index 6. Fetching index 7 assumes there are exactly 4 pixel bases
preceding it, which may return NULL or map an unrelated memory region during
driver probe.

> +	if (IS_ERR(display->mst2link_base))
> +		return PTR_ERR(display->mst2link_base);
> +
> +	display->mst3link_base =3D msm_dp_ioremap_optional(pdev, 8, &display->m=
st3link_len);
> +	if (IS_ERR(display->mst3link_base))
> +		return PTR_ERR(display->mst3link_base);
> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D7
