Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B194DC61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9ACA10EB43;
	Mon, 31 Aug 2026 21:09:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cCEnGWxe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C68ED10EB43
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 21:09:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 758ED4028D
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 21:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEFD1F000E9;
 Mon, 31 Aug 2026 21:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788210581;
 bh=TFrDHYUIPm5kB/18UsySm7YMEhRq8RUfGLS+cKR6hjs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cCEnGWxeYt/dlkf4pQbENBq8xSaFXYxABqsxvZ1x6fl7y5zFNy1lVgV0ehzqPLXZx
 yBSH3M2t5od/61ziek0OkNlVORKv2qa/eYvgXn373HlxJ3WQ4zP6wFRqEudVeLHTON
 XPE3/G1zpoJV9HWp96EOnu0hQsxQ0Obh9KUq9LTaEeQjedc5RKJ0olMfOo0Fot/LuL
 ywKy5IHsWzBZ8at7OGCtb7xpcweU5qzehAO+OxM3YGTuK/aq8fjsi89r8jBvItGPQD
 mofX+PGQchYosCfOBcT4c6OUJzV/73EmoRq/+sVwgU0d4eUiV/laYruUuaVg0qbwvu
 FxKfZrOEWILPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/13] drm/crtc: Remove reset
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-13-4500d49a337f@kernel.org>
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
 <20260831-drm-no-more-crtc-reset-v2-13-4500d49a337f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:09:40 +0000
Message-Id: <20260831210941.2BEFD1F000E9@smtp.kernel.org>
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
- [High] Unchecked dereference of optional `crtc->helper_private` in `drm_m=
ode_config_crtc_reset_with_create_state()` before calling `hw_reset`.
--

commit c111ccec175b0bcef9dba73f9b4a2e31404bd779
Author: Maxime Ripard <mripard@kernel.org>
drm/crtc: Remove reset

This commit removes the reset hook from struct drm_crtc_funcs. As a result,
all crtc drivers now rely on the atomic_create_state hook for initial state
creation, and drm_mode_config_reset() is updated to reflect this.

> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode=
_config.c
> index bb2efc274323e..5eed5c194b661 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -307,9 +307,7 @@ void drm_mode_config_reset(struct drm_device *dev)
>  	}
> =20
>  	drm_for_each_crtc(crtc, dev) {
> -		if (crtc->funcs->reset)
> -			crtc->funcs->reset(crtc);
> -		else if (crtc->funcs->atomic_create_state)
> +		if (crtc->funcs->atomic_create_state)
>  			drm_mode_config_crtc_reset_with_create_state(crtc);

[Severity: High]
This is a pre-existing issue, but does removing the fallback to the reset
hook expose a kernel panic during initialization or resume?

By forcing all CRTCs that implement atomic_create_state through
drm_mode_config_crtc_reset_with_create_state(), we unconditionally hit a pa=
th
that dereferences the optional helper_private pointer without checking if it
exists.

Looking at drm_mode_config_crtc_reset_with_create_state() in
drivers/gpu/drm/drm_mode_config.c:

drm_mode_config_crtc_reset_with_create_state() {
	const struct drm_crtc_helper_funcs *crtc_funcs =3D crtc->helper_private;
	...
	if (crtc_funcs->hw_reset)
		crtc_funcs->hw_reset(crtc);
	...
}

If an atomic DRM driver provides its own atomic implementations and does not
use the CRTC helpers, helper_private will be NULL. In that case, crtc_funcs
is NULL and the check for crtc_funcs->hw_reset will cause a NULL pointer
dereference.

>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-drm-no-mor=
e-crtc-reset-v2-0-4500d49a337f@kernel.org?part=3D13
