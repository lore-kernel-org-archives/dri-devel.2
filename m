Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B75CD8CA8
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DC3310F3C7;
	Fri, 12 Jun 2026 09:35:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rd7UUnxF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7491910F3C6
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:35:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ECFB360052;
 Fri, 12 Jun 2026 09:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5D01F00A3E;
 Fri, 12 Jun 2026 09:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781256945;
 bh=KPcmREQxOMs1KHJXU/2wyxtYkMl2TqpWxqOn8g4sHD8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rd7UUnxFEH65AyschUHBTY1vrQUg/vArxgUkqjB4yMOZzoM68jtZ397BB6jPE4aSU
 nHEHCD2qa8mem9mwVifY+/wz9n1xsS29qBKCMufBxeY+A3mwRonGzLXrmZYRfmi+zf
 SaHVOKHsZQHYRuFhj+lSuIxx7bnmtGyYEE1TkNuL7u5kExFL9bETpNgohHF77DGHV2
 jMnbuqD/g2/MBUO9kX+cvs5A/B3RCk9RgnD3C9+7so0AJZ1rWiNdSjHAfHNvVdqIxx
 tLnY8mzFGt/2sdBFUHf4/fKenBGWBh29pZrP6s1IICBSqBfqbNxdLy94ZwxhdVm0Uh
 mvTV9WS46R5zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/18] drm/amdgpu: implement SVM initialization and
 lifecycle
To: "Huang Rui" <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612090928.29682-11-ray.huang@amd.com>
References: <20260612090928.29682-11-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 09:35:45 +0000
Message-Id: <20260612093545.8F5D01F00A3E@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Kernel memory allocation for SVM ranges and attribute ranges omits=
 memcg accounting, allowing userspace to bypass memory cgroups.
- [High] Lockless publication and clearing of `vm->svm` causes a data race,=
 leading to uninitialized memory reads and Use-After-Free during PASID look=
up.
- [High] Premature destruction of `amdgpu_svm` internal resources before th=
e reference count reaches zero leads to Use-After-Free.
- [Medium] Attribute changes to the 0th page (virtual address 0) are silent=
ly ignored due to a flawed empty-range check.
- [Medium] Slab caches allocated during initialization are never destroyed,=
 causing a memory leak on module unload.
--

commit ccb807100535d706e39546251263d3b6b1ad0ff1
Author: Honglei Huang <honghuan@amd.com>

drm/amdgpu: implement SVM initialization and lifecycle
   =20
This commit implements the amdgpu_svm.c core module for AMDGPU SVM, handling
initialization, TLB flushing, slab cache management, attribute change
detection, and kref-based lifecycle management.

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_svm.c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_svm.c

[ ... ]

> +static struct drm_gpusvm_range *amdgpu_svm_range_alloc(struct drm_gpusvm=
 *gpusvm)
> +{
> +	struct amdgpu_svm_range *range;
> +
> +	range =3D kmem_cache_zalloc(amdgpu_svm_range_cache, GFP_KERNEL);

[Severity: High]
Does this allocation need memcg accounting? Since userspace controls the nu=
mber
of ranges allocated, omitting the accounting flags could allow a malicious
process to exhaust kernel memory and bypass memory cgroup limits. Should
amdgpu_svm_range_cache be created with the account flag, or should GFP_KERN=
EL
include the account bit here?

> +	if (!range)
> +		return NULL;

[ ... ]

> +struct amdgpu_svm *
> +amdgpu_svm_lookup_by_pasid(struct amdgpu_device *adev, uint32_t pasid)
> +{
> +	struct amdgpu_svm *svm =3D NULL;
> +	struct amdgpu_vm *vm;
> +	unsigned long irqflags;
> +
> +	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
> +	vm =3D xa_load(&adev->vm_manager.pasids, pasid);
> +	if (vm && vm->svm) {
> +		svm =3D vm->svm;
> +		kref_get(&svm->refcount);
> +	}

[Severity: High]
Is it safe to read vm->svm and increment its refcount locklessly here?

If amdgpu_svm_fini() concurrently clears vm->svm to NULL without
synchronization, a page fault thread might load a pointer to an object
that is actively being freed. Could this lead to a use-after-free crash
if the clear and lookup are not synchronized?

> +	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
> +
> +	return svm;
> +}

[ ... ]

> +void amdgpu_svm_cache_fini(void)
> +{
> +	if (!amdgpu_svm_range_cache)
> +		return;
> +
> +	amdgpu_svm_attr_cache_fini();
> +	AMDGPU_SVM_KMEM_CACHE_DESTROY(amdgpu_svm_range_cache);
> +}

[Severity: Medium]
Is this cleanup function wired up to the module exit paths? It appears to be
defined but never called anywhere in the teardown sequences. Will this leak
the slab caches when the module is unloaded?

[ ... ]

> +int amdgpu_svm_apply_attr_change(struct amdgpu_svm *svm,
> +				 const struct amdgpu_svm_attrs *old_attrs,
> +				 const struct amdgpu_svm_attrs *new_attrs,
> +				 unsigned long start_page,
> +				 unsigned long last_page)
> +{
> +	bool old_access, new_access;
> +	bool needs_invalidate =3D false;
> +	bool needs_mapping =3D false;
> +	uint32_t trigger;
> +	int ret;
> +
> +	amdgpu_svm_assert_locked(svm);
> +
> +	if (!start_page && !last_page)
> +		return 0;

[Severity: Medium]
Does this condition unintentionally skip valid single-page mappings at virt=
ual
address zero?

If a userspace application legitimately modifies attributes for the 0th pag=
e,
start_page and last_page would both be 0, causing this function to silently
abort without updating hardware mappings or invalidating the TLB.

> +
> +	trigger =3D attr_change_trigger(old_attrs, new_attrs);

[ ... ]

> +void amdgpu_svm_fini(struct amdgpu_vm *vm)
> +{
> +	struct amdgpu_svm *svm =3D vm->svm;
> +
> +	if (!svm)
> +		return;
> +
> +	amdgpu_svm_close(vm);
> +	amdgpu_svm_lock(svm);
> +	drm_gpusvm_fini(&svm->gpusvm);
> +	amdgpu_svm_unlock(svm);
> +
> +	amdgpu_svm_attr_tree_destroy(svm->attr_tree);
> +	amdgpu_svm_work_fini(svm);
> +	vm->svm =3D NULL;
> +	amdgpu_svm_put(svm);
> +}

[Severity: High]
Should the destruction of embedded resources happen in amdgpu_svm_release
instead of here?

The svm object is reference counted, meaning concurrent threads could hold
an active reference while this runs. Tearing down the resources here before
dropping the final reference with amdgpu_svm_put could result in a
use-after-free crash if a concurrent thread accesses these subsystems.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612090928.2968=
2-1-ray.huang@amd.com?part=3D10
