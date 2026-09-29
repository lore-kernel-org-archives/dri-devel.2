Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6B4CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E0CE10ECC1;
	Tue, 29 Sep 2026 04:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WPAbf/t2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFF2910ECC1
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:44:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 880EB407F2;
 Tue, 29 Sep 2026 04:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C4F1F000FF;
 Tue, 29 Sep 2026 04:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790657069;
 bh=PwYYVXJTBjQAblHg2hEzySaYA8zHb3Br08H76/AoEYI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WPAbf/t2N2lvJevpDPXlzOTB81f9+HUQg56b7phB/cLbNBs59tlTeK9OVqZczAyLK
 QQKqSYK0vEw6UETP09XITgIG+/weIOaPwigtTEpNofLbkitO4wi1MRnFQH+5dzaG9/
 yajnBmbZ2YxnnlOtRtyL9Wf7wTwXk3ua6uCoB61uhE7bVlLk8puh3h1rUUfubg23Bv
 0elON/n7hgftCcmfePymHrlw0H5+eYrt41PQGMmtMslvVmUVyBdZltNwSZRYXlaWjd
 B6lqHxZtoD3yzx5MMtPd7X0Oa+Iv3UGHOuH70ykPXricSpW6iKG+bFqZTKLU6zBU0j
 8vhxMpzIGlFfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/35] drm/msm/dp: replace power_on with
 active_stream_cnt
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-14-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-14-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:44:27 +0000
Message-Id: <20260929044429.35C4F1F000FF@smtp.kernel.org>
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
- [High] msm: Unconditional stream decrement causes unclocked access and sy=
stem crash
- [Medium] msm: Unconditional stream count increment hides stream enablemen=
t failure
--

commit fe53f5f1bd8c24a505850b13542381e72e0597f7
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: drm/msm/dp: replace power_on with active_stream_cnt

This commit replaces the power_on boolean with an active_stream_cnt to track
the lifetime of the shared link for DP MST. It performs link initialization
when the first stream is enabled and defers teardown until the last stream =
is
disabled.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -667,14 +667,10 @@ static int msm_dp_display_enable(struct msm_dp_disp=
lay_private *dp,

[ ... ]

>  	rc =3D msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel, msm_dp_display->ms=
t_active);
> -	if (!rc)
> -		msm_dp_display->power_on =3D true;
> +
> +	msm_dp_display->active_stream_cnt++;
> =20
>  	return rc;
>  }

[Severity: Medium]
Does this code introduce a regression by unconditionally incrementing
active_stream_cnt even when the stream enablement fails?

If msm_dp_ctrl_on_stream() encounters an error like a DP timeout or link
training failure, it returns an error code in rc. The old code only updated
the state if rc was zero. The new code increments active_stream_cnt
regardless of the return code.

Could this leave the software state out of sync with the hardware? If the
caller logs the error but proceeds to post_enable successfully, the disable
rollback path won't be invoked. This leaves active_stream_cnt artificially
inflated.

> @@ -723,13 +719,12 @@ static int msm_dp_display_disable(struct msm_dp_dis=
play_private *dp,
>  {
>  	struct msm_dp *msm_dp_display =3D &dp->msm_dp_display;
> =20
> -	if (!msm_dp_display->power_on)
> -		return 0;
> -
>  	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);

[Severity: High]
Does removing this guard cause a regression where unclocked hardware is
accessed if a stream failed to enable?

If a DRM atomic commit fails to prepare the link (for instance, if
pm_runtime_resume_and_get() or link training fails), the DRM state can still
be updated to enabled. When a userspace process like a Wayland compositor
subsequently disables the display, msm_dp_display_disable() is invoked
unconditionally.

Without the early return guard, this calls msm_dp_panel_disable_vsc_sdp()
without active clocks, which triggers an unclocked MMIO read of
MMSS_DP_SDP_CFG that crashes Qualcomm SoCs.

> =20
>  	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
> =20
> +	msm_dp_display->active_stream_cnt--;

[Severity: High]
Can this unconditional decrement also cause a u32 underflow regression?

If the stream failed to enable and active_stream_cnt is 0, decrementing it
here unconditionally will cause it to wrap around to 0xFFFFFFFF, which might
break subsequent PM runtime put and PHY teardown logic.

> +
>  	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D14
