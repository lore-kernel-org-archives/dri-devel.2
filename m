Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC45C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67EB610E370;
	Mon, 17 Aug 2026 18:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hBxc6kz4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 918C810E370
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 18:57:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 56BF443AD8;
 Mon, 17 Aug 2026 18:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7191F00A3D;
 Mon, 17 Aug 2026 18:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786993074;
 bh=wvm+hHk68nikVVByInv+JN0H/cqJKjKuXp/AFVF2tyE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hBxc6kz4EFrk4GaITnnGA4qCugR2T3DDBOMONSSv2z3x9K6/A8vMMHzRIeWT4090t
 TOd+2lshToIZ+jbRWmPn2PDipH4a3wGC6uy1231MUfHYmRi1TO2umgjCOs63Wg8p+j
 lAWyYUc/C3K9n20JoQ660iLA+YgjUtWxrM5K9TbIrfmmkdYVB9hQJZgMxz4lNO/Rd5
 9iRstB9hFKTy+G5MoQGN5mNxonOhFxyzbOMn2sfevmr2I6WLsYWwN2cG6JnKqxsuyt
 /onwXlc0IC5tvp4BkyjJFWuSPj8qX75kNBilvMfrpGzL8JLwdI3lViCR3DpXpS3c4s
 /dGFJRo/vRyVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/atomic: remove bogus check for file_priv
To: "Thadeu Lima de Souza Cascardo" <cascardo@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260817-drm_atomic_bogus_check-v2-1-2b9e60f32a7e@igalia.com>
References: <20260817-drm_atomic_bogus_check-v2-1-2b9e60f32a7e@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 18:57:53 +0000
Message-Id: <20260817185754.0E7191F00A3D@smtp.kernel.org>
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
- [High] A memory leak of `struct drm_pending_vblank_event` occurs in `prep=
are_signaling` when an error happens during out-fence setup and `DRM_MODE_P=
AGE_FLIP_EVENT` is not requested, allowing userspace to exhaust kernel memo=
ry.
--

--- Patch [1]: [PATCH v2] drm/atomic: remove bogus check for file_priv ---
commit 51977ecd1b08bc9f3e31da1b4219cb831a4fdaa9
Author: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

drm/atomic: remove bogus check for file_priv

This commit removes an unreachable check for file_priv being NULL at
prepare_signaling() since it can never be NULL. If it were NULL, skipping
the block would cause the drm_pending_vblank_event object to leak. Since
it is unreachable, no leak was possible from this specific check.

Link: https://patch.msgid.link/20260729-drm_atomic_bogus_check-v1-1-a4d5bd4=
ae4c8@igalia.com

> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index e997917819e8e..657c15474ed50 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1445,9 +1445,6 @@ static int prepare_signaling(struct drm_device *dev,
>  		if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT) {
>  			struct drm_pending_vblank_event *e =3D crtc_state->event;
> =20
> -			if (!file_priv)
> -				continue;
> -
>  			ret =3D drm_event_reserve_init(dev, file_priv, &e->base,
>  						     &e->event.base);
>  			if (ret) {

[Severity: High]
This is a pre-existing issue, but does prepare_signaling() leak the
drm_pending_vblank_event object when an out-fence setup fails?

If userspace calls DRM_IOCTL_MODE_ATOMIC without the DRM_MODE_PAGE_FLIP_EVE=
NT
flag, but with an OUT_FENCE_PTR property pointing to an invalid memory
address, prepare_signaling() allocates the event:

	e =3D create_vblank_event(crtc, arg->user_data);

Because DRM_MODE_PAGE_FLIP_EVENT is not set, drm_event_reserve_init() is
skipped, leaving e->base.file_priv as NULL.

Later, setup_out_fence() can fail during put_user() due to the invalid
pointer, returning -EFAULT:

	ret =3D setup_out_fence(&f[(*num_fences)++], fence);
	if (ret) {
		dma_fence_put(fence);
		return ret;
	}

This returns early before crtc_state->event->base.fence is set.

On the error unwinding path, complete_signaling() checks if it should free
the event:

	if (event && (event->base.fence || event->base.file_priv)) {
		drm_event_cancel_free(dev, &event->base);
		crtc_state->event =3D NULL;
	}

Since both base.fence and base.file_priv are NULL, it skips freeing the
event.

Can a malicious userspace program repeatedly trigger this failure to exhaust
kernel memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817-drm_atomic=
_bogus_check-v2-1-2b9e60f32a7e@igalia.com?part=3D1
