Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917DDC79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C211B10E0F9;
	Tue,  8 Sep 2026 09:16:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hLY5dJEb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF6FD10E0F9
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 09:16:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70A26414DC;
 Tue,  8 Sep 2026 09:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291E41F00A3A;
 Tue,  8 Sep 2026 09:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788859008;
 bh=lSdqtyDr6YP1sV6+uE02AGpUPgvUhtmP9Lylk7KqkPI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hLY5dJEbtSV3cmEJryih6WMpPSp51tjI02fjodAqTfrdjtaBVott8569j2so/+XGu
 IEjz9oRSXB6VvhNS6BTr/XrjAcGwV5/66Yn9z9V72c7UdrvI8Y/xz2W8WFpFAjkR9i
 R2d/oMkp9VkwlHR8dUUaBtv5PYJmeELcXzANf8HeKCgbw0Dvdo+QTuTBcaTfIrKT37
 ahxekuA5ZGScA9vXYlWGe6XFB5t0kyPZnzkzdD+3342xVhD6zJrB3apSE0w7xlJ8Hv
 9yWS9dxRvJkeacVWMZIA7x8vil4e+TdSFNlZhlMTWd3m6d2xHdxkdHdIlc7/ZlIdqy
 xh/p442a2tPPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/dp: don't gate eDP on DP_SINK_COUNT
To: 092vk <vk092kumar@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908090146.3100787-1-vk092kumar@gmail.com>
References: <20260908090146.3100787-1-vk092kumar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 09:16:47 +0000
Message-Id: <20260908091648.291E41F00A3A@smtp.kernel.org>
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
- [High] PM runtime usage count underflow when pm_runtime_resume_and_get() =
fails in msm_dp_display_prepare_link().
- [High] msm_dp_display_disable() calls functions that acquire mutexes whil=
e executing in an atomic context.
--

commit 4bcf3ca8adda3a167d25a4acaa736186981bd198
Author: 092vk <vk092kumar@gmail.com>

drm/msm/dp: don't gate eDP on DP_SINK_COUNT

msm_dp_display_prepare_link(), msm_dp_display_disable(), and
msm_dp_hpd_unplug_handle() all treat dp->link->sink_count =3D=3D 0 as
"nothing is connected", and in msm_dp_display_prepare_link() this
causes probe/enable to fail outright with -ENOTCONN.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index bc646d172abe0..9254f080f0ea6 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -634,7 +640,7 @@ static int msm_dp_display_prepare_link(struct msm_dp_=
display_private *dp)
>  		return rc;
>  	}
> =20

[Severity: High]
This is a pre-existing issue, but does returning early here when
pm_runtime_resume_and_get() fails cause a PM runtime usage count underflow
during teardown?

If pm_runtime_resume_and_get() fails in msm_dp_display_prepare_link(), it
returns early without taking a reference. However, during teardown,
msm_dp_display_unprepare() is called unconditionally and performs a
pm_runtime_put_sync(), dropping a reference that was never acquired.

Can this PM usage count underflow break power management for the device,
potentially leaving it permanently on or off?

> -	if (dp->link->sink_count =3D=3D 0)
> +	if (msm_dp_link_no_sink(dp))
>  		return -ENOTCONN;
> =20
>  	if (!msm_dp_display->power_on) {
[ ... ]
> @@ -723,12 +729,12 @@ static int msm_dp_display_disable(struct msm_dp_dis=
play_private *dp,
>  	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
> =20
>  	/* dongle is still connected but sinks are disconnected */
> -	if (dp->link->sink_count =3D=3D 0)
> +	if (msm_dp_link_no_sink(dp))
>  		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
> =20
>  	msm_dp_ctrl_off_link(dp->ctrl, msm_dp_panel);
> =20
> -	if (dp->link->sink_count =3D=3D 0)
> +	if (msm_dp_link_no_sink(dp))
>  		/* re-init the PHY so that we can listen to Dongle disconnect */
>  		msm_dp_ctrl_reinit_phy(dp->ctrl);
>  	else

[Severity: High]
This isn't a bug introduced by this patch, but does msm_dp_display_disable()
acquire sleeping mutexes while executing in an atomic context?

This function is called from the msm_dp_display_atomic_post_disable() encod=
er
callback, which is an atomic context path where sleeping is forbidden. Howe=
ver,
the branches modified here call functions that sleep:

- msm_dp_link_psm_config() directly acquires a mutex.
- msm_dp_ctrl_reinit_phy() triggers phy_init() and phy_exit(), which also
  acquire mutexes.
- msm_dp_display_host_phy_exit() triggers phy_exit().

Can these calls lead to scheduling-while-atomic warnings, system instabilit=
y,
or potential deadlocks during normal display disable or modeset operations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908090146.3100=
787-1-vk092kumar@gmail.com?part=3D1
