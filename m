Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFE9C79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FE4B10E170;
	Mon,  7 Sep 2026 11:27:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W5dkp8Fo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA10010E170
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:27:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0166360D83;
 Mon,  7 Sep 2026 11:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818A61F00A3A;
 Mon,  7 Sep 2026 11:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788780449;
 bh=wbbqZZPKyAdk84R+7hSHf2lkB2QVuKGbV0yp42odB1w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W5dkp8Fo8OvRhiCrKBKRQerFAN9E49/KPhqidiA8lwbJ0Oz9d0wpPNqMeRu9pvVEH
 FiHlvTPa2EwZwZZQkgcbuw1y7PxIpuVJBWbmvuAoSPr66w/6RFsJ3sMFsmyhnHLP/V
 OcZg4/EG47UQwuztgZopIUtM7q2KBZ7Ci6TGIACiVYMIeRJCxxQjWRghOZzgwN2ZQz
 GXIdaqULq1gqi7/gNCywWo09zOXIYqaWSOMg7i4fOOmBllRkIRFVX2W9sEnthRnlvD
 Wy6b9e4TtXXiNjEeJnr/HLN3bFOtyORSk23a79qorJfckCHN9SVC0+x5TqRuWEuJ26
 X45XqOJg4JTMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] drm/amd/display: size frame-packed streams by the
 doubled timing
To: "Adrian Betschart" <adrian.betschart@cinemaone.ch>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907100626.54465-4-adrian.betschart@cinemaone.ch>
References: <20260907100626.54465-1-adrian.betschart@cinemaone.ch>
 <20260907100626.54465-4-adrian.betschart@cinemaone.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 11:27:29 +0000
Message-Id: <20260907112729.818A61F00A3A@smtp.kernel.org>
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
- [Medium] The patch breaks the KUnit test dm_test_helper_check_state_scali=
ng_caps in amdgpu_dm_plane_test.c by introducing a dependency on mode.hdisp=
lay and mode.vdisplay, which the test does not mock.
--

commit fe46ce41733ff5de8af87a321672d77c5c614c30
Author: Adrian Betschart <adrian.betschart@cinemaone.ch>

drm/amd/display: size frame-packed streams by the doubled timing

The commit uses drm_mode_get_hv_timing() to handle frame-packed 3D modes
which scan out double the vertical timing, fixing view stretching across eye
windows.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 0a5a7347238ec..8db656ef85f84 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1407,16 +1407,21 @@ int amdgpu_dm_plane_helper_check_state(struct drm=
_plane_state *state,
>  		if (state->plane->type !=3D DRM_PLANE_TYPE_CURSOR) {
>  			int viewport_width =3D state->crtc_w;
>  			int viewport_height =3D state->crtc_h;
> +			int mode_hdisplay, mode_vdisplay;
> +
> +			/* frame-packed 3D scans out the doubled timing */
> +			drm_mode_get_hv_timing(&new_crtc_state->mode,
> +					       &mode_hdisplay, &mode_vdisplay);

[Severity: Medium]
Does this change break the KUnit test dm_test_helper_check_state_scaling_ca=
ps
in amdgpu_dm_plane_test.c?

The test mocks new_crtc_state->mode.crtc_hdisplay and crtc_vdisplay, but
leaves hdisplay and vdisplay as 0:

dm_test_helper_check_state_scaling_caps() {
	...
	new_crtc_state->mode.crtc_hdisplay =3D 1920;
	new_crtc_state->mode.crtc_vdisplay =3D 1080;

	KUNIT_EXPECT_EQ(test,
			amdgpu_dm_plane_helper_check_state(state, new_crtc_state),
			-ERANGE);
	...
}

When amdgpu_dm_plane_helper_check_state() calls drm_mode_get_hv_timing(), it
reads the uninitialized 0 from hdisplay and overwrites the mocked
crtc_hdisplay internally.

Could this cause viewport_width to become 0, leading to an early -EINVAL ex=
it
instead of the -ERANGE expected by the test assertion?

> =20
>  			if (state->crtc_x < 0)
>  				viewport_width +=3D state->crtc_x;
> -			else if (state->crtc_x + state->crtc_w > new_crtc_state->mode.crtc_hd=
isplay)
> -				viewport_width =3D new_crtc_state->mode.crtc_hdisplay - state->crtc_=
x;
> +			else if (state->crtc_x + state->crtc_w > mode_hdisplay)
> +				viewport_width =3D mode_hdisplay - state->crtc_x;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907100626.5446=
5-1-adrian.betschart@cinemaone.ch?part=3D3
