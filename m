Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C36C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17D8689221;
	Tue, 21 Jul 2026 08:40:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hntoixxL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12D2A89A5C
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 08:40:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 06FE960AA1;
 Tue, 21 Jul 2026 08:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867F01F000E9;
 Tue, 21 Jul 2026 08:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784623206;
 bh=Ag9idwx5FrJbhjV4mE5lruWv8CvjlL1AtoS5VWoVd5s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hntoixxLuzHJ9Ijw50GVe4erjGBWuOI/0Z8fOF8TGLrCyrp++41g11qFH0rT4iQL3
 FJPqTGSc2RQKr8EDYoV6m4w6v7p9hW/mEBmS/R+kCR6LAiIMS5rKela+ngcxsb2pPY
 py4Co2qITNrc0CTE56vXthk9G7vDeX2ynkURHxjlqT1xRPARKzIz/ajcp/pvdVLql2
 Qoj1OnJDm1EwxRXm69IV7HxPcAy9aDFaW/OSw5uKkb7PHOi/mERwpt+D1vJaybQUSJ
 SWScKedP4EJfvnq0WGyL4ZfzVLHrPwVXKOZFVF+hKkoafBR/j/g3gbrnVwDxdGc25/
 jhOlLtpOflUQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/i915/display: Handle struct
 drm_plane_state.ignore_damage_clips
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260721082108.225599-1-tzimmermann@suse.de>
References: <20260721082108.225599-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 08:40:06 +0000
Message-Id: <20260721084006.867F01F000E9@smtp.kernel.org>
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
- [High] Logic error and evaluation order race in damage clearing for joine=
r secondary planes.
- [Low] Build failure due to undeclared identifier and invalid member acces=
s in plane_atomic_check().
--

--- Patch [1]: [PATCH v2] drm/i915/display: Handle struct drm_plane_state.i=
gnore_damage_clips ---
commit afbed1d4a86380370d4541c25d1804c472867576
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/i915/display: Handle struct drm_plane_state.ignore_damage_clips

Calling drm_atomic_helper_check_plane_damage() in plane_atomic_check()
before copying the damage information guarantees that ignore_damage_clips
from struct drm_plane_state has the correct value. Although i915 does not
directly modify or use the flag, DRM's damage iterator will soon rely on
it.

Link: https://lore.kernel.org/dri-devel/20260610152505.260172-1-tzimmermann=
@suse.de/

> diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm=
/i915/display/intel_plane.c
> index d0f99a87c42e8..ad7c5adc32cb0 100644
> --- a/drivers/gpu/drm/i915/display/intel_plane.c
> +++ b/drivers/gpu/drm/i915/display/intel_plane.c
[ ... ]
> @@ -928,6 +928,14 @@ static int plane_atomic_check(struct intel_atomic_st=
ate *state,
>  		old_primary_crtc_plane_state =3D old_plane_state;
>  	}
> =20
> +	/*
> +	 * Prepare plane-damage state before using it; do this on all
> +	 * display versions to keep the underlying DRM plane state in
> +	 * good shape.
> +	 */
> +	drm_atomic_helper_check_plane_damage(&new_plane_state->base,
> +					     &new_uapi_plane_state->uapi);

[Severity: Low]
Is there a typo in the variable names here that causes a build failure?

Looking at struct intel_plane_state, it doesn't contain a base member, and
new_uapi_plane_state is undeclared in this function scope. Did you mean to
pass &state->base and &new_primary_crtc_plane_state->uapi instead?

[Severity: High]
If this is naively fixed by passing the local plane state
(&new_plane_state->uapi), does this introduce a logic error for joiner
secondary planes during modesets?

The code would clear the secondary plane's damage, but the immediately
following call to intel_plane_copy_uapi_plane_damage() would overwrite
this by copying damage from the primary CRTC's plane state
(new_primary_crtc_plane_state).

If the primary plane has not yet been processed by the unordered atomic_che=
ck
loop, its damage will remain uncleared. The secondary plane would thus
incorrectly copy partial, dirty damage instead of executing a full update.

Should this explicitly evaluate the primary plane's state by passing
&new_primary_crtc_plane_state->uapi instead?

> +
>  	intel_plane_copy_uapi_plane_damage(new_plane_state,
>  					   old_primary_crtc_plane_state,
>  					   new_primary_crtc_plane_state);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721082108.2255=
99-1-tzimmermann@suse.de?part=3D1
