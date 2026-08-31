Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725F7C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE9D10E798;
	Mon, 31 Aug 2026 09:18:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZqEiJBJ2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FAEC10E798
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:18:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 65E3960120;
 Mon, 31 Aug 2026 09:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2261F000E9;
 Mon, 31 Aug 2026 09:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788167882;
 bh=oR0a+LyRd+sKq6x4Eof2qaK24N3UiASc8ak+3AHrTGM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZqEiJBJ2RFLJGI66NgvfCwLcxneY7ghCZSN3erZmkSLPeNSixk3qPEkUrdg5jj5/J
 hXiQ5l9uBOQBTnGirVkkRa3z3A4fBTZw2TACo5tc+7eed/C7GbyAOZ7qEGimAteYUD
 4gSBomyHQQNsToi3DhyZprdd6jQvt6c0SZzAJsiSLOwNPv9CkMWcHWGt3by6ogXD2M
 rUcAkz9yh94iiX/MPwvPZhdVjK3Mpg3kSNySbeLMbCge0owV7It4Z1qU8j/MLRsphc
 O4i5gKzP+kQyZ7h75Yz4GAwVPbfHitIfpVsFvInwWWZqYMIrTQ5keiO/ShImBk5jUo
 tSVi7+SDUXF1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/29] drm/msm/dp: replace power_on with
 active_stream_cnt
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-msm-dp-mst-v6-14-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-14-c91d35d6fb9e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:18:01 +0000
Message-Id: <20260831091801.EF2261F000E9@smtp.kernel.org>
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
- [Critical] Unconditional decrement of `active_stream_cnt` and unclocked r=
egister accesses on failure paths cause integer underflow and system crashe=
s.
--

commit d23a7dcc5ef73b43d129d8cbcecd19ea680c25fc
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: drm/msm/dp: replace power_on with active_stream_cnt

This commit replaces the boolean power_on state with an active_stream_cnt
tracker to better support DP MST configurations. Link initialization is
performed when the first stream is enabled, and link teardown is deferred
until the last stream is disabled.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 6f79328c8b790..9c5563dcb856e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c

[ ... ]

> @@ -723,13 +719,12 @@ static int msm_dp_display_disable(struct msm_dp_dis=
play_private *dp,
>  {
>  	struct msm_dp *msm_dp_display =3D &dp->msm_dp_display;
> =20
> -	if (!msm_dp_display->power_on)
> -		return 0;
> -
>  	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
> =20
>  	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
> =20
> +	msm_dp_display->active_stream_cnt--;

[Severity: Critical]
If msm_dp_display_prepare_link() fails early (such as when sink_count =3D=
=3D 0),
the DP link clocks remain off and the stream is not initialized. Because DRM
core atomic enable callbacks return void, the teardown path will still exec=
ute.

Will removing this check cause a regression by unconditionally executing
hardware accesses and decrementing the stream count?

If msm_dp_display_disable() is called when the stream failed to enable, it
results in:

msm_dp_display_disable()
  -> msm_dp_panel_disable_vsc_sdp()
    -> msm_dp_read_link(panel, MMSS_DP_SDP_CFG)

Reading this register while link clocks are disabled triggers a synchronous
external abort (kernel panic).

Furthermore, does this allow active_stream_cnt to underflow? If it wraps to
UINT_MAX, the subsequent call to msm_dp_display_unprepare() would evaluate
active_stream_cnt as true and bypass the PHY teardown and
pm_runtime_put_sync() steps.

> +
>  	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
>  	return 0;
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-msm-dp-mst=
-v6-0-c91d35d6fb9e@oss.qualcomm.com?part=3D14
