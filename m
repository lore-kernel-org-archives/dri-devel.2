Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83A2C44521
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0747310E6AB;
	Mon, 20 Jul 2026 06:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YljKLYtw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53F0C10E6AB
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:33:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 22EAB416E1;
 Mon, 20 Jul 2026 06:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCFF1F000E9;
 Mon, 20 Jul 2026 06:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784529198;
 bh=ww1p62icuNyDcaoGjU0d+noDcXymHNTC3uodjYA8LC4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YljKLYtwrheTdPcDdDQDtYO9xqPxMaLTPCb0CIpvzBjmQLxijBu1VkKVFQNEM43qg
 hedFLY6Xpx147iszdATmnQ8AX0nHXlz9aFBcf2GNWYJ+1t00b1LGL2+myOllD8PwTe
 OpTvwoYmdYpCsYuZ9gPpAFH3R6QxgSZIdYxp6xGVUf9wwMGhsXjrp8CgS8pll+88YF
 KaXyVskmLJ/xBz9LUA55pamC0RLiF9fLobLYlYwcs8cVCi+mqGZCcsbxcqAoC9xaOV
 ht/uPyzSc8hPlLRKtv5A+u9UPQ9JpGt3OhTkybmEeDs2ScApmja2UbP9Ryki1IOOaC
 W3EZBXsiXRegA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/15] drm/msm/dp: drop deprecated .mode_set() and
 use .atomic_enable
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720-dp_mstclean-v8-2-bea261bf4e7d@oss.qualcomm.com>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
 <20260720-dp_mstclean-v8-2-bea261bf4e7d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 06:33:16 +0000
Message-Id: <20260720063317.CFCFF1F000E9@smtp.kernel.org>
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

New issues:
- [High] Moving mode state updates to `.atomic_enable` causes the DPU encod=
er to read stale wide bus configuration.

Pre-existing issues:
- [High] `mode_valid` incorrectly evaluates wide bus availability based on =
the currently active mode's state rather than the candidate mode, causing v=
alid modes to be rejected.
--

--- Patch [2]: [PATCH v8 02/15] drm/msm/dp: drop deprecated .mode_set() and=
 use .atomic_enable ---
commit f8a619167d17d8d750e695eca53077efafe8ab7e
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: drop deprecated .mode_set() and use .atomic_enable

The bridge .mode_set() callback is deprecated. Remove it and move all
mode setup logic to .atomic_enable(), where the adjusted_mode is
available from the atomic CRTC state.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index bce165bac106b..57eafd4724627 100644
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
>  		return false;
> =20
>  	return dp->wide_bus_supported;

[Severity: High]
This is a pre-existing issue, but does msm_dp_wide_bus_available() evaluate
the candidate mode correctly during mode probing?

This function checks the currently active mode's format (out_fmt_is_yuv_420)
instead of the candidate mode's format.

When msm_dp_bridge_mode_valid() (or msm_edp_bridge_mode_valid()) calls this
during mode probing, won't it incorrectly reject valid high-resolution RGB
modes if the user is currently running a lower-resolution YUV420 mode?

[ ... ]

> @@ -1386,7 +1406,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge =
*drm_bridge,
>  	if (msm_dp_display->link->sink_count =3D=3D 0)
>  		return;
> =20
> -	rc =3D msm_dp_display_set_mode(dp, &msm_dp_display->msm_dp_mode);
> +	rc =3D msm_dp_display_set_mode(dp, &crtc_state->adjusted_mode, msm_dp_d=
isplay->panel);
>  	if (rc) {
>  		DRM_ERROR("Failed to perform a mode set, rc=3D%d\n", rc);
>  		return;

[Severity: High]
Does moving this mode setup into .atomic_enable() cause the DPU encoder
to read a stale wide bus configuration?

In the DRM atomic commit flow, the encoder's .atomic_enable() (which execut=
es
dpu_encoder_virt_atomic_enable()) is called before the bridge's
.atomic_enable().

Because msm_dp_display_set_mode() updates the format state=20
(msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420), the DPU encoder will query
msm_dp_wide_bus_available() before this new mode's format has been stored.

Won't this cause the hardware to be programmed using the wide bus state from
the previously active mode, potentially causing display corruption or a bla=
nk
screen when switching between RGB and YUV420?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-dp_mstclea=
n-v8-0-bea261bf4e7d@oss.qualcomm.com?part=3D2
