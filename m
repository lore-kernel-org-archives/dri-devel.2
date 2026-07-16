Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FE8C44514
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C286B10F30E;
	Thu, 16 Jul 2026 20:33:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YpJ93fRx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9274510F30E
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:33:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B375409B5;
 Thu, 16 Jul 2026 20:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0651F000E9;
 Thu, 16 Jul 2026 20:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784233990;
 bh=Sm/4gsZw8iP+bc9AgoDXkI9RchRcQY5S+uAljycBkgI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YpJ93fRx9VCUlfn3+jIUsV3f7Kw1HMX1+zW3oW58IKAXABtr53lhOfVS4Pt8zFL/g
 SCgrn5NhBJ0JHrpTwwo7QmCAlKxdgnBI7p4my/3+LimMhVfYo5GMahU0tSXbZLG7tL
 /2RsxEd4nr1dWO1tm50IBq2vFREBsXwdA5XZn3hwzQcjWcuaWwJ8cA90T8dx7Q9y7r
 1RbibNcERoS1pAz8CeUwXba1Dvh1oGONMtZLSoJgAQeMBuZaKxTwuTbDdokCRjLqTv
 gy/fhXQ5jny4/FItgwyRhC1YAyDeXrQEsRm4FFuXdd+NeKhPYXY/1RNmJypOLsPfY9
 ip7XeZkRcWmQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/10] drm/msm: Synchronize VM creation on ctxlock
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716201538.365824-4-robin.clark@oss.qualcomm.com>
References: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
 <20260716201538.365824-4-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 20:33:09 +0000
Message-Id: <20260716203309.DB0651F000E9@smtp.kernel.org>
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
- [High] Uninitialized pointer dereference in msm_ioctl_gem_submit bypassin=
g lazy VM initialization
- [High] Privilege escalation via bypassed VM_BIND hardware capability check
--

--- Patch [3]: [PATCH v5 03/10] drm/msm: Synchronize VM creation on ctxlock=
 ---
commit 7a10b1ce7cb7f72d046e9af19750da0d0ced94cb
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Synchronize VM creation on ctxlock

This commit synchronizes virtual memory creation using ctxlock rather
than init_lock. It also adds a read lock when setting EN_VM_BIND to
serialize it against VM creation.

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
[ ... ]
> @@ -503,7 +503,9 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_=
context *ctx,
>  		if (!perfmon_capable())
>  			return UERR(EPERM, drm, "invalid permissions");
>  		return msm_context_set_sysprof(ctx, gpu, value);
> -	case MSM_PARAM_EN_VM_BIND:
> +	case MSM_PARAM_EN_VM_BIND: {
> +		guard(rwsem_read)(&ctx->ctxlock);
> +
>  		/* We can only support VM_BIND with per-process pgtables: */
>  		if (ctx->vm =3D=3D gpu->vm)
>  			return UERR(EINVAL, drm, "requires per-process pgtables");

[Severity: High]
This is a pre-existing issue, but does checking ctx->vm =3D=3D gpu->vm
properly enforce the per-process pgtable requirement?=20

Since the VM is lazily initialized, wouldn't ctx->vm be NULL here?
(This appears to be expected by the subsequent if (ctx->vm) check).

Because ctx->vm is NULL, it will never equal gpu->vm, which seems to
completely bypass this hardware capability check. If a legacy device lacks
create_private_vm, couldn't an unprivileged user bypass this check and gain
userspace-managed control over the global GPU page tables when the VM is
later created?


While reviewing the lazy VM initialization semantics in this subsystem, I
noticed another pre-existing issue in a related file not touched by this
patch:

> --- a/drivers/gpu/drm/msm/msm_gem_submit.c
> +++ b/drivers/gpu/drm/msm/msm_gem_submit.c
> @@ -571,4 +571,5 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void=
 *data,
> =20
>  	if (args->pad)
>  		return -EINVAL;
> =20
>  	if (to_msm_vm(ctx->vm)->unusable)
>  		return UERR(EPIPE, dev, "context is unusable");

[Severity: High]
This is a pre-existing issue, but does msm_ioctl_gem_submit() safely access
the virtual memory context here?

If a user opens the DRM device to create a new context and immediately issu=
es
a DRM_IOCTL_MSM_GEM_SUBMIT ioctl, ctx->vm will still be NULL because it has
not yet been lazily initialized via msm_context_vm().

Could this direct dereference of ctx->vm cause a reliable kernel panic when
evaluated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716201538.3658=
24-1-robin.clark@oss.qualcomm.com?part=3D3
