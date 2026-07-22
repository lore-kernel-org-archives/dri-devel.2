Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698AEC44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:56:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B729810EC76;
	Wed, 22 Jul 2026 06:56:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qe0M38zv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 120CA10EC76
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:56:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B46C40F53;
 Wed, 22 Jul 2026 06:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C141F000E9;
 Wed, 22 Jul 2026 06:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784703386;
 bh=Q/kZPLs+FnNDg7FE9KZaV3iiNbWN3ulmo8whjXig92o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Qe0M38zvsHsbz7W/++8Pq/8L9XyHzbsIdG2ze114RDBLhlp3KmdpnAltLxMTbl72D
 hRqu0bAOZ9CIi1M1WhvXmXeuUIrAqX7prPxJPSnTvwC3LM1tFsm1oMXL7IXezFIQHz
 7+o+eMuT35X+7YHm+gfw2BCT4ntzK2oEaDApx8dK/Dqf6Bzbk2nmplYYvZbMo/qrBC
 bZ5+HMBlFrb1HdJ9XqI6zk+QjsUU8HrfeapRXVUbvq1WzXruLfRlPmQDYceTBznFY+
 P5wHk3/3sqFlshFQjAG/HruLwHR6uRg6ArCehiryyx+XypNyxIR7R4S8Hdr+8gr317
 qgNg43dyoJGeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/24] drm/msm: route the display snapshot through the
 msm_display interface
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-drm-msm-display-interface-v1-5-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
 <20260722-drm-msm-display-interface-v1-5-368c10fe62fd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 06:56:25 +0000
Message-Id: <20260722065626.10C141F000E9@smtp.kernel.org>
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
- [High] TOCTOU race condition checking `dp->power_on` locklessly, which ca=
n lead to an unclocked MMIO read and system crash.
--

--- Patch [5]: [PATCH 05/24] drm/msm: route the display snapshot through th=
e msm_display interface ---
commit ccee48fbd111a360e4e514435d662edafb46b06b
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm: route the display snapshot through the msm_display interface

This commit refactors the display snapshot code to use a mandatory snapshot=
()
callback in struct msm_display_funcs. DSI and DP snapshot helpers are
turned into implementations of this callback, and an empty one is provided
for HDMI.

[ ... ]

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 79dd556e96c27..f4fa86d1b9c77 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -783,8 +783,10 @@ int msm_dp_display_get_test_bpp(struct msm_dp *dp)
>  		msm_dp_display->link->test_video.test_bit_depth);
>  }
> =20
> -void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *d=
p)
> +static void msm_dp_snapshot(struct msm_display *display,
> +			    struct msm_disp_state *disp_state)
>  {
> +	struct msm_dp *dp =3D container_of(display, struct msm_dp, display);
>  	struct msm_dp_display_private *msm_dp_display;

[Severity: High]
This is a pre-existing issue, but could the lockless check of dp->power_on
further down in msm_dp_snapshot() lead to an unclocked MMIO read?

If a concurrent modeset disable or hotplug unplug event disables the DP
controller's clocks and sets dp->power_on to false right after the lockless
if (!dp->power_on) check, the snapshot thread might proceed to read the
hardware registers in msm_disp_snapshot_add_block() without the clocks.

Reading MMIO registers while the DP clocks are disabled causes an AHB bus
hang, leading to a fatal system crash (SError) on Snapdragon hardware.

Should pm_runtime_get_sync() be used around the hardware access here,
similar to how it is handled in msm_dsi_host_snapshot()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-drm-msm-di=
splay-interface-v1-0-368c10fe62fd@oss.qualcomm.com?part=3D5
