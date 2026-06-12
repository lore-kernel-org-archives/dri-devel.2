Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8927CD4F2C
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 09:33:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BC1410F3C1;
	Fri, 12 Jun 2026 09:33:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D7rJrvHQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A82310F3BF
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 09:33:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3346A43702;
 Fri, 12 Jun 2026 09:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1531F000E9;
 Fri, 12 Jun 2026 09:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781256820;
 bh=/6wlpkTUbP462yCKECOi/tyoRwJkE3NiAWC0la5EDoM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=D7rJrvHQ3jZ/Dci9yKrcv7kKtrgVtJKozMKZSsvn4XJ20od0fwvSKXGhqvxfjFAzC
 mh8v6vNBk7RsgQBCJL3dhjC2mBH/efwU9O75BbiJoc9EZkbEUKpJ7lOzKYcrP5N7f+
 YGCWYEggWZxwhu7h/GP5bdkK3WhxJD7ZUr23viE1a82pJiE5FXOl957gp9N0Pfzt3K
 0W9y2MBxry19tdk8cbnbKyd1FCTjiCQBFxhSw7Ng5AF11ygnWYvTSDryx3klXzT/ZX
 ohBcAUr5hk9cAqfWOaj9xmhXYDgfLs04dLLvn9fkBSue3m4JJ70x3QHcdJCnRZkWSa
 qvsbc4kACH6yA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 12/18] drm/amdgpu: integrate SVM into build system
 and VM fault path
To: "Huang Rui" <ray.huang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260612090928.29682-13-ray.huang@amd.com>
References: <20260612090928.29682-13-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 09:33:39 +0000
Message-Id: <20260612093339.EF1531F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:

New issues:
- [High] Unprotected lazy initialization of SVM in `amdgpu_gem_svm_ioctl` a=
llows concurrent threads to leak memory and duplicate MMU notifiers.
- [High] `amdgpu_svm_handle_fault` passes a Page Frame Number (PFN) instead=
 of a byte address to `amdgpu_gmc_filter_faults_remove`, breaking fault fil=
tering.
- [High] Concurrent SVM lookup by PASID during VM teardown can lead to a us=
e-after-free of the amdgpu_svm context.
- [High] Failure path in `amdgpu_svm_cache_init` leaves a dangling pointer =
leading to a Use-After-Free on subsequent calls.
- [Medium] The commit message claims to add KBUILD_EXTRA_SYMBOLS for drm Mo=
dule.symvers, but this is missing from the Makefile.
- [Medium] Missing module unload cleanup for `amdgpu_svm_range_cache` and `=
amdgpu_svm_attr_range_cache`.
- [Low] CONFIG_DRM_AMDGPU_SVM is a boolean option that selects CONFIG_DRM_G=
PUSVM (a tristate), causing unmet direct dependencies and link errors when =
DRM is built as a module.
- [Low] The custom `clean-svm` phony target in the AMDGPU Makefile bypasses=
 standard Kbuild conventions.

Pre-existing issues:
- [High] Preexisting bug: `svm_range_restore_pages` passes a PFN instead of=
 a byte address to `amdgpu_gmc_filter_faults_remove`.
--

commit 639687153f86cdb4a60c3608d22867b66fce3a14
Author: Honglei Huang <honghuan@amd.com>

drm/amdgpu: integrate SVM into build system and VM fault path

This commit wires up the AMDGPU SVM subsystem, including adding Kconfig
options, Makefile rules, registering the ioctl, and routing GPU page
faults to the new SVM handler.

> Makefile:
> - Build amdgpu_svm.o, amdgpu_svm_attr.o, amdgpu_svm_fault.o,
>   amdgpu_svm_range.o when CONFIG_DRM_AMDGPU_SVM=3Dy
> - KBUILD_EXTRA_SYMBOLS for drm Module.symvers

[Severity: Medium]
The commit message mentions adding KBUILD_EXTRA_SYMBOLS, but this doesn't
appear in the actual Makefile changes.

Was this accidentally omitted, potentially causing unresolved symbol warnin=
gs
during out-of-tree builds?

> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amd=
gpu/Kconfig
> index 12e4a41bf1f04..68f519b3479db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -81,6 +81,16 @@ config DRM_AMDGPU_USERPTR
>  	  This option selects CONFIG_HMM and CONFIG_HMM_MIRROR if it
>  	  isn't already selected to enabled full userptr support.
> =20
> +config DRM_AMDGPU_SVM
> +	bool "Enable AMDGPU SVM support (experimental)"
> +	depends on DRM_AMDGPU
> +	depends on DEVICE_PRIVATE
> +	select DRM_GPUSVM

[Severity: Low]
Does selecting a tristate (DRM_GPUSVM) from a boolean (DRM_AMDGPU_SVM) break
dependency inheritance?

If DRM is built as a module, this will force DRM_GPUSVM to be built-in,
leading to Kconfig unmet dependency warnings and vmlinux link errors since
the core DRM symbols won't be built-in.

> +	select HMM_MIRROR
> +	select MMU_NOTIFIER
> +	help
> +	  Experimental SVM support based on DRM GPUSVM.
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index ba80542ead9d9..884cdc5c1e4af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -322,6 +322,15 @@ amdgpu-$(CONFIG_VGA_SWITCHEROO) +=3D amdgpu_atpx_han=
dler.o
>  amdgpu-$(CONFIG_ACPI) +=3D amdgpu_acpi.o
>  amdgpu-$(CONFIG_HMM_MIRROR) +=3D amdgpu_hmm.o
> =20
> +# svm support
> +amdgpu-$(CONFIG_DRM_AMDGPU_SVM) +=3D amdgpu_svm.o amdgpu_svm_attr.o \
> +	amdgpu_svm_fault.o amdgpu_svm_range.o

[Severity: Medium]
Since we are integrating the SVM subsystem here, does the module exit hook
(amdgpu_exit) properly clean up the kmem caches created in
amdgpu_svm_cache_init()?

It looks like amdgpu_svm_range_cache and amdgpu_svm_attr_range_cache might =
be
permanently leaked on module unload because amdgpu_svm_cache_fini() is never
called.

[Severity: High]
Also regarding amdgpu_svm_cache_init(), if amdgpu_svm_attr_cache_init()
fails, the error path destroys amdgpu_svm_range_cache but doesn't set its
pointer to NULL:

free_out:
	amdgpu_svm_attr_cache_fini();
	AMDGPU_SVM_KMEM_CACHE_DESTROY(amdgpu_svm_range_cache);
	// missing: amdgpu_svm_range_cache =3D NULL;

Could this leave a dangling pointer that causes a use-after-free or panic
on subsequent initialization attempts, since the check
if (amdgpu_svm_range_cache) would incorrectly succeed?

> +
> +.PHONY: clean-svm
> +clean-svm:
> +	rm -f $(obj)/amdgpu_svm.o $(obj)/amdgpu_svm_attr.o $(obj)/amdgpu_svm_fa=
ult.o $(obj)/amdgpu_svm_range.o \
> +	      $(obj)/.amdgpu_svm.o.cmd $(obj)/.amdgpu_svm_attr.o.cmd $(obj)/.am=
dgpu_svm_fault.o.cmd $(obj)/.amdgpu_svm_range.o.cmd

[Severity: Low]
Is this custom clean target necessary?

Kbuild should automatically manage the cleanup of *.o and .*.cmd files duri=
ng
the standard make clean phase.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 503bb64c1e55f..46a074caba53a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
[ ... ]
> @@ -3077,6 +3078,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] =3D=
 {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|=
DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioct=
l, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_PROC_OPTIONS, amdgpu_proc_options_ioctl, DRM_A=
UTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_SVM, amdgpu_gem_svm_ioctl, DRM_AUTH|DRM_RE=
NDER_ALLOW),

[Severity: High]
Is there a Time-of-Check to Time-of-Use (TOCTOU) race condition when
initializing SVM via this ioctl?

When multiple threads concurrently issue the ioctl, they both might see
vm->svm =3D=3D NULL and proceed to allocate amdgpu_svm, initialize workqueu=
es,
and register MMU interval notifiers:

	if (!amdgpu_svm_is_enabled(vm)) {
		ret =3D amdgpu_svm_init(adev, vm);

Could this lack of synchronization cause the first thread's allocation to be
overwritten and permanently leaked, leaving dangling MMU notifiers register=
ed
on the mm struct?

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 2f3470208829e..9274b0359a164 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
[ ... ]
> @@ -2763,6 +2769,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, str=
uct amdgpu_vm *vm)
>  	unsigned long flags;
>  	int i;
> =20
> +	amdgpu_svm_close(vm);
> +	amdgpu_svm_fini(vm);
> +
>  	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
> =20
>  	root =3D amdgpu_bo_ref(vm->root.bo);

[Severity: High]
Can calling amdgpu_svm_fini() here cause a use-after-free if there is a
concurrent page fault?

amdgpu_svm_fini() destroys the internal SVM components before the PASID is
removed from adev->vm_manager.pasids (which happens later in the function).

If a concurrent page fault occurs, amdgpu_svm_handle_fault() might look up
the SVM context by PASID, grab a reference, and dereference svm->attr_tree
after it has been freed here.

[ ... ]
> @@ -2995,14 +3005,23 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device =
*adev, u32 pasid,
>  		return false;
> =20
>  	is_compute_context =3D vm->is_compute_context;
> +	use_amdgpu_svm =3D !!vm->svm;
> =20
>  	if (is_compute_context) {
>  		/* Unreserve root since svm_range_restore_pages might try to reserve i=
t. */
>  		/* TODO: rework svm_range_restore_pages so that this isn't necessary. =
*/
>  		amdgpu_bo_unreserve(root);
> =20
> -		if (!svm_range_restore_pages(adev, pasid, vmid,
> -					     node_id, addr >> PAGE_SHIFT, ts, write_fault)) {
> +		if (use_amdgpu_svm)
> +			r =3D amdgpu_svm_handle_fault(adev, pasid,
> +						    addr >> PAGE_SHIFT, ts,
> +						    write_fault);

[Severity: High]
Does amdgpu_svm_handle_fault() expect a byte address rather than a Page Fra=
me
Number (PFN)?

Passing addr >> PAGE_SHIFT sends a PFN to amdgpu_svm_handle_fault(), which
in turn passes it to amdgpu_gmc_filter_faults_remove().

Since the filter expects a byte address to compute its hash key
(addr << 4 | pasid), the stale fault is never properly removed from the
filter. This could cause legitimate new faults on the same page to be ignor=
ed,
potentially hanging the GPU.

> +		else
> +			r =3D svm_range_restore_pages(adev, pasid, vmid, node_id,
> +						    addr >> PAGE_SHIFT, ts,
> +						    write_fault);

[Severity: High]
This is a pre-existing issue, but does svm_range_restore_pages() also suffer
from the same PFN vs byte address bug?

It receives addr >> PAGE_SHIFT here and passes it directly to
amdgpu_gmc_filter_faults_remove(), which would fail to remove the fault from
the GMC fault filter for the same reason.

> +
> +		if (!r) {
>  			amdgpu_bo_unref(&root);
>  			return true;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612090928.2968=
2-1-ray.huang@amd.com?part=3D12
