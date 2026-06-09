Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32780CD8C92
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8552510E2E8;
	Tue,  9 Jun 2026 12:37:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VYZztFzI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC81210E2E8
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 12:37:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 43FBF601D6;
 Tue,  9 Jun 2026 12:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FD81F00893;
 Tue,  9 Jun 2026 12:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781008625;
 bh=6cAsjjOwD7K4jjUdJSadeGH+djxV7/U2t8d1mAhrwlM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VYZztFzIwHP4uWKsQBl5GPg6X4FiAckRmGECLpTJ3TsPh9OMkOiIW8J4fKVMPevaS
 V4I6ZpkLhgkI6XHUaGMUeOho+9ck5WnclFD6yCEjWy3d2/rz6Vvgh+T3u3Kpnl37Uk
 CTG4LVMD0vkMAXkFNaPmij7VvYSV/8a1FEQJiR5GdFextLOklb6TMfnScE1uEm4XiA
 aI7103TETQFfYtYkiVruol9iXj0h2PGGg5HYWd7irp4cmXRnVWPiw//UxzDWb6ihCa
 vQ4QdQLwo5lzEBNpLhYGf9sbBns4vlEyxq4MPNG99dRnfH5SObAGhPoocYomoAehx/
 k/1DBCK91Uflw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/7] drm/atomic: reject colorop update from inactive
 color pipeline
To: "Melissa Wen" <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609121230.1358786-3-mwen@igalia.com>
References: <20260609121230.1358786-3-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 12:37:04 +0000
Message-Id: <20260609123704.C9FD81F00893@smtp.kernel.org>
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
- [High] drm_atomic_colorop_check() allows modifying colorops without addin=
g the parent plane to the atomic commit, bypassing hardware updates.
--

commit c38eca82c086d2e818d8283fed72b37dc3abbab9
Author: Melissa Wen <mwen@igalia.com>

drm/atomic: reject colorop update from inactive color pipeline

This commit rejects updates on colorops that are not part of an active
pipeline. It adds drm_atomic_colorop_check() to verify the color pipeline
of a plane in its current, new or old state.

> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 0d36a955c4d43..ec3c6e4e5a062 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c

[ ... ]

> @@ -863,6 +863,55 @@ drm_atomic_add_pipeline_colorops(struct drm_atomic_c=
ommit *state,
>  	return 0;
>  }
> =20
> +/**
> + * drm_atomic_colorop_check - check new colorop state
> + * @new_colorop_state: new colorop state to check
> + *
> + * Ensure that the colorop in @new_colorop_state belongs to an active co=
lor
> + * pipeline, i.e. it's in the chain of colorops set to the color_pipeline
> + * property of current, old or new plane state.
> + *
> + * Returns: 0 on success, -EINVAL otherwise.
> + */
> +static int drm_atomic_colorop_check(const struct drm_colorop_state *new_=
colorop_state)
> +{
> +	struct drm_atomic_commit *state =3D new_colorop_state->state;
> +	struct drm_plane *plane =3D new_colorop_state->colorop->plane;
> +	struct drm_plane_state *new_plane_state, *old_plane_state;
> +	struct drm_colorop *colorop;
> +
> +	new_plane_state =3D drm_atomic_get_new_plane_state(state, plane);
> +	old_plane_state =3D drm_atomic_get_old_plane_state(state, plane);
> +
> +	/* No changes in the plane state. Check current-committed plane state */
> +	if (!new_plane_state) {
> +		for (colorop =3D plane->state->color_pipeline; colorop; colorop =3D co=
lorop->next)
> +			if (colorop =3D=3D new_colorop_state->colorop)
> +				return 0;

[Severity: High]
If a colorop property is updated but the parent plane isn't explicitly
modified, new_plane_state will be NULL and this returns 0.

Since drm_colorop does not have its own atomic_update callback, hardware
programming relies on the plane's commit paths iterating over planes in
the atomic state.

If the plane is missing from the atomic state, will the hardware ever be
reprogrammed with the new colorop parameters, or does this result in a
silent failure where only the software state is updated?

Should the affected plane be actively pulled into the atomic state
(e.g., via drm_atomic_get_plane_state()) whenever a colorop is modified?

> +		return -EINVAL;
> +	}
> +
> +	if (WARN_ON(!old_plane_state))
> +		return -EINVAL;
> +
> +	/* Check if the colorop is active in the new plane state */
> +	for (colorop =3D new_plane_state->color_pipeline; colorop; colorop =3D =
colorop->next)
> +		if (colorop =3D=3D new_colorop_state->colorop)
> +			return 0;
> +
> +	/* Same color pipeline as new; no point walking old. Colorop isn't acti=
ve */
> +	if (new_plane_state->color_pipeline =3D=3D old_plane_state->color_pipel=
ine)
> +		return -EINVAL;
> +
> +	/* Check if the colorop was active in the old plane state */
> +	for (colorop =3D old_plane_state->color_pipeline; colorop; colorop =3D =
colorop->next)
> +		if (colorop =3D=3D new_colorop_state->colorop)
> +			return 0;
> +
> +	/* Colorop is not part of an active color pipeline. */
> +	return -EINVAL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609121230.1358=
786-1-mwen@igalia.com?part=3D2
