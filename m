Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE811C5DF66
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1168D10E4B9;
	Thu, 13 Aug 2026 10:40:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ivETJglc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A6B410E4B9
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:40:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1367A406DB;
 Thu, 13 Aug 2026 10:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76C71F000E9;
 Thu, 13 Aug 2026 10:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786617632;
 bh=NdZIMFacTalyfsENLV/9llsENaq9mzgWSXjnweF3Liw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ivETJglcH4jxxxvWT3nxKfFLTSdhs1tGythlCsxFvzMIXY7dCSIA7ITs9GdOsm9wW
 vuJ6vVTtOFotvni+hRPFBtiPvSK5LlUxxQdmzI/lZib8JpbPNY1Ht1T7S2PuqmNBeS
 29f9KO6AhwJAiErjTcPWxQ/vqqTlEHcYVJFhKLRkd2irfO36nzKWTgWnuk3a2mtmST
 da76K+5MZ8KRFBk8U6dNSCRJpd0eyPgiGaI/9vgB8E0qERUcjfbOdZ2Oi8Jc+zxyD+
 fQKkrnh8LyXcTTlfHCzF5Q3YzeXoIg3mkgqGgFHOQ1WPisvyB4e4IxlpHTw90AX98H
 +9RkcXfmHXPsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/nouveau: disable VM_BIND once a legacy BO VMA is
 created
To: "Zhenhao Wan" <whi4ed0g@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813-nouveau-gem-uvmm-vma-fix-v1-1-4f14d427f2c9@gmail.com>
References: <20260813-nouveau-gem-uvmm-vma-fix-v1-1-4f14d427f2c9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 10:40:31 +0000
Message-Id: <20260813104031.D76C71F000E9@smtp.kernel.org>
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
- [High] A time-of-check to time-of-use (TOCTOU) race condition in `nouveau=
_gem_object_open()` allows a VM_BIND client to bypass the `NOUVEAU_GEM_DOMA=
IN_NO_SHARE` restriction and open exclusive buffers.
- [High] Unprivileged userspace can trigger a massive memory and GPU resour=
ce leak by repeatedly calling the `NOUVEAU_VM_INIT` ioctl.
--

--- Patch [1]: [PATCH] drm/nouveau: disable VM_BIND once a legacy BO VMA is=
 created ---
commit f241cc2db54abcee53ca3ff7b4e2aadd6db117dd
Author: Zhenhao Wan <whi4ed0g@gmail.com>

drm/nouveau: disable VM_BIND once a legacy BO VMA is created

This commit fixes a use-after-free issue where a legacy per-client VMA could
be leaked if a client initializes VM_BIND after opening an object. It calls
nouveau_cli_disable_uvmm_noinit() in nouveau_gem_object_open() to disable
VM_BIND for clients creating legacy VMAs.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouv=
eau/nouveau_gem.c
> index 20dba02d6175b..e33f76b5a2398 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> @@ -108,6 +108,14 @@ nouveau_gem_object_open(struct drm_gem_object *gem, =
struct drm_file *file_priv)
>  	if (vmm->vmm.object.oclass < NVIF_CLASS_VMM_NV50)
>  		return 0;
> =20
> +	/*
> +	 * Opening the object binds it through the legacy per-VMA path below.
> +	 * Disable VM_BIND for this client, as nouveau_gem_ioctl_new() does, so
> +	 * a later NOUVEAU_VM_INIT cannot switch the client to uvmm and leave
> +	 * nouveau_gem_object_close() unable to tear this VMA down.
> +	 */
> +	nouveau_cli_disable_uvmm_noinit(cli);
> +
>  	if (nvbo->no_share && uvmm &&
>  	    drm_gpuvm_resv(&uvmm->base) !=3D nvbo->bo.base.resv)
>  		return -EPERM;

[Severity: High]
This is a pre-existing issue, but does this function have a time-of-check to
time-of-use race condition involving the cached uvmm pointer?

The uvmm pointer is cached without locks at the start of
nouveau_gem_object_open():

	struct nouveau_uvmm *uvmm =3D nouveau_cli_uvmm(cli);

If a client guesses the flink name of a no_share buffer, calls GEM_OPEN, and
concurrently calls NOUVEAU_VM_INIT:

CPU1 calls NOUVEAU_VM_INIT and sets cli->uvmm.ptr

CPU2 in nouveau_gem_object_open():
	struct nouveau_uvmm *uvmm =3D nouveau_cli_uvmm(cli); /* caches NULL */
	...
	nouveau_cli_disable_uvmm_noinit(cli); /* locks and disables */

	if (nvbo->no_share && uvmm &&
	    drm_gpuvm_resv(&uvmm->base) !=3D nvbo->bo.base.resv)
		return -EPERM;

Can NOUVEAU_VM_INIT complete after uvmm is cached as NULL but before
nouveau_cli_disable_uvmm_noinit() acquires the lock?

If so, the no_share condition would be evaluated using the stale NULL point=
er,
bypassing the restriction and allowing a client to map an exclusive buffer
belonging to another VM into its own GPU VM. Should uvmm be reloaded after
taking the lock or before the check?


[Severity: High]
This isn't a bug introduced by this patch, but can unprivileged userspace
trigger a massive memory and GPU resource leak through the VM_BIND ioctl?

Looking at nouveau_uvmm_ioctl_vm_init() in
drivers/gpu/drm/nouveau/nouveau_uvmm.c:

	uvmm =3D kzalloc_obj(*uvmm);
	if (!uvmm) {
		ret =3D -ENOMEM;
		goto out_unlock;
	}
...
	cli->uvmm.ptr =3D uvmm;

If an attacker repeatedly calls DRM_IOCTL_NOUVEAU_VM_INIT on a single DRM f=
ile
descriptor, does this ioctl handler lack a check to see if cli->uvmm.ptr is
already initialized?

It appears to unconditionally allocate a new struct nouveau_uvmm and overwr=
ite
cli->uvmm.ptr. Does this permanently leak the previously allocated structur=
es
and GPU page tables, potentially leading to a local denial of service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-nouveau-ge=
m-uvmm-vma-fix-v1-1-4f14d427f2c9@gmail.com?part=3D1
