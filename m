Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EF7C61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B197210E349;
	Mon, 31 Aug 2026 21:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d1c/ieJm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F05810E2B2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 21:16:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C663460053
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 21:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7F61F000E9;
 Mon, 31 Aug 2026 21:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788210984;
 bh=PoEFpBsvfqjcHW7dNMXdpUM3ulMCwNdbmqTVGZlYP2I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d1c/ieJm4TiwDzGRpHDzOeYADuzK01vvBBKe+K1S//ZR6qN+MZrHajgGIH115S03T
 2F16vqjmrCMSMrWhSIQERn0ppZMvClL7GOFFjysDWQGC/HAsjvdFu9GXx/5tmAVQXR
 gb9FIpCvyjDhxxH+phrrxnmSZk0pT3yTK8sOAg/ph9OTeokP5Sr7/bG7e6dgpLI9Ew
 J+4t11b7JW3isRgRkNsJsLa9a7WbO/fG26h9gFaKm/9ulTRmF6hNDUZXrctmZidtlU
 NkfY28NwYTNYfKfplXShHTrA9t38KyhVZTMF4kTZ88Krp50q+PL6xRataCa5EwYCGq
 d+X/zhz11Ht/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 22/40] drm/virtio: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-drm-no-more-plane-reset-v3-22-1877c7aa57b3@kernel.org>
References: <20260831-drm-no-more-plane-reset-v3-0-1877c7aa57b3@kernel.org>
 <20260831-drm-no-more-plane-reset-v3-22-1877c7aa57b3@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:16:23 +0000
Message-Id: <20260831211624.4F7F61F000E9@smtp.kernel.org>
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
- [Medium] Structural memory under-allocation for subclassed plane state. T=
he virtio-gpu driver subclasses `drm_plane_state` into `virtio_gpu_plane_st=
ate` (adding a `fence` member), but uses the generic `drm_atomic_helper_pla=
ne_create_state` helper for its `.atomic_create_state` hook. This helper al=
locates only `sizeof(struct drm_plane_state)`. Consequently, the initial pl=
ane state is under-allocated. Although current subclass field accesses (lik=
e `fence`) are protected by `if (state->fb)` which prevents an immediate ou=
t-of-bounds access on the initial state, this is a strict violation of DRM =
atomic API contracts which mandate custom allocation hooks when subclassing=
 states.
--

commit 021c0051fe694d9f32c7c2b9fb493bbd17a34379
Author: Maxime Ripard <mripard@kernel.org>

drm/virtio: Convert to atomic_create_state

The plane only initializes a pristine state in its reset hook using
drm_atomic_helper_plane_reset(), which is equivalent to what
atomic_create_state expects. Convert to it.

> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/vir=
tio/virtgpu_plane.c
> index 1d1b27ece62a7..52971864db50b 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -91,7 +91,7 @@ drm_plane_state *virtio_gpu_plane_duplicate_state(struc=
t drm_plane *plane)
>  static const struct drm_plane_funcs virtio_gpu_plane_funcs =3D {
>  	.update_plane		=3D drm_atomic_helper_update_plane,
>  	.disable_plane		=3D drm_atomic_helper_disable_plane,
> -	.reset			=3D drm_atomic_helper_plane_reset,
> +	.atomic_create_state =3D drm_atomic_helper_plane_create_state,

[Severity: Medium]
This is a pre-existing issue, but does assigning the generic helper here re=
sult
in structural memory under-allocation for the subclassed plane state?

The virtio-gpu driver subclasses drm_plane_state into virtio_gpu_plane_state
which adds a fence member:

drivers/gpu/drm/virtio/virtgpu_drv.h:
struct virtio_gpu_plane_state {
	struct drm_plane_state base;
	struct virtio_gpu_fence *fence;
};

However, the generic helper drm_atomic_helper_plane_create_state in
drivers/gpu/drm/drm_atomic_state_helper.c only allocates the size of the ba=
se
struct drm_plane_state:

drm_atomic_helper_plane_create_state() {
	...
	state =3D kzalloc_obj(*state);
	...
}

Any subsequent downcast on this initial state treats it as a larger object.
Currently, no out-of-bounds access occurs because accesses to the subclassed
fields (e.g., fence) are guarded by if (state->fb), and the initial state h=
as a
NULL framebuffer.

Should a custom allocation hook be used here to allocate the full
virtio_gpu_plane_state and adhere to the DRM atomic API contracts?

>  	.atomic_duplicate_state =3D virtio_gpu_plane_duplicate_state,
>  	.atomic_destroy_state	=3D drm_atomic_helper_plane_destroy_state,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-drm-no-mor=
e-plane-reset-v3-0-1877c7aa57b3@kernel.org?part=3D22
