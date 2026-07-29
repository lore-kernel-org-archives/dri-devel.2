Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011F5C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:12:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E60610ECE2;
	Wed, 29 Jul 2026 16:12:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oF8em5N/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE7EE10ECEA
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 16:12:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D7ECB43486;
 Wed, 29 Jul 2026 16:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906E71F00A3A;
 Wed, 29 Jul 2026 16:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785341569;
 bh=zHw/eT+IbDqMnM7XMS5Btqbb6oxX2tcrbsBNjwNtYw0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oF8em5N/IN4u1+uRDO9u9xtHRZ97s8XJpGVDU61Kixs76zlt5+yHngtGvPTwxEVFt
 QTs1Dw5lLBlAayrrmH5lBGhlX2hC7JcvSNb/G7zcCsK2XxlQrD+7z4NsK28te1WoqJ
 sJ1J+reNTKbpNJ4WDW9mQQ/N4W4l3IWUc65HcTOeMjBrFI0mIjhnNwEDpkkGw+lVff
 SyQVMTPDX5OUMGSivoZBx5xK9o1JlPJIDSouIGeno5jJ7wdVHvSGufEh1Y3j2b7KLF
 EDly7oyK4Yg06b3mwUn/2jUla9OQsqjOLvT510BHYP056qXOXRWDWr5xY5oa/mrfjW
 4sjnI6AMlnOag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/17] drm/msm: Synchronize set_sysprof on ctxlock
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729155609.20190-5-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
 <20260729155609.20190-5-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:12:49 +0000
Message-Id: <20260729161249.906E71F00A3A@smtp.kernel.org>
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
- [High] Direct access to uninitialized `ctx->vm` allows userspace to enabl=
e VM_BIND on hardware lacking per-process page tables.
--

--- Patch [4]: [PATCH v7 04/17] drm/msm: Synchronize set_sysprof on ctxlock=
 ---
commit 80ad21c966f9ce52663d9bf52f28781c4e97e7e0
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Synchronize set_sysprof on ctxlock

A user that was perfmon_capable() could try to race setting SYSPROF
param on multiple threads to trigger a reference leak.

> diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/=
msm_submitqueue.c
> index 8b5980d5a6a79..233c4f35ab121 100644
> --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
> @@ -9,6 +9,8 @@
> =20
>  int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu=
, int sysprof)
>  {
> +	guard(rwsem_write)(&ctx->ctxlock);
> +
>  	/*
>  	 * Since pm_runtime and sysprof_active are both refcounts, we
>  	 * call apply the new value first, and then unwind the previous

[Severity: High]
This isn't a bug introduced by this patch, but there is a pre-existing issu=
e in
adreno_set_param() when handling MSM_PARAM_EN_VM_BIND:

drivers/gpu/drm/msm/adreno/adreno_gpu.c:adreno_set_param() {
    ...
	case MSM_PARAM_EN_VM_BIND: {
		guard(rwsem_read)(&ctx->ctxlock);

		/* We can only support VM_BIND with per-process pgtables: */
		if (ctx->vm =3D=3D gpu->vm)
			return UERR(EINVAL, drm, "requires per-process pgtables");
    ...
}

Does this direct comparison against an uninitialized (NULL) ctx->vm fail to
reject the VM_BIND enablement on GPUs without per-process page tables?

If a userspace program calls the MSM_PARAM_EN_VM_BIND ioctl early, ctx->vm =
is
NULL due to lazy initialization. The check if (ctx->vm =3D=3D gpu->vm) in
adreno_set_param() evaluates to false, bypassing the hardware capability
check and incorrectly setting ctx->userspace_managed_vm =3D true.

Later, when msm_context_vm() is called, msm_gpu_create_private_vm() returns
the global gpu->vm because the hardware lacks support for private VMs.
Userspace can then use the MSM_VM_BIND ioctl to map memory directly in the
global GPU VM.

Could a malicious userspace program exploit this to map and unmap arbitrary
memory in the global GPU page tables, potentially overwriting mappings of
other contexts and the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729155609.2019=
0-1-robin.clark@oss.qualcomm.com?part=3D4
