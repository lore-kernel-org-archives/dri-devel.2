Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815C1CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 11:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8830D10E2BA;
	Mon, 22 Jun 2026 11:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FgfqUUa6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA6F310E2BA
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 11:47:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2CC656001A;
 Mon, 22 Jun 2026 11:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D371F000E9;
 Mon, 22 Jun 2026 11:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782128861;
 bh=QfVifaPDpE332xex4eu/kmiXJxOW4t7DIo+E81dTru0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FgfqUUa6TyDybuFtG3Eja8YzRxYYTi4DlJuzKACxxli3hVDzNV/64phMCnfQazH2e
 iaDwSzvTwrH2ZfW3TU5ajADYwvAcZpmcdq25Nnhu9/0tiLF+S+UHKnZ9l4F8abMRkp
 HoNTbtjQMRQFTI31zqszLjiMKx48Cnzpm3NbBRG4rVDOrmYI+TYjVp8Co7i43BiWxO
 ZNzCz0VMJzpVN1Nhbg3044CnFRgYAZwyLTM9L1Wymz4Qy1EtE3Losvr2xBpXUl4F5N
 VEpHnYpWcZFB5sxhwVaDwFXaNCUSCuo8d9LofyyiWdThiX3rIoaHTHGe2k8NO3igWI
 YLVHWChIXZwug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/fb-helper: Only consider active CRTCs for vblank
 sync
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622113434.682292-1-tzimmermann@suse.de>
References: <20260622113434.682292-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 11:47:41 +0000
Message-Id: <20260622114741.B2D371F000E9@smtp.kernel.org>
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
- [Critical] Lockless dereference of atomic state pointers (`plane->state` =
and `crtc->state`) in `find_crtc_index_atomic` can lead to Use-After-Free d=
uring concurrent atomic commits.
--

commit 789de6442f862dfb55a96bcc0ed2477d4a69bfd2
Author: Thomas Zimmermann <tzimmermann@suse.de>
Subject: drm/fb-helper: Only consider active CRTCs for vblank sync

This patch modifies the fbdev emulation to only synchronize to the vblank of
an active CRTC. It introduces separate lookup paths for atomic and non-atom=
ic
drivers to find the correct CRTC index.

Link: https://lore.kernel.org/dri-devel/1c9e0e24-9c4a-4259-8700-cf9e5fd60ca=
3@suse.de/
Closes: https://bugs.debian.org/1138033

> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_hel=
per.c
> index 7b11a582f8ec4..cbf0a9a7b8e51 100644
> --- a/drivers/gpu/drm/drm_fb_helper.c
> +++ b/drivers/gpu/drm/drm_fb_helper.c
> @@ -225,16 +225,85 @@ static void drm_fb_helper_resume_worker(struct work=
_struct *work)
[ ... ]
> +static int find_crtc_index_atomic(struct drm_fb_helper *helper)
> +{
> +	struct drm_device *dev =3D helper->dev;
> +	struct drm_plane *plane;
> +
> +	drm_for_each_plane(plane, dev) {
> +		const struct drm_plane_state *plane_state;
> +		const struct drm_crtc *crtc;
> +
> +		if (plane->type !=3D DRM_PLANE_TYPE_PRIMARY)
> +			continue;
> +
> +		plane_state =3D plane->state;
> +		if (plane_state->fb !=3D helper->fb || !plane_state->crtc)
> +			continue; /* plane doesn't display fbdev emulation */

[Severity: Critical]
Is it safe to access plane->state here without holding the appropriate
plane locks?

Since dev->mode_config.mutex is held but plane->mutex is not, could a
concurrent atomic commit from another DRM master swap and free plane->state
while this function is executing?

> +
> +		crtc =3D plane_state->crtc;
> +		if (!crtc->state->active)
> +			continue;

[Severity: Critical]
If a use-after-free occurs on plane->state, could it lead to reading a fake
crtc pointer, dereferencing its state, and returning an arbitrary crtc->ind=
ex?

> +		if (drm_WARN_ON_ONCE(dev, crtc->index > INT_MAX))
> +			continue; /* driver bug */
> +
> +		return crtc->index;
> +	}
> +
> +	return -EINVAL;
> +}
[ ... ]
>  static void drm_fb_helper_fb_dirty(struct drm_fb_helper *helper)
>  {
[ ... ]
>  	mutex_lock(&helper->lock);
> -	drm_client_modeset_wait_for_vblank(&helper->client, 0);
> +	crtc_index =3D drm_fb_helper_find_crtc_index(helper);
> +	if (crtc_index >=3D 0)
> +		drm_client_modeset_wait_for_vblank(&helper->client, crtc_index);
>  	mutex_unlock(&helper->lock);

[Severity: Critical]
Because drm_fb_helper_find_crtc_index() is called before checking if we sti=
ll
own the DRM master (which happens inside drm_client_modeset_wait_for_vblank
via drm_master_internal_acquire), could an unprivileged user writing to
/dev/fb0 trigger this lookup concurrently with an active userspace
compositor's atomic commits, exposing the race condition mentioned above?

Furthermore, if an attacker can control the returned crtc_index, could it l=
ead
to an out-of-bounds array read in drm_client_modeset_wait_for_vblank() when=
 it
does:

    crtc =3D client->modesets[crtc_index].crtc;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622113434.6822=
92-1-tzimmermann@suse.de?part=3D1
