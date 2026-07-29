Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75843C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD64510EAF1;
	Wed, 29 Jul 2026 08:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VlE/vetz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B06C10EAF1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:05:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BDE7960A65;
 Wed, 29 Jul 2026 08:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496221F000E9;
 Wed, 29 Jul 2026 08:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785312298;
 bh=XZtfPealowWy6em8T+FVRwCN1+VW95f+xLNnoKU+PfI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VlE/vetzH4F84jd5AZDJYtFauBHAQHJWTgwpYeMLiXkwG3ptPoW+MtA5MTA0gP6e0
 9acAaX5Gjnj33X33hPId2jY8x2hekUocbsEJOdfwjfBz0HfS1MnWocLPAKhl2vIXkU
 VVB47J6eyiWvcz1zlw82Ny9KTUOK8vcS1ccbUppHIbDTQ2V8QAj1bFFKOZ0Mss8fPC
 CcIO7yC3gP5iHrYPu1BaDSYDZnWxnOn8E+VV/DoGUkf0HAxS4P53crI9btAiCy80CA
 UnUYOekOwc0N9m0+w9YmTpQgSQbhZXGFXspGrEyof1bwh7qf9sTkcfoQB2Nxllibao
 ZdTKKFYhrd28A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/atomic: remove bogus check for file_priv
To: "Thadeu Lima de Souza Cascardo" <cascardo@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729-drm_atomic_bogus_check-v1-1-a4d5bd4ae4c8@igalia.com>
References: <20260729-drm_atomic_bogus_check-v1-1-a4d5bd4ae4c8@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 08:04:57 +0000
Message-Id: <20260729080458.496221F000E9@smtp.kernel.org>
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
- [High] Memory leak of `struct drm_pending_vblank_event` in `prepare_signa=
ling()` error paths when `OUT_FENCE_PTR` is requested without `DRM_MODE_PAG=
E_FLIP_EVENT`.
--

--- Patch [1]: [PATCH] drm/atomic: remove bogus check for file_priv ---
commit 005f3f9bbee21ecd8f3b8b2687c9b0a8040286cc
Author: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

drm/atomic: remove bogus check for file_priv

This commit removes a file_priv check in prepare_signaling(), since
drm_mode_atomic_ioctl() guarantees it is never NULL. Skipping the block
here would cause a memory leak of drm_pending_vblank_event.

> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
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
This is a pre-existing issue, but can this function leak the
drm_pending_vblank_event if an OUT_FENCE_PTR is requested without a
DRM_MODE_PAGE_FLIP_EVENT?

If a user submits an atomic commit that requests an out-fence but does not
request a page flip event, prepare_signaling() allocates an event:

    if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT || fence_ptr) {
        ...
        e =3D create_vblank_event(crtc, arg->user_data);
        ...
        crtc_state->event =3D e;
    }

If the subsequent setup_out_fence() fails (e.g. from FD exhaustion), the
function returns an error before setting event->base.fence:

    ret =3D setup_out_fence(&f[(*num_fences)++], fence);
    if (ret) {
        dma_fence_put(fence);
        return ret;
    }
   =20
    crtc_state->event->base.fence =3D fence;

In the cleanup path, complete_signaling() relies on event->base.fence or
event->base.file_priv being set to free the event:

    if (event && (event->base.fence || event->base.file_priv)) {
        drm_event_cancel_free(dev, &event->base);
        crtc_state->event =3D NULL;
    }

Since both fields are NULL, does the event get permanently leaked on this
error path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-drm_atomic=
_bogus_check-v1-1-a4d5bd4ae4c8@igalia.com?part=3D1
