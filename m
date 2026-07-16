Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F97C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7426610F3D2;
	Thu, 16 Jul 2026 20:43:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g/FY5ICS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED0110F3D2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:43:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B64FE60A5E;
 Thu, 16 Jul 2026 20:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425001F000E9;
 Thu, 16 Jul 2026 20:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784234588;
 bh=txn0kKd0ipzK/Uu85uoqr48uYE14CKJKi99Ohjckch8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=g/FY5ICSP+VKSffFovwLu202lJaoYUSn6KHNSdr4g66t4QnqhV2ZfSqobHKDq/2Wb
 LgMU7ftguGofx9ryK+P7ud/j/Xspx4zHGu0sljvv1M8bHkHUZ99I8YOXRRO10jxPUO
 rqLDTo1/PKN30G5s8MiTai5VsRysVacjPRkUxoFGie/MsujIjXU9TEFktmpPmQP4/R
 3Wy62d0wsOO1ZCPyJkJ9oKM3gYZTzh+pZqZY+3UZHUtbaFcdO6enXXrw9kWU0/1CHJ
 giEtiToOPebAOaYAM1rmrExYMB8ZPeKnI4IuHfAZYL/uo36J6Zqj4m1ap3GMaQvI4V
 y5q21nrQVsmyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/10] drm/msm/a6xx: Access VM directly in submit path
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716201538.365824-5-robin.clark@oss.qualcomm.com>
References: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
 <20260716201538.365824-5-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 20:43:07 +0000
Message-Id: <20260716204308.425001F000E9@smtp.kernel.org>
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
- [Critical] Direct access to uninitialized `ctx->vm` during early ioctl va=
lidation causes a NULL pointer dereference.
--

--- Patch [4]: [PATCH v5 04/10] drm/msm/a6xx: Access VM directly in submit =
path ---
commit 006ce0b84643f1999004dcef9a0a6a167c16efae
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/a6xx: Access VM directly in submit path

This commit changes the a6xx_set_pagetable() function to access the
context VM directly (ctx->vm) instead of calling msm_context_vm(). It
relies on the assumption that the GEM_SUBMIT ioctl has already ensured
the VM is created by the time this code is reached.

> drm/msm/a6xx: Access VM directly in submit path
>=20
> The GEM_SUBMIT ioctl has already ensured that the VM is created, so we
> aren't expecting to lazily create the VM this deep into the ioctl.

[Severity: Critical]
This is a pre-existing issue, but does the GEM_SUBMIT ioctl actually ensure
the VM is created?

Looking at msm_ioctl_gem_submit() in drivers/gpu/drm/msm/msm_gem_submit.c,
the early validation path accesses the VM directly without calling
msm_context_vm() to ensure it has been created:

drivers/gpu/drm/msm/msm_gem_submit.c:msm_ioctl_gem_submit() {
    ...
	if (to_msm_vm(ctx->vm)->unusable)
		return UERR(EPIPE, dev, "context is unusable");
    ...
}

Can unprivileged userspace trigger a NULL pointer dereference by calling the
MSM_GEM_SUBMIT ioctl on a fresh DRM device descriptor where the context VM
has not been lazily initialized yet?

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index 8b3bb2fd433ba..7f1673163f671 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> @@ -229,7 +229,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_=
gpu,
>  {
>  	bool sysprof =3D msm_gpu_sysprof_no_perfcntr_zap(&a6xx_gpu->base.base);
>  	struct msm_context *ctx =3D submit->queue->ctx;
> -	struct drm_gpuvm *vm =3D msm_context_vm(submit->dev, ctx);
> +	struct drm_gpuvm *vm =3D ctx->vm;
>  	struct adreno_gpu *adreno_gpu =3D &a6xx_gpu->base;
>  	phys_addr_t ttbr;
>  	u32 asid;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716201538.3658=
24-1-robin.clark@oss.qualcomm.com?part=3D4
