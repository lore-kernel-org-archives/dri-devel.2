Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAECC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 16:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0779F10ECE0;
	Wed, 29 Jul 2026 16:11:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VdBvM2AX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5043D10ECE0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 16:11:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C82686001D;
 Wed, 29 Jul 2026 16:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514881F00A3A;
 Wed, 29 Jul 2026 16:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785341517;
 bh=lzTu5E+J2OY8qGiIlDcajOjhHJZ2FwNaiUolPvs8I/c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VdBvM2AXk5SNjFbHir6lZNpMBCQKHZ+L2X1KxYFOR7DviAYstDKVfDAx3Uk3T3Da5
 eTpdPmOXkvXwOTTTw9Z2IrsxwweYmgsG2RW/oi4gVkz7I3lwpsmZU/b1VWlq9gM9JB
 n5s0zZYH/p146v09zgYhGffcop5nhhpvFkl0+hIBWt8nL3nv72LrCPMZPQDIGeJs/n
 cVyr/JRsXrTC3CXE1/pMTkzmL46V/GqnlU+Ua+0+8Pw0dEHsUia2V6iP9SypBKkK3M
 Kiwu7tHcAjDaOb6BK0pGVQwdf1jmyfaQdE2NF+PbK9hEQAiaHljoqIUvcRpghODzyV
 Nkcl1UZa30NRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/17] drm/msm: Add helper to check for per-process
 pgtables VM
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729155609.20190-9-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
 <20260729155609.20190-9-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:11:56 +0000
Message-Id: <20260729161157.514881F00A3A@smtp.kernel.org>
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
- [High] Direct access to `ctx->vm` in `adreno_set_param()` bypasses capabi=
lity checks for per-process pgtables, allowing userspace to enable VM_BIND =
on unsupported hardware and crash the kernel.
--

--- Patch [8]: [PATCH v7 08/17] drm/msm: Add helper to check for per-proces=
s pgtables VM ---
commit c61563d7d541358abb7f78356a4f5b717a237572
Author: Rob Clark <robin.clark@oss.qualcomm.com>

drm/msm: Add helper to check for per-process pgtables VM

This patch adds a helper function to validate whether a GPU VM supports
per-process pagetables. It then updates adreno_get_param() to use this
new helper.

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index 0d54141ff089c..5738eac9aebd6 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -356,6 +356,12 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsign=
ed long iova, int flags,
>  	return 0;
>  }
> =20
> +static bool
> +valid_per_process_vm(struct msm_gpu *gpu, struct drm_gpuvm *vm)
> +{
> +	return (vm !=3D gpu->vm);
> +}
> +
>  int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
>  		     uint32_t param, uint64_t *value, uint32_t *len)
>  {
> @@ -414,12 +420,12 @@ int adreno_get_param(struct msm_gpu *gpu, struct ms=
m_context *ctx,
>  		*value =3D gpu->suspend_count;
>  		return 0;
>  	case MSM_PARAM_VA_START:
> -		if (vm =3D=3D gpu->vm)
> +		if (!valid_per_process_vm(gpu, vm))
>  			return UERR(EINVAL, drm, "requires per-process pgtables");
>  		*value =3D vm->mm_start;
>  		return 0;
>  	case MSM_PARAM_VA_SIZE:
> -		if (vm =3D=3D gpu->vm)
> +		if (!valid_per_process_vm(gpu, vm))
>  			return UERR(EINVAL, drm, "requires per-process pgtables");
>  		*value =3D vm->mm_range;
>  		return 0;

[Severity: High]
This isn't a bug introduced by this patch, but while you are updating the
VM checks here, should the same logic be applied to adreno_set_param()?

Looking at adreno_set_param() for MSM_PARAM_EN_VM_BIND, it accesses ctx->vm
directly:

drivers/gpu/drm/msm/adreno/adreno_gpu.c:adreno_set_param() {
    ...
	case MSM_PARAM_EN_VM_BIND: {
		guard(rwsem_read)(&ctx->ctxlock);

		/* We can only support VM_BIND with per-process pgtables: */
		if (ctx->vm =3D=3D gpu->vm)
			return UERR(EINVAL, drm, "requires per-process pgtables");

		/*
		 * We can only swtich to VM_BIND mode if the VM has not yet
		 * been created:
		 */
		if (ctx->vm)
			return UERR(EBUSY, drm, "VM already created");
    ...
}

Because msm uses lazy initialization for virtual memory, isn't ctx->vm
guaranteed to be NULL here prior to creation?=20

If ctx->vm is NULL, then ctx->vm =3D=3D gpu->vm evaluates to false, which b=
ypasses
the capability check intended to prevent VM_BIND on platforms lacking
per-process pgtables.

Could this allow userspace to enable VM_BIND on older hardware and subseque=
ntly
crash the kernel when it binds to an uninitialized scheduler on the global =
VM?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729155609.2019=
0-1-robin.clark@oss.qualcomm.com?part=3D8
