Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9DFCA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB2210E64D;
	Tue, 29 Sep 2026 04:49:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GRvOxRma";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12EEA10ECD3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:49:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2057E60210;
 Tue, 29 Sep 2026 04:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8411F000FF;
 Tue, 29 Sep 2026 04:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790657394;
 bh=5vf97JY3R7SHmryRzSXa7uEuV5CVmRW544sV1gD3sWE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GRvOxRmaU4ndDDc7YHlPbRrQrUSAjL7h6uOVHPxcUdBA2BqMdc4gdVW6gb1XM9BGW
 W72P5eCwVO5j4jZS0fSca3shtDlWCkC2+GYtxnVgw3AdBzUxG6l8HtqiSVv40j2n68
 jc4h2UAmiSO6KAW+wKNg+IxgiAVHzi0ztds0FJU1NkpJoaXC0QrSpJ/h2BaHBE9eJk
 872Nb7jKyBqg+OH4V7n7KygG9xpkrnXoRELvY4pNSZTVn2nEDY+axXzd18mqHVfHjd
 DB/WLVa8AoWz4iahBkL5hWL881wgx3UlZ57AGlZ33LjpRPpUhQ/eZJvoLWGcJ33NM1
 deTgmvK/nVGOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/35] drm/msm/dp: move link-level teardown from
 display_disable to display_unprepare
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-1-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-1-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:49:54 +0000
Message-Id: <20260929044954.AD8411F000FF@smtp.kernel.org>
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
- [High] drm/msm/dp: continuous underflow and SoC reset on post_enable fail=
ure
--

commit 71fa7431b57f5bf43596e31ff0dea94064bcb0c2
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: move link-level teardown from display_disable to display_unprep=
are

This commit moves link-level teardown operations from msm_dp_display_disabl=
e()
to msm_dp_display_unprepare() to handle DP MST where links are shared across
multiple streams. It leaves only stream-level shutdown inside the disable
function.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index a420e3d499281..03ccdf7e03666 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -722,20 +722,6 @@ static int msm_dp_display_disable(struct msm_dp_disp=
lay_private *dp,
> =20
>  	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
> =20
> -	/* dongle is still connected but sinks are disconnected */
> -	if (dp->link->sink_count =3D=3D 0)
> -		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
> -
> -	msm_dp_ctrl_off_link(dp->ctrl, msm_dp_panel);
> -
> -	if (dp->link->sink_count =3D=3D 0)
> -		/* re-init the PHY so that we can listen to Dongle disconnect */
> -		msm_dp_ctrl_reinit_phy(dp->ctrl);
> -	else
> -		msm_dp_display_host_phy_exit(dp);
> -
> -	msm_dp_display->power_on =3D false;
> -

[Severity: High]
If msm_dp_display_post_enable() fails inside msm_dp_display_atomic_enable(),
the error path calls msm_dp_display_disable().

Since this patch removes the mainlink teardown and power_on =3D false from
msm_dp_display_disable(), the function now only disables the pixel clock
while leaving the mainlink active and power_on set to true.

Can this lead to a continuous underflow state and an SoC reset on failure?

Because power_on remains true, the subsequent call to
msm_dp_display_atomic_disable() will attempt to execute
msm_dp_ctrl_push_idle(). With the pixel clock already off, this appears to
time out and crash the SoC (such as on Snapdragon X2 Elite).

Additionally, looking forward to later in the series where the power_on flag
is replaced with active_stream_cnt, does the DRM framework's eventual call
to atomic_post_disable() call msm_dp_display_disable() a second time? If so,
could this cause active_stream_cnt to underflow and wrap to UINT_MAX,
permanently preventing hardware teardown in msm_dp_display_unprepare()?

>  	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D1
