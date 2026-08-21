Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757AEC5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:51:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AD5410E620;
	Fri, 21 Aug 2026 15:51:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H5yM+3Np";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B27110E620
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:51:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7E75361126
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEA11F000E9;
 Fri, 21 Aug 2026 15:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787327485;
 bh=1StMoxQC/vriAZWHCSuTwInN9BdDhWZ7m/5gWY+iMdg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H5yM+3NpQ9PScH60Yb6iHAK5rQdfCY73V1fOS5tXerEk+DwKjMw3QErkDIOC97ClL
 zJObeo+Cz1mfm36caVdy0hk/EkIc91HVfZZ/OV1JtDUgBZAsOp0rQwRdpnMMwgVOAn
 91RX7trWHAp1BAIDyHK/MykJCzXuxNm/NH5tj7nYYdu18kuOuKeOJQYHNPA9wGNw4k
 G934M4tQKLFHwI1DiBHXNRpkc+/RZGDZebIvI2yB++Wzbz+HXBnxtJ/ZY2yoeNY1H9
 77a3kyw9P29/xVvbO1ss4oAmDBembw/sYokNDTMWPtBaTmibnVT0U+b3l3OPaA440+
 GHFntvhNYMAAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 70/70] drm/crtc: Remove reset
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-70-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
 <20260821-drm-no-more-crtc-reset-v1-70-fb793475c05a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 15:51:24 +0000
Message-Id: <20260821155125.0BEA11F000E9@smtp.kernel.org>
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
- [High] The return value of the newly introduced `atomic_create_state` hoo=
k is ignored in `amdgpu_dm_crtc_init()`, causing a memory leak and leaving =
the CRTC state uninitialized.
--

--- Patch [70]: [PATCH 70/70] drm/crtc: Remove reset ---
commit de86d4e5c49ea36efff6debb8f1603e3e3c819b9
Author: Maxime Ripard <mripard@kernel.org>

drm/crtc: Remove reset
   =20
All crtc drivers now implement the atomic_create_state hook instead of
the reset hook for initial state creation. The reset hook conflated
initial state allocation at probe time with hardware and software reset
during suspend/resume, making error handling difficult since it is not
fallible.

Remove the reset hook from struct drm_crtc_funcs and the associated
call in drm_mode_config_reset().

> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode=
_config.c
> index 3bcc7bf0900c4..9f4eb694e1fb2 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -296,9 +296,7 @@ void drm_mode_config_reset(struct drm_device *dev)
>  	}
> =20
>  	drm_for_each_crtc(crtc, dev) {
> -		if (crtc->funcs->reset)
> -			crtc->funcs->reset(crtc);
> -		else if (crtc->funcs->atomic_create_state)
> +		if (crtc->funcs->atomic_create_state)
>  			drm_mode_config_crtc_reset_with_create_state(crtc);
>  	}

[Severity: High]
Does this transition leave the CRTC state uninitialized for AMD GPUs?

An earlier patch in this series switched amdgpu_dm_crtc_init() to call
atomic_create_state() instead of reset(), but the returned state pointer
is now ignored:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c:amdgpu_dm_crtc_init(=
) {
    ...
	/* Create the plane state */
	if (acrtc->base.funcs->atomic_create_state)
		acrtc->base.funcs->atomic_create_state(&acrtc->base);
    ...
}

Since the returned struct drm_crtc_state pointer is not assigned to crtc->s=
tate,
and the AMDGPU driver doesn't call drm_mode_config_reset() during probe,
could this lead to a memory leak and a NULL pointer dereference when the
DRM core later accesses the uninitialized CRTC state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-drm-no-mor=
e-crtc-reset-v1-0-fb793475c05a@kernel.org?part=3D70
