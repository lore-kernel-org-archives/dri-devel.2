Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66533C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACF7210E3E5;
	Thu, 16 Jul 2026 20:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HwYrdElh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56DC910E3E5
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:31:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 663DF60A5E;
 Thu, 16 Jul 2026 20:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E559D1F000E9;
 Thu, 16 Jul 2026 20:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784233871;
 bh=v2MjMfPLTrFGg6XvjdkhMC0lptHmvwtkp+iQ3rXdUWY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HwYrdElh9oEnXBac/IMP8S+S/rE3HO2E9auluK4DnQB3OCWBoKd+OKTo5Ir7CNu8u
 v5mn8QwNNWnCqHCQ3Kkqio9SgFlI330XkrCY5m+w7xTwxcpJbnR0fErXGhQVd5DsNB
 b7ays5/MWQ3HeLPKNMk6dlfz2jYijOn7GkHSQBmgvnWaOwLSuhwWTUUisYHqGRJEtR
 dJ+hCx7hY+kyw0u3x5dz97HhlUwU1XCFO5fYfJtzYKz09OEbSwhMfl/IO6yHQzPacK
 FEFJY0ev0YS+xT0yljD2Cz5B3Cervl5fn90cEs0eYM9deG8ktpNyd97X/7l8fVpgag
 Cw55i3pWTNKVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/10] drm/msm: Fix barriers accessing ctx vm
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716201538.365824-2-robin.clark@oss.qualcomm.com>
References: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
 <20260716201538.365824-2-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 20:31:10 +0000
Message-Id: <20260716203110.E559D1F000E9@smtp.kernel.org>
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
- [High] MSM VM Lazy Initialization Violation / NULL Pointer Dereference in=
 `msm_ioctl_gem_submit` and `msm_gem_new_handle`
- [High] Incomplete barrier fix: `msm_gem_close()` performs a lockless plai=
n read of `ctx->vm` leading to a data race
--

--- Patch [1]: [PATCH v5 01/10] drm/msm: Fix barriers accessing ctx vm ---
commit fdc4f5db0f02ec8c94395cb949b516d777a3923b
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Fix barriers accessing ctx vm

This patch fixes a race condition by using smp_load_acquire and
smp_store_release when accessing ctx->vm. This prevents callers from
seeing a partially initialized vm.

> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 79f78e7e16e9d..3c8b5083a1fbe 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -225,18 +225,19 @@ struct drm_gpuvm *msm_context_vm(struct drm_device =
*dev, struct msm_context *ctx
>  {
>  	static DEFINE_MUTEX(init_lock);
>  	struct msm_drm_private *priv =3D dev->dev_private;
> +	struct drm_gpuvm *vm =3D smp_load_acquire(&ctx->vm);

[Severity: High]
This isn't a bug introduced by this patch, but since we are fixing the
barriers for ctx->vm here, do we also need to update msm_gem_close()?

It appears to perform a lockless plain read of ctx->vm:

drivers/gpu/drm/msm/msm_gem.c:msm_gem_close() {
	...
	if (!ctx->vm)
		return;

	/* ... */
	msm_gem_lock_vm_and_obj(&exec, obj, ctx->vm);
	...
}

Could this race with the smp_store_release() during VM creation and
observe a partially initialized VM object?

[Severity: High]
This is a pre-existing issue, but I noticed there are still direct accesses
to ctx->vm instead of using msm_context_vm() for lazy initialization.

For example, in msm_ioctl_gem_submit():

drivers/gpu/drm/msm/msm_gem_submit.c:msm_ioctl_gem_submit() {
	...
	if (to_msm_vm(ctx->vm)->unusable)
	...
}

And also in msm_gem_new_handle():

drivers/gpu/drm/msm/msm_gem.c:msm_gem_new_handle() {
	...
	struct drm_gem_object *r_obj =3D drm_gpuvm_resv_obj(ctx->vm);
	...
}

If ctx->vm is NULL before initialization, could these direct accesses
result in a NULL pointer dereference?

> =20
>  	/* Once ctx->vm is created it is valid for the lifetime of the context:=
 */
> -	if (ctx->vm)
> -		return ctx->vm;
> +	if (vm)
> +		return vm;
> +
> +	guard(mutex)(&init_lock);
> =20
> -	mutex_lock(&init_lock);
>  	if (!ctx->vm) {
> -		ctx->vm =3D msm_gpu_create_private_vm(
> +		vm =3D msm_gpu_create_private_vm(
>  			priv->gpu, current, !ctx->userspace_managed_vm);
> -
> +		smp_store_release(&ctx->vm, vm);
>  	}
> -	mutex_unlock(&init_lock);
> =20
>  	return ctx->vm;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716201538.3658=
24-1-robin.clark@oss.qualcomm.com?part=3D1
