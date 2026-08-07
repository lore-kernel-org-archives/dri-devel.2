Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A266BC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 12:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA4A110F48C;
	Fri,  7 Aug 2026 12:12:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K+1Jlizp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D8F810F48C
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 12:12:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 33C326013A;
 Fri,  7 Aug 2026 12:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B605C1F000E9;
 Fri,  7 Aug 2026 12:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786104728;
 bh=YvJ9Eq4bwm74Zj00CvdCxjnRndciEzlQrjVo8jx3EgA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K+1JlizpJPJPDJkn8UU24VEa6dliPl50sra6qiVxhWJD5Mo92qy3+5qSyW+f/xHsF
 ylkEeBFGe/e/gJxd24cvxxLMC/Uwom04LQcKs/IBnTDu4NzjiXPzAtLwhFCBVWtUAw
 4fWrMmhTUDJ+fdlNiuB4Zi43/9Mgf5jCBVOuwAkFCCuC2js+alww4dr4Ly6Nr0i08K
 xOUeQTKc0Zjf2yRfp5Hb0490YfJuUwTwax/jsSsnKQxwPrw7xIQYAEwBMzN3+886l9
 qy1XZc3f/djTZz0rXz5kcNyR24oioZgcYFs5TB5T1RMWFAT2PULMc3GhMYqkuSgCA9
 3xXaKIRwngBbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: use plane color_mgmt_changed to track
 colorop changes
To: "Melissa Wen" <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260807115712.22423-1-mwen@igalia.com>
References: <20260807115712.22423-1-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 12:12:08 +0000
Message-Id: <20260807121208.B605C1F000E9@smtp.kernel.org>
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
- [High] Plane color management changes (via `color_mgmt_changed`) force a =
reset for the modified plane but fail to trigger a reset of all other plane=
s on the same CRTC, violating the AMD DC descending z-order requirement.
--

--- Patch [1]: [PATCH] drm/amd/display: use plane color_mgmt_changed to tra=
ck colorop changes ---
commit 3d974c5531b17eb9dc9b94714b129841cee1a82c
Author: Melissa Wen <mwen@igalia.com>

drm/amd/display: use plane color_mgmt_changed to track colorop changes

This commit ensures the driver tracks changes in any colorop property
of a plane color pipeline. It updates plane color blocks when any
colorop property changes, which fixes missing updates observed in
night mode settings via Gamescope.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e421c3c81778d..e10937217ad41 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
[ ... ]
> @@ -5675,6 +5675,10 @@ static bool should_reset_plane(struct drm_atomic_c=
ommit *state,
>  	if (new_crtc_state->color_mgmt_changed)
>  		return true;
> =20
> +	/* Plane color pipeline or its colorop changes. */
> +	if (new_plane_state->color_mgmt_changed)
> +		return true;
> +

[Severity: High]
Does this change require a corresponding update to the cross-plane dependen=
cy
loop further down in should_reset_plane()?

If one plane resets due to new_plane_state->color_mgmt_changed, the AMD DC
architecture requires all other planes on the CRTC to be recreated to prese=
rve
descending z-order.

Currently, the loop over for_each_oldnew_plane_in_state() checks legacy
properties like dm_new_other_state->degamma_tf, but doesn't check
new_other_state->color_mgmt_changed.

Will this omission cause a plane with color_mgmt_changed to be removed and
re-added while other planes remain, corrupting the hardware z-order?

>  	/*
>  	 * On zpos change, planes need to be reordered by removing and re-adding
>  	 * them one by one to the dc state, in order of descending zpos.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807115712.2242=
3-1-mwen@igalia.com?part=3D1
