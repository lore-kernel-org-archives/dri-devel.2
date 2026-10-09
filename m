Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D603FCA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:40:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05AD810FE4A;
	Fri,  9 Oct 2026 03:40:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HEtXqCAD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3620C10FE4A
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 03:40:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C20234321A;
 Fri,  9 Oct 2026 03:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7633F1F000FF;
 Fri,  9 Oct 2026 03:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791517215;
 bh=6+BeSyE66oi6Opb4Ve20qWc2rsGI28zDIZHd3TrPof4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HEtXqCADjizLylngv/5Ucvaq46xehgzf1S3m7rlxbbdxsD9aXMWC1V0rpD+w7H4vM
 ttQRmY6khBzauZAOr6Q2S5ThGxdV2pfJOfL+QEuz3vqBkxhiRl8g3WC4UpxxbDHLrq
 5d/cMhLwcdmLhTi1F6ro2p0dsm6pQnwCpjjLDyC7sUQ/TeyX+vJNO9bhYN2Va5IYtM
 sM4/URf+STP481jNPxzbDKxlb7mZ3D55tZ9Rv9oZPvMO5Nma95klRKb3hLJj+rL9bM
 JwOmKTyavDKFI4H++KLghojkUlUncdNwphw5FfkNgbHtN2HII944gscm0xAVo4280T
 gNrDmw9hzeciw==
Message-ID: <sashiko-outbox-164781@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/20] drm/msm/dp: Add static HDR metadata support
 for DP and eDP
To: "Xilin Wu" <sophon@radxa.com>
Cc: neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261009-msm-dp-hdr10-v2-20-1835d4966da3@radxa.com>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-20-1835d4966da3@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 03:40:15 +0000
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
- [High] drm/msm/dp: unclocked access crash in msm_dp_display_disable() aft=
er failed PHY test
- [Medium] cleanup: mixed goto and scoped_guard in msm_dp_display_atomic_en=
able
--

commit 3c44a9bdc2d3792773d111df209f6cd19e02a7d6
Author: Xilin Wu <sophon@radxa.com>
Subject: drm/msm/dp: Add static HDR metadata support for DP and eDP

Expose HDR_OUTPUT_METADATA and validate and pack it during atomic check.
Program Generic2 from the checked bridge state on every stream enable.
Reuse the DRM metadata conversion and infoframe packing helpers.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index c51d033598a5b..7104822b03e05 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -880,10 +903,13 @@ static int msm_dp_display_disable(struct msm_dp_dis=
play_private *dp,
> =20
>  	lockdep_assert_held(&dp->plugged_lock);
> =20
> +	dp->video_test_blocked =3D false;
> +
>  	if (!msm_dp_display->power_on)
>  		return 0;
> =20
>  	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
> +	msm_dp_panel_disable_hdr_sdp(msm_dp_panel);

[Severity: High]
Can this unconditionally access hardware registers when the DP link clocks
are disabled?

If a DP sink requests a PHY test pattern,
msm_dp_ctrl_process_phy_test_request() intentionally disables the link
clocks via msm_dp_ctrl_off_link().

If msm_dp_ctrl_on_link() subsequently fails, it returns early leaving the
link clocks disabled, but the display power_on flag remains true.

When msm_dp_display_disable() is then called (e.g. on monitor unplug), it
proceeds because power_on is true, and calls msm_dp_panel_disable_hdr_sdp()
and msm_dp_panel_disable_vsc_sdp(). These functions write to hardware link
registers (like MMSS_DP_SDP_CFG).

Accessing these registers while the link clocks are off can cause a
synchronous external abort (kernel panic) which is reachable via a faulty
or malicious DP sink.

[ ... ]
> @@ -1774,6 +1800,7 @@ void msm_dp_display_atomic_enable(struct msm_dp *ms=
m_dp_display,
>  		msm_dp_hpd_unplug_handle(dp);
>  	msm_dp_display_unprepare(dp);
>  	scoped_guard(mutex, &dp->plugged_lock) {
> +		dp->video_test_blocked =3D false;
>  		dp->link_failed =3D true;
>  		/* Keep reporting BAD, but notify only once until recovery. */
>  		schedule_work(&dp->link_status_work);

[Severity: Medium]
Does this mix goto-based error handling and scope-based cleanup in the same
function?

The msm_dp_display_atomic_enable() function uses traditional goto-based err=
or
handling (goto err; goto err_prepare;) but also includes a scoped_guard()
block at the end.

According to kernel cleanup guidelines (include/linux/cleanup.h), mixing
goto and scope-based cleanup within the same function is explicitly
prohibited because it creates confusing ownership semantics and increases
the risk of double-free or locking bugs during maintenance.

Could this be converted to use scope-based cleanup entirely, or use
traditional locking for this block to match the rest of the function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-msm-dp-hdr=
10-v2-0-1835d4966da3@radxa.com?part=3D20
