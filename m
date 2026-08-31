Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F13AC61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:07:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3773110E270;
	Mon, 31 Aug 2026 09:07:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IlFdYcZ0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B620310E270
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:06:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D44E43AFC;
 Mon, 31 Aug 2026 09:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1424F1F000E9;
 Mon, 31 Aug 2026 09:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788167219;
 bh=pTfj5cdbZ15MZ+bh3WRw+onA6bmIWSgyGobATeAZ3lc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IlFdYcZ0E43mp/R9OosqZj2ycLlvZ0R8gXZ9Wl4R8pJBv3Gu17YwfDUQi8VFyEcAG
 WMARaGV/tnFCAlGVVFf1uQ+jXVxoRoxlbHko1oCt9Y0fdz2s3Y5fjjIFTQUUE8wCg4
 trQvBFXZhcUTA17qDRH0lTcQvrE62rAQimBuH0mT50bcmty0/w2A+n0ByN7XckK9tA
 WWtyJGCsg3vi49zRTUqVxHx4I5U3kHQSI0LvdGgvd5y9HGGEK+DsSWjQWryW0IvOs3
 S/usRzttzUHnPYZvGJt2vUjr85dIjKMrH+uLf1n163MFcpkkyNarMS5W4Wx+oINPp2
 vo4Tco2Y/cNWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/29] drm/msm/dp: no need to update tu calculation
 for mst
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-msm-dp-mst-v6-10-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-10-c91d35d6fb9e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:06:58 +0000
Message-Id: <20260831090659.1424F1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] If memory allocation fails during TU calculation, the function ret=
urns early without initializing its output parameters, leading to uninitial=
ized stack memory being written to hardware registers.
- [High] Calling sleeping and blocking functions from an atomic context cau=
ses system instability and deadlocks.
--

commit 17eb62d850306afdfafe9f15909840906306ec84
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: no need to update tu calculation for mst

This commit skips the calculation and programming of TU parameters for MST
cases, as the DP stream is transmitted in transfer units only for SST.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index cd6ae0d5372c9..77506e8408832 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -2703,7 +2703,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_d=
p_ctrl, struct msm_dp_panel *
> =20
>  	msm_dp_panel_clear_dsc_dto(panel);
> =20
> -	msm_dp_ctrl_setup_tr_unit(ctrl, panel);
> +	if (!ctrl->mst_active)
> +		msm_dp_ctrl_setup_tr_unit(ctrl, panel);

[Severity: High]
This isn't a bug introduced by this patch, but can we write uninitialized
stack memory to MMIO link registers if memory allocation fails?

Looking at msm_dp_ctrl_setup_tr_unit() in drivers/gpu/drm/msm/dp/dp_ctrl.c,
it allocates tu_calc_table on the stack and passes it down for initializati=
on:

drivers/gpu/drm/msm/dp/dp_ctrl.c:msm_dp_ctrl_setup_tr_unit() {
	struct msm_dp_vc_tu_mapping_table tu_calc_table;

	msm_dp_ctrl_calc_tu_parameters(ctrl, panel, &tu_calc_table);

	msm_dp_tu |=3D tu_calc_table.tu_size_minus1;
	...
}

However, if _dp_ctrl_calc_tu() fails to allocate memory, it returns early
without initializing its output parameter:

drivers/gpu/drm/msm/dp/dp_ctrl.c:_dp_ctrl_calc_tu() {
	...
	tu =3D kzalloc_obj(*tu);
	if (!tu)
		return;
	...
}

Will this cause msm_dp_ctrl_setup_tr_unit() to use the uninitialized
tu_calc_table stack memory and program it into hardware registers like
REG_DP_VALID_BOUNDARY and REG_DP_TU, potentially leading to display
corruption or kernel panics?

[Severity: High]
This is a pre-existing issue, but does msm_dp_ctrl_on_stream() violate
atomic context constraints by calling sleeping or blocking functions?

The DRM guidelines state that encoder/bridge atomic enable callbacks, such =
as
msm_dp_display_atomic_enable(), execute in a non-sleeping atomic context.

However, msm_dp_display_atomic_enable() calls msm_dp_ctrl_on_stream(), which
appears to trigger several functions that can sleep or block:

- msm_dp_ctrl_mst_send_act() in drivers/gpu/drm/msm/dp/dp_ctrl.c directly
sleeps:

  msleep(frame_time_ms);

- msm_dp_ctrl_wait4video_ready() uses a blocking completion wait:

  if (!wait_for_completion_timeout(&ctrl->video_comp,
                                   WAIT_FOR_VIDEO_READY_TIMEOUT_JIFFIES)) {

- msm_dp_ctrl_setup_tr_unit() triggers a memory allocation that can sleep to
reclaim memory:

  tu =3D kzalloc_obj(*tu);

Could these calls cause system deadlocks or lockups when the stream is
activated during atomic commits?

> =20
>  	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-msm-dp-mst=
-v6-0-c91d35d6fb9e@oss.qualcomm.com?part=3D10
