Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3D4CD8CA8
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8ACA10E13D;
	Tue,  9 Jun 2026 11:17:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NfjtUA8E";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0DE310E13D
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 11:17:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D60E4351C;
 Tue,  9 Jun 2026 11:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52791F00893;
 Tue,  9 Jun 2026 11:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781003854;
 bh=hsKSu8saQz23vPQQru6hSsyiRw9Rg32Z/szCSUVIlm4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NfjtUA8E0iysrsxsg+BNpcZi2u+tQkyWukPPpl/HUiRrqXrRfdr0U7hBPkqd0rd81
 rEgS8bIAFau+WpOC4yw7FKi14Xw6GTPRNZsdRnc2UR8jUbyokKjCTfanvqDTblwMEq
 /bCU3tQrGRxvfVJL30Wp9I6xGyhS0xLCBmTU7Xu09g0XKTLplIPCbHkQrngyY5ztb/
 iz8Ex8HsvBShxOAw8sIf7iRd79lyUay0QXUyEDs31XBBhhfNP3KqvMK6cghzDiG84I
 a9kKnAxR3BfKKSw2hDQu9lesAJ+l9BodM4OstsRnoSBpSCFzd/CQgnx3+3aAO3VVAa
 oSui4FF2yeDtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 4/4] drm/amd/display: use plane color_mgmt_changed to
 track colorop changes
To: "Melissa Wen" <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609110420.1298352-5-mwen@igalia.com>
References: <20260609110420.1298352-5-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 11:17:34 +0000
Message-Id: <20260609111734.B52791F00893@smtp.kernel.org>
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
- [High] The logic in `should_reset_plane` fails to trigger a reset for all=
 planes on a CRTC when another plane's color management changes via the new=
 DRM Color Pipeline API, leading to plane z-order corruption.
--

commit 52aefc9e9f5291e7e9724eb87eff29b790339396
Author: Melissa Wen <mwen@igalia.com>

drm/amd/display: use plane color_mgmt_changed to track colorop changes

Ensure the driver tracks changes in any colorop property of a plane
color pipeline by using the same mechanism of CRTC color management and
update plane color blocks when any colorop property changes.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8f80420e9f0b8..56ba9bf40ed9f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
[ ... ]
> @@ -12208,6 +12208,10 @@ static bool should_reset_plane(struct drm_atomic=
_state *state,
>  	if (new_crtc_state->color_mgmt_changed)
>  		return true;
> =20
> +	/* Plane color pipeline or its colorop changes. */
> +	if (new_plane_state->color_mgmt_changed)
> +		return true;
> +
>  	/*
>  	 * On zpos change, planes need to be reordered by removing and re-adding

[Severity: High]
Does this code need to check color_mgmt_changed for other planes on the
CRTC as well?

Looking further down in should_reset_plane(), there is a loop over
other planes that checks legacy AMD color properties, but it misses checking
new_other_state->color_mgmt_changed:

	for_each_oldnew_plane_in_state(state, other, old_other_state, new_other_st=
ate, i) {
		...
		/* HDR/Transfer Function changes. */
		if (dm_old_other_state->degamma_tf !=3D dm_new_other_state->degamma_tf ||
		...

If Plane A has color_mgmt_changed =3D=3D true, should_reset_plane() correct=
ly
returns true and Plane A gets reset.

However, when should_reset_plane() is evaluated for Plane B on the same CRT=
C,
it iterates over the other planes (including Plane A). Since the loop does
not check Plane A's color_mgmt_changed state, it could return false for Pla=
ne B.

Could this cause only some planes on the CRTC to be removed and re-added,
resulting in a scrambled hardware z-order or pipeline acquisition errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609110420.1298=
352-1-mwen@igalia.com?part=3D4
