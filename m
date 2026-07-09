Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F59C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B14D310F396;
	Thu,  9 Jul 2026 06:31:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EO5g8AKB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ECD910F396
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:31:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3A66A434FA;
 Thu,  9 Jul 2026 06:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DD31F00A3A;
 Thu,  9 Jul 2026 06:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783578685;
 bh=KpEclguQWd1QwamegFVBpksH13+qP10KbAWjAfAHmyk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EO5g8AKBjzXg6sThnrTxn8ircOULPR9YrA7sSjsqVm9tvIJOjYyYP6yL2F8IIq2sn
 XtQ99pWD5NzAVihEsnOsUahzm0HYiGtMIS+BMNbvZnMHt7vzD4JM8mVZEyvGQf2EnT
 ANS6j3U2jhkfpnDRoyf5L4Cu+J3/Xnm3cJqUPthskLx9/DwI59ez2kiAlC6wbY1gmQ
 eXM1d/wb4NQzt9PNq9+sAXuIhXOlOI9gWwYvvvvg/+gguO4aDrW4qKqZIVDYEcMBph
 ef9SIa5z0Jppbow6oLCnsyAgIZdeiMAg/RRp1vxV6Bt57gmfEK2DV33N33ETfgcc0K
 Lx41hjWWst/GA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm: Only fini scheduler after successful init
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709062309.4168362-1-ruoyuw560@gmail.com>
References: <20260709062309.4168362-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 06:31:24 +0000
Message-Id: <20260709063124.E6DD31F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing error check for msm_fence_context_alloc() return value lea=
ds to invalid pointer dereference.
- [High] Direct access to ctx->vm without lazy initialization causes NULL p=
ointer dereference.
--

--- Patch [1]: [PATCH] drm/msm: Only fini scheduler after successful init -=
--
commit b85d84ece3c22f19d85b416480e8fa8cc2d6160b
Author: Ruoyu Wang <ruoyuw560@gmail.com>

drm/msm: Only fini scheduler after successful init

msm_ringbuffer_new() destroys a partially initialized ring through
msm_ringbuffer_destroy() when an allocation or scheduler setup step
fails. If drm_sched_init() fails before it finishes initializing the
scheduler, the failure path still calls drm_sched_fini() which assumes
the state was fully initialized. This patch tracks successful scheduler
initialization and calls drm_sched_fini() only after drm_sched_init()
returned 0.

[ ... ]

> diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/m=
sm_ringbuffer.c
> index 0d14c31bd4e47..af2b0edc4d586 100644
> --- a/drivers/gpu/drm/msm/msm_ringbuffer.c
> +++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
[ ... ]
> @@ -132,7 +132,8 @@ void msm_ringbuffer_destroy(struct msm_ringbuffer *ri=
ng)
>  	if (IS_ERR_OR_NULL(ring))
>  		return;
> =20
> -	drm_sched_fini(&ring->sched);
> +	if (ring->sched_initialized)
> +		drm_sched_fini(&ring->sched);
> =20
>  	msm_fence_context_free(ring->fctx);

[Severity: High]
This isn't a regression introduced by this patch, but there is a missing er=
ror
check for the msm_fence_context_alloc() return value.

drivers/gpu/drm/msm/msm_ringbuffer.c:msm_ringbuffer_new() {
    ...
	snprintf(name, sizeof(name), "gpu-ring-%d", ring->id);

	ring->fctx =3D msm_fence_context_alloc(gpu->dev, &ring->memptrs->fence, na=
me);

	return ring;
}

msm_fence_context_alloc() can return ERR_PTR(-ENOMEM) on memory allocation
failure. The error pointer is assigned to ring->fctx without an IS_ERR()
validation, and the new ring object is returned as if successful.

When the ring is later destroyed here, msm_ringbuffer_destroy() passes the
error pointer to msm_fence_context_free(), which calls kfree() on it.

Does this need an IS_ERR() check to prevent an invalid memory access?

[ ... ]

[Severity: High]
This is also a pre-existing regression, but could this lead to a NULL point=
er
dereference?

drivers/gpu/drm/msm/msm_gem.c:msm_gem_new_handle() {
    ...
	if (flags & MSM_BO_NO_SHARE) {
		struct msm_context *ctx =3D file->driver_priv;
		struct drm_gem_object *r_obj =3D drm_gpuvm_resv_obj(ctx->vm);
    ...
}

The MSM driver lazily initializes virtual memory address spaces. If userspa=
ce
calls an ioctl that triggers msm_gem_new_handle() with the MSM_BO_NO_SHARE =
flag
before the VM is initialized, ctx->vm will be NULL.

Passing this NULL pointer to drm_gpuvm_resv_obj(ctx->vm) results in
dereferencing NULL to access the r_obj field.=20

Should this use the msm_context_vm() accessor instead to ensure the VM is
initialized before access?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709062309.4168=
362-1-ruoyuw560@gmail.com?part=3D1
