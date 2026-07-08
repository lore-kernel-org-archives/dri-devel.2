Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75531C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 17:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBF9110E0FF;
	Wed,  8 Jul 2026 17:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QNQalpYX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2127810E0FF
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 17:47:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 37E7E6001A;
 Wed,  8 Jul 2026 17:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B716A1F000E9;
 Wed,  8 Jul 2026 17:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783532833;
 bh=9zVDH+sscehQx7AG70C5Ifo+qCncoVREPgtudfP1lx4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QNQalpYXhWuiUP62HOLpUftcp2SPBgXkOl94u6FQ8ccZPCXee+lL8Rlwv7m3PJm9W
 hzAV3qYxmPN67exycKDZQSvXnHTxm1ksTptDrNtzMUFXCbpCoVmqkSw20/aIQMQeBf
 KoLgUb16ihua1Wzfm2KufC+iKDf4zSCJfx9TTOLHk5Wihn08C1xIAlDw7nLplkN8NN
 doeFNnWOEJUOOyJWuG8AzE/qvFHU/2i2a5JGZd58rgZwd3p+AQA0UBNcf12e+fh+oc
 6cthVTS03BBHNlP+aKrOifJQg64jD0PVIZ+2KBH9MwjgeC4HBd4yu8dUfBsu2F96oa
 RG4W/8b9N3LLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] drm/msm: Fix per-process-pgtables check
To: "Rob Clark" <robin.clark@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260708173356.578713-6-robin.clark@oss.qualcomm.com>
References: <20260708173356.578713-1-robin.clark@oss.qualcomm.com>
 <20260708173356.578713-6-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 17:47:13 +0000
Message-Id: <20260708174713.B716A1F000E9@smtp.kernel.org>
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
- [High] Concurrent ioctl calls to MSM_PARAM_SYSPROF can cause unbalanced p=
m_runtime and sysprof_active refcounts.
- [Medium] TOCTOU race in MSM_PARAM_EN_VM_BIND handler leading to mismatche=
d VM state.
--

--- Patch [5]: [PATCH v4 5/6] drm/msm: Fix per-process-pgtables check ---
commit 445f3f992eb83cba3cf22345c8afc2a87202a7ce
Author: Rob Clark <robin.clark@oss.qualcomm.com>
Subject: drm/msm: Fix per-process-pgtables check

This patch fixes the per-process-pgtable check in adreno_set_param() by
verifying create_private_vm instead of ctx->vm, as ctx->vm is not yet
initialized at this point.

> diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/ms=
m/adreno/adreno_gpu.c
> index c62c45bb0ddbb..bff2a773c0d4e 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
> @@ -505,7 +505,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_=
context *ctx,
>  		return msm_context_set_sysprof(ctx, gpu, value);

[Severity: High]
This isn't a bug introduced by this patch, but does calling
msm_context_set_sysprof() here without locks allow a race condition?

If two threads concurrently call MSM_PARAM_SYSPROF to transition from 2 to =
0,
couldn't they both read ctx->sysprof =3D=3D 2 in msm_context_set_sysprof() =
and both
call pm_runtime_put_autosuspend() and refcount_dec()?

This might underflow the pm_runtime refcount, causing premature hardware
suspension.

>  	case MSM_PARAM_EN_VM_BIND:
>  		/* We can only support VM_BIND with per-process pgtables: */
> -		if (ctx->vm =3D=3D gpu->vm)
> +		if (!gpu->funcs->create_private_vm)
>  			return UERR(EINVAL, drm, "requires per-process pgtables");
> =20
>  		/*
>  		 * We can only swtich to VM_BIND mode if the VM has not yet
>  		 * been created:
>  		 */
>  		if (ctx->vm)
>  			return UERR(EBUSY, drm, "VM already created");
> =20
>  		ctx->userspace_managed_vm =3D value;

[Severity: Medium]
This is a pre-existing issue, but since the check if (ctx->vm) and the
assignment ctx->userspace_managed_vm =3D value are performed locklessly in
adreno_set_param(), is it possible for a concurrent lazy VM creation to race
with this?

If thread A issues MSM_PARAM_EN_VM_BIND, checks if (ctx->vm) and evaluates =
to
false, thread B could simultaneously issue an ioctl that lazily creates the=
 VM
(e.g., DRM_IOCTL_MSM_GEM_SUBMIT).

Thread B would create the VM and set ctx->vm, and then thread A proceeds to=
 set
ctx->userspace_managed_vm =3D value. This would leave the context state
desynchronized from the actual VM state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708173356.5787=
13-1-robin.clark@oss.qualcomm.com?part=3D5
