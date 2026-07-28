Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B052CC531F9
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF7210E414;
	Tue, 28 Jul 2026 10:34:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SfUd2KgT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB00610E414
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:34:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E7F0060051;
 Tue, 28 Jul 2026 10:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7279F1F000E9;
 Tue, 28 Jul 2026 10:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785234873;
 bh=y+sgWBy/cfQhh+dKF9OLuGmqAbWrfFgsVsKw8OEZlCY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SfUd2KgTRD/lDAaYMNhT8i2xby+jGIEn/NHnuTl7MCTf7v7X69FT1hEEGTKCijoCn
 Rx5CWeiahi4IM0iehymkB4Pf2ZQh7I7n9iXTNibTkyefkqfkVdHfAWPl/oHOVIvYWf
 MTm/effBeUwZpRIOJThx/e4kbRY5Q/ekJbg922UspUa9zAO0IRYMbdLR4qoaN0jQId
 3V6KL5mn4cPFHVCQvmuiYv9yEnWju+ajfmr9JUNzBwQEd2H3KLGWYqX+wSLSxinrXn
 19T0eJY5MAcQg5gRJViyEPQ+2Nmxw4eKV6rp8NDuwbE40Ju3juMpHzLKLEW1cA8ZVP
 cP5GP6ZhF77VQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/14] drm/msm/dp: drop deprecated .mode_set() and
 use .atomic_pre_enable
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728-dp_mstclean-v9-2-f7779fce10f4@oss.qualcomm.com>
References: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
 <20260728-dp_mstclean-v9-2-f7779fce10f4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 10:34:32 +0000
Message-Id: <20260728103433.7279F1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] msm_dp_bridge_mode_valid() evaluates wide bus availability using t=
he previously committed mode's YUV420 state rather than the state of the mo=
de being validated. This causes valid high-bandwidth RGB modes to be incorr=
ectly rejected if a YUV420 mode was previously committed.
--

--- Patch [2]: [PATCH v9 02/14] drm/msm/dp: drop deprecated .mode_set() and=
 use .atomic_pre_enable ---
commit 9ae2d320a8d0fa2507140b418f1dff372f81454c
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: drop deprecated .mode_set() and use .atomic_pre_enable
   =20
The bridge .mode_set() callback is deprecated. Remove it and move the
mode setup logic to .atomic_pre_enable(), where the adjusted_mode is
available from the atomic CRTC state. Drop msm_dp_mode from
msm_dp_display_private and store the mode directly in the panel.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index bce165bac106b..c106aabda588e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -1309,7 +1325,7 @@ bool msm_dp_wide_bus_available(const struct msm_dp =
*msm_dp_display)
> =20
>  	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
> =20
> -	if (dp->msm_dp_mode.out_fmt_is_yuv_420)
> +	if (dp->panel->msm_dp_mode.out_fmt_is_yuv_420)

[Severity: High]
This is a pre-existing issue, but does evaluating wide bus availability usi=
ng
the previously committed mode's YUV420 state cause valid high-bandwidth RGB
modes to be incorrectly rejected?

When a user sets a YUV420 mode, out_fmt_is_yuv_420 is set to true during
atomic_pre_enable. If the driver later probes or validates modes from EDID,
msm_dp_bridge_mode_valid() calls msm_dp_wide_bus_available():

msm_dp_bridge_mode_valid()
    if (msm_dp_wide_bus_available(dp))
        mode_pclk_khz /=3D 2;

This function then reads the stale out_fmt_is_yuv_420 flag and returns fals=
e.
Consequently, the pixel clock for high-bandwidth RGB modes is not halved,
causing them to exceed the maximum pixel clock and be rejected.

While this patch addresses a similar state leak for the DPU encoder by movi=
ng
the mode state update to atomic_pre_enable, it seems mode validation (which
runs before atomic_pre_enable) still relies on this stale state.

>  		return false;
> =20
>  	return dp->wide_bus_supported;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-dp_mstclea=
n-v9-0-f7779fce10f4@oss.qualcomm.com?part=3D2
