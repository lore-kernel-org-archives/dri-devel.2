Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F2CCD8CA8
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C43110E221;
	Tue,  9 Jun 2026 10:13:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cqTEMP6i";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A85B10E221
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 10:13:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D06C243695;
 Tue,  9 Jun 2026 10:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E11D1F00893;
 Tue,  9 Jun 2026 10:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781000010;
 bh=Me6CpsttpzfEY0HaGQb/UEgbTNGVatX1WAGKkcXBzPA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cqTEMP6i3+i13SRoXytRrj09DgGgR0iUZGhkBk6lf+zrMbHm0EuT9VvhXtFtbBH6T
 8QniXWYg+4kiOg3iut5tzCzxN1W+m/Y6RNdccifPCMZH08BuisNkL+BTxLxlkbc5AZ
 01BV86d1q7ueyMzH49bA+v3gkl4OU++svFBbdD85+xc1aLD7S5w/Weq0+6Ei1DvpDa
 zdK6iozA03mnOC9c6euH4GAPd1Vcxma7tq3Sp0mV8mbrbLrx/nEH9oRdxh6zVerVhK
 vQB+0zvtIFZCpLI05KSTFxmSk8E+TmLsS0UNRKB3IT64JZ/uRGa5A0UhwEuRlcEjQL
 jg7uzwLvlSHmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/15] drm/msm/dp: pass panel to display
 enable/disable helpers
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-dp_mstclean-v7-15-ea04113e8233@oss.qualcomm.com>
References: <20260609-dp_mstclean-v7-15-ea04113e8233@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:13:30 +0000
Message-Id: <20260609101330.8E11D1F00893@smtp.kernel.org>
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

New issues:
- [Medium] Incomplete refactoring in `msm_dp_display_disable` leaving `dp->=
panel` usage.

Pre-existing issues:
- [High] Missing early return in `msm_dp_display_atomic_enable` on display =
enable failure.
- [High] Sleeping functions called from atomic context in `atomic_post_disa=
ble`.
--

commit a04f2001a63e30ecc08234abf0151576d165e356
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: pass panel to display enable/disable helpers

This patch passes struct msm_dp_panel to the display enable/disable helpers.
This aims to make them easier to reuse for MST stream handling.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 03320071fc077..888ecf34f1602 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -707,20 +708,21 @@ static void msm_dp_display_audio_notify_disable(str=
uct msm_dp_display_private *d
>  	msm_dp_display->audio_enabled =3D false;
>  }
> =20
> -static int msm_dp_display_disable(struct msm_dp_display_private *dp)
> +static int msm_dp_display_disable(struct msm_dp_display_private *dp,
> +				  struct msm_dp_panel *msm_dp_panel)
>  {
>  	struct msm_dp *msm_dp_display =3D &dp->msm_dp_display;
> =20
>  	if (!msm_dp_display->power_on)
>  		return 0;
> =20
> -	msm_dp_panel_disable_vsc_sdp(dp->panel);
> +	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
> =20
>  	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
> =20
>  	/* dongle is still connected but sinks are disconnected */
>  	if (dp->link->sink_count =3D=3D 0)
> -		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
> +		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
> =20
>  	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);

[Severity: Medium]
Will this disable VSC SDP on the wrong panel when reused for MST streams?
It looks like msm_dp_ctrl_off_link() still operates on the primary dp->panel
instead of the newly passed msm_dp_panel parameter.

> =20
[ ... ]
> @@ -1437,14 +1439,14 @@ void msm_dp_display_atomic_enable(struct msm_dp *=
msm_dp_display)
> =20
>  	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
> =20
> -	rc =3D msm_dp_display_enable(dp);
> +	rc =3D msm_dp_display_enable(dp, dp->panel);
>  	if (rc)
>  		DRM_ERROR("DP display enable failed, rc=3D%d\n", rc);
> =20
>  	rc =3D msm_dp_display_post_enable(msm_dp_display);

[Severity: High]
This is a pre-existing issue, but does execution proceed to post-enable eve=
n if
msm_dp_display_enable() fails?

If msm_dp_display_enable() fails, the error is logged, but there is no early
return. This allows msm_dp_display_post_enable() to proceed and configure
hardware features like PSR when clocks and power might not be properly
initialized, which could lead to hardware timeouts or unclocked access faul=
ts.

>  	if (rc) {
>  		DRM_ERROR("DP display post enable failed, rc=3D%d\n", rc);
> -		msm_dp_display_disable(dp);
> +		msm_dp_display_disable(dp, dp->panel);
>  	}
> =20
>  	drm_dbg_dp(msm_dp_display->drm_dev, "type=3D%d Done\n", msm_dp_display-=
>connector_type);
> @@ -1479,7 +1481,7 @@ void msm_dp_display_atomic_post_disable(struct msm_=
dp *dp)
> =20
>  	msm_dp_display_audio_notify_disable(msm_dp_display);

[Severity: High]
This isn't a bug introduced by this patch, but does this call sequence
sleep while in an atomic context?

msm_dp_display_atomic_post_disable() is an atomic commit callback, yet it c=
alls
msm_dp_display_audio_notify_disable(), which can sleep:

msm_dp_display_audio_notify_disable() {
    ...
    if (!wait_for_completion_timeout(&dp->audio_comp, HZ * 5))
    ...
}

> =20
> -	msm_dp_display_disable(msm_dp_display);
> +	msm_dp_display_disable(msm_dp_display, msm_dp_display->panel);

[Severity: High]
This is also a pre-existing issue, but does msm_dp_display_disable()
similarly sleep in this atomic context?

It calls msm_dp_link_psm_config(), which acquires a mutex:

msm_dp_link_psm_config() {
    ...
    mutex_lock(&link->psm_mutex);
    ...
}

Calling sleeping functions in atomic contexts is forbidden by DRM/KMS
guidelines and could lead to kernel warnings, deadlocks, or system instabil=
ity.

> =20
>  	msm_dp_display_unprepare(msm_dp_display);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-dp_mstclea=
n-v7-0-ea04113e8233@oss.qualcomm.com?part=3D15
