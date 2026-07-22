Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC944C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D2ED10EDD8;
	Wed, 22 Jul 2026 14:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hCUlpRkb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 096CB10EDD8
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:13:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CCA2540AFF;
 Wed, 22 Jul 2026 14:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854711F000E9;
 Wed, 22 Jul 2026 14:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784729628;
 bh=VKp87SMHIFOs1tB51VlLZI4UWehcvj7V9s9WjfrLbN8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hCUlpRkb/kbhWfmXFRlebov7dtnbNZ8BdaZCWuxh1gcS06NWihAxZCVcx3ZTbXBvM
 No91/dxGqA8AlCY1z8ZjtQyReIFIExOap7Ml77HILSqC4P2PW/PlrQsJEVwWwOfjrp
 nUbpOX1n9Sd1999hRmTXe5WQxXOoDKnfzhCTT2EUxYU9xWfd1w8URJZ8ETMIG3kn/6
 PY+QjD2T1FdZI9dlbeB8n2p1EWNim5pCd/exm+ivyDCtVWXK1ZhuAdyqMobtZuumMZ
 Mcch3xMqW3Jq2FiO+Qbx6uoRmn01athHol4J77JO8KZbdV9lNubVWb/x18evO27RPZ
 18rcsVGE4j4IQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/11] drm/amd/display: Set color_space to plane_infos
To: "Harry Wentland" <harry.wentland@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722134607.136293-11-harry.wentland@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-11-harry.wentland@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 14:13:48 +0000
Message-Id: <20260722141348.854711F000E9@smtp.kernel.org>
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
- [High] Changes to DRM plane color pipeline properties (drm_colorop) do no=
t trigger a DC plane state reset, causing the hardware to use stale color s=
pace and colorop properties.
--

--- Patch [10]: [PATCH v4 10/11] drm/amd/display: Set color_space to plane_=
infos ---
commit d69c24f2afbe9ab20f934e3e3173c2c3d2c7b892
Author: Harry Wentland <harry.wentland@amd.com>

drm/amd/display: Set color_space to plane_infos

This commit assigns the color space from the dc_plane directly to the
plane_infos array in the update bundle during plane commits. This replaces
the legacy behavior that handled COLOR_ENCODING and COLOR_RANGE inside
fill_plane_color_attributes.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4f07fe5688262..779f98e8d2d7d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4288,6 +4288,8 @@ static void amdgpu_dm_commit_planes(struct drm_atom=
ic_commit *state,
>  			&bundle->flip_addrs[planes_count].address,
>  			afb->tmz_surface);
> =20
> +		bundle->plane_infos[planes_count].color_space =3D dc_plane->color_spac=
e;
> +
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^

[Severity: High]
Could this assignment use a stale color_space value?

When userspace dynamically updates a property on an active drm_colorop
pipeline, DRM core sets new_plane_state->color_mgmt_changed =3D true.

However, should_reset_plane() incorrectly omits checking
new_other_state->color_mgmt_changed or iterating over drm_colorop_state
property changes:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:should_reset_plane() {
	...
	/* Colorspace changes. */
	if (old_other_state->color_range !=3D new_other_state->color_range ||
	    old_other_state->color_encoding !=3D new_other_state->color_encoding)
		return true;
	...
}

Because should_reset_plane() returns false when only colorop pipeline
properties are modified, dm_update_plane_state() skips recreating the
dc_plane_state and bypasses amdgpu_dm_update_plane_color_mgmt().

As a result, stale color space parameters are passed to DC here. Should
should_reset_plane() be updated to properly check for color management chan=
ges
so the hardware color pipeline does not retain stale configuration values?

>  		drm_dbg_state(state->dev, "plane: id=3D%d dcc_en=3D%d\n",
>  				 new_plane_state->plane->index,
>  				 bundle->plane_infos[planes_count].dcc.enable);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722134607.1362=
93-1-harry.wentland@amd.com?part=3D10
