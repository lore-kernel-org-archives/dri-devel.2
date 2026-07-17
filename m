Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE8EC44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 21:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91E8A10F608;
	Fri, 17 Jul 2026 21:04:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZOIz/DZh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A59FB10F608
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 21:03:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E158C60051;
 Fri, 17 Jul 2026 21:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0DE1F000E9;
 Fri, 17 Jul 2026 21:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784322237;
 bh=eVdLTA+AjRVyiOHKoWClusW2vmQUFpZhrZsRwdr3/FQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZOIz/DZhdWz/NkwRbr1av8dJr8uFTazi/uVFPg4c1msZrAbvI+awW9Z8bKKYYHpBF
 2kuaI7StIscibAQURlUXDopQhSDAkJ6UAG9PmHyljdZUfUQRoZ51bI5mCO9GUu1Ths
 8nesN8S1KIde/I5Ausy63BnHDcYHIdhzG/Kcg+cIrG/Kha9ySqgBvWlATJ4cb+CVsM
 XZOC1GFpR9ioglEkJBBza9EhjquCAPcMhoE7dfJFgt9Rsb83wEXL2q/BideKgGuMGU
 bLdbDmPIXG/Mw5sGNkPtHrJICiaPeJFAH/qPf1hhjEhhSHuitYV17fzXDUry/8wGXv
 mFlLBHtl+V2JA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/16] drm/msm/a6xx: Access VM directly in submit path
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717204841.26120-8-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
 <20260717204841.26120-8-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 21:03:56 +0000
Message-Id: <20260717210357.6D0DE1F000E9@smtp.kernel.org>
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
- [Critical] The size calculation for the `msm_gem_submit` structure wraps =
around on 64-bit architectures, bypassing the `sz > SIZE_MAX` check and lea=
ding to a heap buffer overflow.
- [High] Direct access to `ctx->vm` in `msm_ioctl_gem_submit` before the VM=
 is guaranteed to be created causes a NULL pointer dereference.
--

--- Patch [7]: [PATCH v6 07/16] drm/msm/a6xx: Access VM directly in submit =
path ---
commit e716d49994df650aa89eca4941226567c71dbab5
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm/a6xx: Access VM directly in submit path

This patch changes the submit path to access the VM directly from the conte=
xt
rather than calling msm_context_vm() to lazily create it. It relies on the
assumption that the ioctl has already ensured the VM is created prior to th=
is
point in the execution flow.

> The GEM_SUBMIT ioctl has already ensured that the VM is created, so we
> aren't expecting to lazily create the VM this deep into the ioctl.

[Severity: High]
This isn't a bug introduced by this patch, but does this assumption hold tr=
ue?

Looking at the ioctl entry point in msm_ioctl_gem_submit(), if userspace
triggers this ioctl before any operation that creates the VM, the VM pointer
is initially null:

drivers/gpu/drm/msm/msm_gem_submit.c:msm_ioctl_gem_submit() {
    ...
	if (to_msm_vm(ctx->vm)->unusable)
		return UERR(EPIPE, dev, "context is unusable");
    ...
}

Can this direct access to ctx->vm cause a null pointer dereference, since a
preceding call to msm_context_vm() hasn't guaranteed its existence yet?

> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/=
adreno/a6xx_gpu.c
> index e293b4ca808a4..9240c4af687c9 100644
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

While reviewing the submit path related to this change, I noticed another
pre-existing issue in the submission creation logic:

drivers/gpu/drm/msm/msm_gem_submit.c:submit_create() {
    ...
	sz =3D struct_size(submit, bos, nr_bos) +
			((u64)nr_cmds * sizeof(submit->cmd[0]));

	if (sz > SIZE_MAX)
		return ERR_PTR(-ENOMEM);
    ...
}

[Severity: Critical]
This is a pre-existing issue, but does this check protect against integer
overflows effectively?

Since sz is a 64-bit unsigned integer, the check sz > SIZE_MAX is
mathematically impossible and acts as dead code.

If a user provides a sufficiently large nr_bos, struct_size() saturates to
SIZE_MAX. Adding a non-zero value for nr_cmds then causes sz to wrap around
to a small value.

Could this lead to an undersized buffer allocation from kzalloc() and a
subsequent out-of-bounds heap write during initialization?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717204841.2612=
0-1-robin.clark@oss.qualcomm.com?part=3D7
