Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65244CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 18:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2C50112953;
	Thu,  4 Jun 2026 18:24:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ki7cTSYh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E21112953
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 18:24:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A37DB60052;
 Thu,  4 Jun 2026 18:24:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E0601F00893;
 Thu,  4 Jun 2026 18:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780597455;
 bh=GjuV3mmxW/HtMZUyLmMfEPo2RbXQ4uaDFQ5Po/dsZVU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ki7cTSYhu73mBHPPiadPC3kALu4eo6ZgMPSFVqla5ncLss003EQA2nsxHocjjpSZg
 JaYKKQMql+5HHpViYMwdsYtfHV2mAYneOd4vDEGI+UNCztGUSsGHc91sy7+iGyeaot
 bGZrT9Tmp1QttGWNHjy1KQukw5auUI9pa8/ZooifQZcTzMQb07WOBJeWgnQNWMPUSn
 hzB/m1EjLz7F+OFAfsTdCdT6dIErdr7ClvXU11HX4UVT5Gm7WUFh2a5ur/WgO2oH4U
 VZz+V7t6xc3yDxe3dhrdJbYw8Kxm303+lrOGM0b0DJwn9ziRfrSwT23qMNMcQkBKrN
 eBGw3hBI55v/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] drm/atomic: only add states of active or
 transient active colorops
To: "Melissa Wen" <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260604180457.1110110-2-mwen@igalia.com>
References: <20260604180457.1110110-2-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 18:24:14 +0000
Message-Id: <20260604182415.3E0601F00893@smtp.kernel.org>
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
- [High] Adding old pipeline colorops to the atomic state on deactivation c=
auses the AMD driver to incorrectly detect a deactivated pipeline as active.

Pre-existing issues:
- [High] Modifying a COLOROP property via the ATOMIC IOCTL fails to pull th=
e associated plane into the atomic state, causing the update to be silently=
 ignored by the driver.
- [High] Changing the COLOR_PIPELINE plane property does not pull the affec=
ted colorops into the atomic state unless a CRTC modeset is concurrently tr=
iggered.
--

commit c677eb54425763294f2391cd91e9253b70b8e880
Author: Melissa Wen <mwen@igalia.com>

drm/atomic: only add states of active or transient active colorops

Only consider affected colorop states those that are part of an active
color pipeline or a pipeline that is about to be activated or
deactivated in the same atomic commit, i.e., colorop is in the chain of
old/new plane color pipeline property. To cover color_pipeline
deactivation, remove the condition for plane_state->color_pipeline.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 170de30c28ae4..0d36a955c4d43 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c

[ ... ]

> @@ -812,6 +812,57 @@ static int drm_atomic_plane_check(const struct drm_p=
lane_state *old_plane_state,
>  	return 0;
>  }
> =20
> +/*
> + * This function walks old and new plane state color pipelines and adds =
all
> + * colorops in use by @plane to the atomic configuration @state. This is=
 useful
> + * when an atomic commit needs to check all currently enabled or about t=
o be
> + * enabled colorop on @plane, e.g. when changing the mode. This also avo=
ids
> + * including colorop states that are not part of the atomic state.
> + *
> + * Returns:
> + * 0 on success or can fail with -EDEADLK or -ENOMEM. When the error is =
EDEADLK
> + * then the w/w mutex code has detected a deadlock and the entire atomic
> + * sequence must be restarted. All other errors are fatal.
> + */
> +static int
> +drm_atomic_add_pipeline_colorops(struct drm_atomic_commit *state,
> +				 struct drm_plane *plane)
> +{
> +	struct drm_colorop *colorop;
> +	struct drm_colorop_state *colorop_state;
> +	struct drm_plane_state *new_plane_state, *old_plane_state;
> +
> +	new_plane_state =3D drm_atomic_get_new_plane_state(state, plane);
> +	old_plane_state =3D drm_atomic_get_old_plane_state(state, plane);
> +
> +	if (WARN_ON(!new_plane_state || !old_plane_state))
> +		return -EINVAL;
> +
> +	drm_dbg_atomic(plane->dev,
> +		       "Adding old+new pipeline colorops for [PLANE:%d:%s]\n",
> +		       plane->base.id, plane->name);
> +
> +	drm_for_each_colorop_in_pipeline(colorop,
> +					 new_plane_state->color_pipeline) {
> +		colorop_state =3D drm_atomic_get_colorop_state(state, colorop);

[Severity: High]
This is a pre-existing issue, but does modifying a colorop property via the
atomic ioctl fail to pull the associated plane into the atomic state?

The call to drm_atomic_get_colorop_state() successfully fetches and adds the
colorop to the state:

drivers/gpu/drm/drm_atomic.c:drm_atomic_get_colorop_state() {
    ...
    ret =3D drm_modeset_lock(&colorop->plane->mutex, state->acquire_ctx);
    colorop_state =3D drm_atomic_helper_colorop_duplicate_state(colorop);
    ...
}

However, it does not call drm_atomic_get_plane_state() to add the parent pl=
ane.
When the standard driver commit path executes, it iterates only over planes
present in the state:

drivers/gpu/drm/drm_atomic_helper.c:drm_atomic_helper_commit_planes() {
    ...
    for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane=
_state, i) {
        ...
        funcs->atomic_update(plane, state);
    ...
}

Does this mean the driver's atomic_update hook is skipped, and the hardware=
 is
not programmed with the new colorop parameters unless userspace also modifi=
es a
plane property in the same commit?

> +		if (IS_ERR(colorop_state))
> +			return PTR_ERR(colorop_state);
> +	}
> +
> +	/* Same color pipeline as new; no point walking old. */
> +	if (new_plane_state->color_pipeline =3D=3D old_plane_state->color_pipel=
ine)
> +		return 0;
> +
> +	drm_for_each_colorop_in_pipeline(colorop,
> +					 old_plane_state->color_pipeline) {
> +		colorop_state =3D drm_atomic_get_colorop_state(state, colorop);

[Severity: High]
Does adding the old pipeline's colorops to the atomic state during deactiva=
tion
cause issues with active pipeline detection?

When the pipeline is being deactivated, the old colorops' bypass flags are
untouched and remain false.

In the AMD driver, dm_plane_color_pipeline_active() checks all colorops add=
ed
to the state:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:dm_plane_color_pipeline_a=
ctive() {
    ...
    for_each_oldnew_colorop_in_state(state, colorop, old_colorop_state, new=
_colorop_state, i) {
        ...
        if (!cstate->bypass)
            return true;
    }
}

Will this cause the driver to see the old colorops, incorrectly evaluate the
deactivated pipeline as active, and attempt to program disabled hardware?

> +		if (IS_ERR(colorop_state))
> +			return PTR_ERR(colorop_state);
> +	}
> +
> +	return 0;
> +}

[ ... ]

> @@ -1591,11 +1642,9 @@ drm_atomic_add_affected_planes(struct drm_atomic_c=
ommit *state,
>  		if (IS_ERR(plane_state))
>  			return PTR_ERR(plane_state);
> =20
> -		if (plane_state->color_pipeline) {
> -			ret =3D drm_atomic_add_affected_colorops(state, plane);
> -			if (ret)
> -				return ret;
> -		}
> +		ret =3D drm_atomic_add_pipeline_colorops(state, plane);

[Severity: High]
This is a pre-existing issue, but does changing the color pipeline plane
property fail to pull the affected colorops into the atomic state if a CRTC
modeset isn't triggered?

The drm_atomic_add_pipeline_colorops() function is invoked here from
drm_atomic_add_affected_planes(). However, this is only called when a modes=
et
is occurring:

drivers/gpu/drm/drm_atomic_helper.c:drm_atomic_helper_check_modeset() {
    ...
    if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
        continue;
    ...
    ret =3D drm_atomic_add_affected_planes(state, crtc);
}

If userspace dynamically changes the color pipeline property on a plane as a
standalone update without triggering a full CRTC modeset, will this bypass
drm_atomic_add_affected_planes() entirely?

Could this result in the colorops for the newly activated or deactivated
pipeline never being added to the atomic commit state?

> +		if (ret)
> +			return ret;
>  	}
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604180457.1110=
110-1-mwen@igalia.com?part=3D1
