Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205E8C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5178110E31C;
	Fri, 21 Aug 2026 15:26:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ju69VZqT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9327110E31C
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:26:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E7D3C61126
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D9C1F000E9;
 Fri, 21 Aug 2026 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787325979;
 bh=8dq/qQ+HH2d5dMpEcLx3IHdb/Jpkt+WrKcXD9UCksI0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ju69VZqTvZ3wWtIGL0OpriYTnAF+ZrKmr/AxVoQFMtciRbhYHAMIyaoCN9HoK9ONb
 WXuDnSb4xT8sb+6lO5fBSCyiqSXucQy7rw5bALs1IGp4hMF5iUkdR+OGH0eK4EENN4
 jCDiDEjx6TFdltYrCyGcY9heTwACxhs/hBWxqxdi5NNDsUyIc6BiLjz7aKe/g/uLgV
 dROu8vJx+93YOXhj6voSt4tmqjaWzfEV8BEdJU1oClXJ7AhYnTFpm5n59PpydDuHMe
 2519JBunOBoLQBDoyf6e8Xqo8ZNW3rsGJrMw3kLkUwp5By7+1vK1TKMCy8N/tt6bWa
 lH1ZgdBforjAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 34/70] drm/tiny: pixpaper: Switch to
 drm_atomic_helper_crtc_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-34-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-34-fb793475c05a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 15:26:18 +0000
Message-Id: <20260821152619.73D9C1F000E9@smtp.kernel.org>
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
- [High] This problem wasn't introduced by this patch, but the plane and CR=
TC atomic callbacks call sleeping functions in atomic context, violating DR=
M subsystem rules.
--

--- Patch [34]: [PATCH 34/70] drm/tiny: pixpaper: Switch to drm_atomic_help=
er_crtc_create_state ---
commit 0c05f2d46ff22e1262b7a7c99b4dd00d2c48ebfe
Author: Maxime Ripard <mripard@kernel.org>

drm/tiny: pixpaper: Switch to drm_atomic_helper_crtc_create_state

This commit switches the pixpaper crtc implementation from using the
deprecated drm_atomic_helper_crtc_reset() hook to using
drm_atomic_helper_crtc_create_state().

> diff --git a/drivers/gpu/drm/tiny/pixpaper.c b/drivers/gpu/drm/tiny/pixpa=
per.c
> index d02ac26d007c1..b69e7c30607e7 100644
> --- a/drivers/gpu/drm/tiny/pixpaper.c
> +++ b/drivers/gpu/drm/tiny/pixpaper.c
> @@ -963,7 +963,7 @@ static const struct drm_plane_helper_funcs pixpaper_p=
lane_helper_funcs =3D {
>  static const struct drm_crtc_funcs pixpaper_crtc_funcs =3D {
>  	.set_config =3D drm_atomic_helper_set_config,
>  	.page_flip =3D drm_atomic_helper_page_flip,
> -	.reset =3D drm_atomic_helper_crtc_reset,
> +	.atomic_create_state =3D drm_atomic_helper_crtc_create_state,

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the atomic
state changes I noticed a pre-existing issue. Does pixpaper_wait_for_panel()
call sleeping functions while in an atomic context?

Looking at pixpaper_crtc_atomic_enable() and pixpaper_plane_atomic_update(),
these are DRM atomic callbacks and execute in atomic context where sleeping
is forbidden. However, both of them call pixpaper_wait_for_panel():

pixpaper_wait_for_panel() {
	...
	usleep_range(1000, 1500);
	while (gpiod_get_value_cansleep(panel->busy) !=3D 1) {
	...
}

Could this trigger scheduling while atomic oopses or deadlocks during
non-blocking commits? Should this be modified to use non-sleeping delays
and GPIO reads instead?

>  	.destroy =3D drm_crtc_cleanup,
>  	.atomic_duplicate_state =3D drm_atomic_helper_crtc_duplicate_state,
>  	.atomic_destroy_state =3D drm_atomic_helper_crtc_destroy_state,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-drm-no-mor=
e-crtc-reset-v1-0-fb793475c05a@kernel.org?part=3D34
