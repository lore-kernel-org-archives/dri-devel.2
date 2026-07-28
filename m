Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC72C54F4D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AEE510E157;
	Tue, 28 Jul 2026 14:51:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QEKR7ACg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B4B310E157
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 14:51:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0C7C043458;
 Tue, 28 Jul 2026 14:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97841F00A3A;
 Tue, 28 Jul 2026 14:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785250277;
 bh=ZrM7SLcTgkZ610NiLLQuIQWNSQO/YD7s6oeyxFBA2Bs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QEKR7ACg1OaCBpDHL7UK9SUGZdZjWJg9OB5uTGdmeBy/1MAZWt+1M5rxX5PMxgjwJ
 ZxCG7F+jj9zDmsStfjEfN5tX34nqzGAT3v7y5D1cHBPl9MRmfSqdYWy9/CNlbWiOBy
 cBoKfj/ML8kC+DBsIgYgxOp+4gah/VNNLArIYo0Ch7X3hr8RKr3sSWU8HxbMboWhvr
 VtdOsZXp+e9AbfkZAOrddua5NhkW6vS2kUY1jBJxdSR3QlIDv+VF/gzu6JvI9JmpQl
 cDUCwBypXQACNC8311h0DggmpsiFiTkTpWh8lHQViZBA+SJHiA62JLpfc8xaLwiscW
 bqBltgFqOlosQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm: Fix drm_pending_vblank_event in error path for
 out_fence_ptr
To: "Thadeu Lima de Souza Cascardo" <cascardo@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728-drm_pending_vblank_event_leak-v1-1-08429b920b16@igalia.com>
References: <20260728-drm_pending_vblank_event_leak-v1-1-08429b920b16@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 14:51:17 +0000
Message-Id: <20260728145117.B97841F00A3A@smtp.kernel.org>
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
- [Critical] Use-After-Free and List Corruption in DRM Atomic Error Path
--

--- Patch [1]: [PATCH] drm: Fix drm_pending_vblank_event in error path for =
out_fence_ptr ---
commit d91030dbda8d5aae203f2c2d58622099629e2e8a
Author: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

drm: Fix drm_pending_vblank_event in error path for out_fence_ptr

This commit frees the allocated drm_pending_vblank_event when setting up an
out_fence_ptr fails. This prevents a leak if there is an allocation or setup
failure after the event was created but DRM_MODE_PAGE_FLIP_EVENT was not se=
t.

Link: https://sashiko.dev/#/patchset/20260727-drm_crtc_atomic_commit_leak-v=
1-1-23d9948a9d7c@igalia.com?part=3D1

> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c

[ ... ]

> @@ -1464,11 +1464,15 @@ static int prepare_signaling(struct drm_device *d=
ev,
>  		if (fence_ptr) {
>  			struct dma_fence *fence;
>  			struct drm_out_fence_state *f;
> +			struct drm_pending_vblank_event *e =3D crtc_state->event;
> =20
>  			f =3D krealloc(*fence_state, sizeof(**fence_state) *
>  				     (*num_fences + 1), GFP_KERNEL);
> -			if (!f)
> +			if (!f) {
> +				kfree(e);
> +				crtc_state->event =3D NULL;
>  				return -ENOMEM;
> +			}
> =20
>  			memset(&f[*num_fences], 0, sizeof(*f));
> =20
> @@ -1476,12 +1480,17 @@ static int prepare_signaling(struct drm_device *d=
ev,
>  			*fence_state =3D f;
> =20
>  			fence =3D drm_crtc_create_fence(crtc);
> -			if (!fence)
> +			if (!fence) {
> +				kfree(e);
> +				crtc_state->event =3D NULL;
>  				return -ENOMEM;
> +			}
> =20
>  			ret =3D setup_out_fence(&f[(*num_fences)++], fence);
>  			if (ret) {
>  				dma_fence_put(fence);
> +				kfree(e);
> +				crtc_state->event =3D NULL;
>  				return ret;
>  			}

[Severity: Critical]
Can these error paths cause a use-after-free and list corruption if
DRM_MODE_PAGE_FLIP_EVENT was also set?

If DRM_MODE_PAGE_FLIP_EVENT is set, the code just prior to this block calls
drm_event_reserve_init() which adds the event to the pending_event_list:

	if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT) {
		...
		ret =3D drm_event_reserve_init(dev, file_priv, &e->base,
					     &e->event.base);
		...
	}

If the out fence allocations or setup_out_fence() subsequently fail, kfree(=
e)
is called directly in the new error paths without unlinking the event.
Traversing the pending_event_list later (such as during file close in
drm_events_release) could then access freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-drm_pendin=
g_vblank_event_leak-v1-1-08429b920b16@igalia.com?part=3D1
