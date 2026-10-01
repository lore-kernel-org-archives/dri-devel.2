Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666FACA5FD6
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBD1710E3C9;
	Thu,  1 Oct 2026 16:43:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CO9j1Q1f";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D96710E049;
 Thu,  1 Oct 2026 16:43:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A954F6021D;
 Thu,  1 Oct 2026 16:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356171F000FF;
 Thu,  1 Oct 2026 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790872991;
 bh=kSr7L9lJcmk+SpmFTdDQeqWvTmo6FqArvFmFLCtcz3A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CO9j1Q1fpWNm016FL4vVpfcXZnLUY7ZPKYpldM690xiwsoEjYLNrpZLrpiguikjpS
 Yg1YKNfpsINnru++wBloqRS0KnKbVpeUmWxXQxhv93bMAKFiMq9fJhmy1RDRB0+wxs
 8MU30Wva8U4m811RmzbJXpUwACEK+Bsr/5ZNdPZZRruqdXtUbJe6d3z5HEYbQznC5w
 mpfVeKk5zZyA3ICo4ISqgEu4FwwKvi/9oCdxOzhXMrS7+rJ7gcTVeTq+uBoJUi7LG1
 c2HNyIl+uHtrPl9JelsfuWBkaoxGUUq8Hpr6u01GTGg0cXMj+cMlIBIlLOG5gpunqU
 Pb6FmBqTHuAaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] drm/msm: use DRM_GPUVM_RESV_PROTECTED for
 VM_BIND VMs
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20261001162001.3123877-5-matthew.brost@intel.com>
References: <20261001162001.3123877-1-matthew.brost@intel.com>
 <20261001162001.3123877-5-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 16:43:09 +0000
Message-Id: <20261001164311.356171F000FF@smtp.kernel.org>
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
- [High] drm/msm: lockless list corruption in msm_submit_retire() for VM_BI=
ND contexts
--

commit 27940f439eb72422df49dffc6f1f360df645fb95
Author: Matthew Brost <matthew.brost@intel.com>

    drm/msm: use DRM_GPUVM_RESV_PROTECTED for VM_BIND VMs

    msm_gem_vm_create() creates every drm_gpuvm without
    DRM_GPUVM_RESV_PROTECTED. The internal spinlocks buy nothing for
    VM_BIND VMs, so set DRM_GPUVM_RESV_PROTECTED for those VMs.

>     Kernel managed VMs are left alone. The legacy submit path holds a vm_=
bo
>     reference per BO and drops it in msm_submit_retire() with only the
>     object's resv held, which could be the last reference once the VMA is
>     gone.

Is this assumption accurate? The legacy submit path doesn't seem strictly
limited to Kernel managed VMs.

An unprivileged userspace process can opt into MSM_PARAM_EN_VM_BIND, making
the VM userspace managed, but then still create a legacy submit queue. By
issuing a legacy MSM_GEM_SUBMIT ioctl, the legacy submit path is executed
on a userspace managed VM.

> diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_=
gem_vma.c
> index 1badec3caa7b8..c7cdd32a798f7 100644
> --- a/drivers/gpu/drm/msm/msm_gem_vma.c
> +++ b/drivers/gpu/drm/msm/msm_gem_vma.c
> @@ -818,11 +818,18 @@ msm_gem_vm_create(struct drm_device *drm, struct ms=
m_mmu *mmu, const char *name,
>  		  u64 va_start, u64 va_size, bool managed)
>  {
>  	/*
> -	 * We mostly want to use DRM_GPUVM_RESV_PROTECTED, except that
> -	 * makes drm_gpuvm_bo_evict() a no-op for extobjs (ie. we loose
> -	 * tracking that an extobj is evicted) :facepalm:
> +	 * Userspace managed (VM_BIND) VMs only ever touch the gpuvm's extobj
> +	 * and evicted lists with the VM's resv held, so use
> +	 * DRM_GPUVM_RESV_PROTECTED for those.  drm_gpuvm_bo_evict() cannot
> +	 * put an extobj on the evicted list there, but it records the
> +	 * eviction and drm_gpuvm_prepare_objects() moves it onto the list
> +	 * before drm_gpuvm_validate() runs, so nothing is lost.
> +	 *
> +	 * Kernel managed VMs keep the internal spinlocks, since the legacy
> +	 * submit path can drop the last vm_bo reference with only the
> +	 * object's resv held (see msm_submit_retire()).
>  	 */
> -	enum drm_gpuvm_flags flags =3D 0;
> +	enum drm_gpuvm_flags flags =3D managed ? 0 : DRM_GPUVM_RESV_PROTECTED;

[Severity: High]
Does this cause lockless list corruption when a legacy submit interacts with
a VM_BIND context?

If an unprivileged userspace process interleaves legacy submits with VM_BIND
unmap operations on a VM_BIND context, the legacy submit ioctl will pin
objects and take a reference on the vm_bo. When the legacy submit retires,
msm_submit_retire() is called:

drivers/gpu/drm/msm/msm_gem_submit.c:msm_submit_retire() {
	...
	msm_gem_lock(obj);
	drm_gpuvm_bo_put(vm_bo);
	msm_gem_unlock(obj);
	...
}

This drops the vm_bo reference while holding only the object's resv lock.
If userspace concurrently unmapped the VMA via an asynchronous VM_BIND
operation, dropping its reference, this could be the last reference.

When the last reference is dropped, drm_gpuvm_bo_destroy() executes:

drivers/gpu/drm/drm_gpuvm.c:drm_gpuvm_bo_destroy() {
	...
	drm_gpuvm_bo_list_del(vm_bo, extobj, lock);
	drm_gpuvm_bo_list_del(vm_bo, evict, lock);
	...
}

Because DRM_GPUVM_RESV_PROTECTED is set for the VM_BIND context,
drm_gpuvm_resv_protected() evaluates to true, skipping the internal spinloc=
ks
(lock is false). Since msm_submit_retire() did not hold the VM's resv lock,
the list_del operations are performed locklessly, leading to list corruptio=
n.

>  	struct msm_gem_vm *vm;
>  	struct drm_gem_object *dummy_gem;
>  	int ret =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001162001.3123=
877-1-matthew.brost@intel.com?part=3D4
