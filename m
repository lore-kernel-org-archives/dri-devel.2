Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F49DC5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F82C10F3CA;
	Fri, 14 Aug 2026 07:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I5W5OouM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 806CA10E0E4;
 Fri, 14 Aug 2026 07:51:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 16118418C3;
 Fri, 14 Aug 2026 07:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A4A1F000E9;
 Fri, 14 Aug 2026 07:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786693868;
 bh=RVXHhmaqeb8txP/gcfFZ1wYc6gE3KO8cr1OHEKIV6D8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I5W5OouMvaBuM062o4eXLscKRnlZb9H4+aF5/wFy65F5QdzYg1cG0K/TMEkACGFjQ
 2pqCIQ+AbCtLWse6yyuS5w/veU57x+P/eu4OD+ddX/+Ym0WM6wAmYuMLO0ePurOqBd
 xW8lkh3NgZQagsYDv0HT6Yml6qehlP5OnFaLejcDy0o8kmRFKmmzbrhmL15hWam1lj
 VfkgIhJk9rulAm+JyXpKhUDMIaAMtEHPpIXOwhKvx+OT/MOuQ5H0uG3FQ6aGF8tMy0
 Jp5PEXrClgcSQWhc0DjqDBmDdfsFzx10Hp26hVTwpWliaQ8Daag73UC3x2rUF/10k0
 6V4j8BVSvjnmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/gpuvm: allow locking external objects in two
 passes
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260814073258.893007-2-matthew.brost@intel.com>
References: <20260814073258.893007-1-matthew.brost@intel.com>
 <20260814073258.893007-2-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 07:51:07 +0000
Message-Id: <20260814075107.C2A4A1F000E9@smtp.kernel.org>
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

New issues:
- [Low] Missing WRITE_ONCE() for vm_bo->evicted causes a data race with a n=
ewly introduced lockless reader.

Pre-existing issues:
- [High] The xe driver bypasses drm_gpuvm_bo_evict() when clearing vm_bo->e=
victed, which permanently leaks the newly introduced num_evicted counter.
--

--- Patch [1]: [PATCH 1/3] drm/gpuvm: allow locking external objects in two=
 passes ---
commit 8dc4616b6b0a651e19f9a8c0a513982ffa694e85
Author: Matthew Brost <matthew.brost@intel.com>

drm/gpuvm: allow locking external objects in two passes

This patch introduces an optimization to drm_gpuvm by allowing a split
in the drm_exec transaction. It locks private and evicted objects first,
then locks resident external objects later in a second pass. This reduces
the time locks are held for resident shared objects during migration.

> diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
> index d1c80ad3deadb..f6ec90640d372 100644
> --- a/drivers/gpu/drm/drm_gpuvm.c
> +++ b/drivers/gpu/drm/drm_gpuvm.c
[ ... ]
> @@ -1220,16 +1301,88 @@ drm_gpuvm_prepare_vm(struct drm_gpuvm *gpuvm,
>  }
>  EXPORT_SYMBOL_GPL(drm_gpuvm_prepare_vm);
> =20
[ ... ]
> +static bool
> +drm_gpuvm_prepare_skip(struct drm_gpuvm_bo *vm_bo,
> +		       enum drm_gpuvm_exec_pass pass)
> +{
> +	drm_gpuvm_pass_assert_held(vm_bo->vm, pass);
> +
> +	switch (pass) {
> +	case DRM_GPUVM_EXEC_PASS_EARLY:
> +		vm_bo->lock_skipped =3D !READ_ONCE(vm_bo->evicted);
> +		break;
> +	case DRM_GPUVM_EXEC_PASS_LATE:
[ ... ]
> @@ -1959,6 +2389,11 @@ EXPORT_SYMBOL_GPL(drm_gpuvm_bo_extobj_add);
>   * @evict: indicates whether the object is evicted
>   *
>   * Adds a &drm_gpuvm_bo to or removes it from the &drm_gpuvm's evicted l=
ist.
> + *
> + * An external object of a %DRM_GPUVM_RESV_PROTECTED &drm_gpuvm is the
> + * exception: the evicted list is protected by the GPUVM's common dma-re=
sv
> + * there, which this does not hold, so such an object is only accounted =
for
> + * and is put on the list later, by drm_gpuvm_prepare_objects().
>   */
>  void
>  drm_gpuvm_bo_evict(struct drm_gpuvm_bo *vm_bo, bool evict)
> @@ -1966,6 +2401,7 @@ drm_gpuvm_bo_evict(struct drm_gpuvm_bo *vm_bo, bool=
 evict)
>  	struct drm_gpuvm *gpuvm =3D vm_bo->vm;
>  	struct drm_gem_object *obj =3D vm_bo->obj;
>  	bool lock =3D !drm_gpuvm_resv_protected(gpuvm);
> +	bool was_evicted =3D vm_bo->evicted;
> =20
>  	dma_resv_assert_held(obj->resv);
>  	vm_bo->evicted =3D evict;

[Severity: Low]
Does this write need to use WRITE_ONCE()?

This plain write pairs with the lockless READ_ONCE(vm_bo->evicted) added
in drm_gpuvm_prepare_skip(). Without a WRITE_ONCE() here, KCSAN will report
a data race.

> @@ -1974,8 +2410,16 @@ drm_gpuvm_bo_evict(struct drm_gpuvm_bo *vm_bo, boo=
l evict)
>  	 * internal spinlocks, since in this case the evicted list is protected
>  	 * with the VM's common dma-resv lock.
>  	 */
> -	if (drm_gpuvm_is_extobj(gpuvm, obj) && !lock)
> +	if (drm_gpuvm_is_extobj(gpuvm, obj) && !lock) {
> +		/*
> +		 * Count them instead, so drm_gpuvm_needs_two_pass() can tell
> +		 * whether any are evicted without walking the list. The
> +		 * object's dma-resv is held, so the transition is stable.
> +		 */
> +		if (evict !=3D was_evicted)
> +			atomic_add(evict ? 1 : -1, &gpuvm->extobj.num_evicted);

[Severity: High]
This isn't a bug introduced by this patch, but the xe driver manually clears
the evicted flag (vm_bo->evicted =3D false) during validation in
drivers/gpu/drm/xe/xe_vm.c:xe_gpuvm_validate() instead of using the
drm_gpuvm_bo_evict() API.

Because drm_gpuvm_bo_evict() is bypassed for clearing the flag, this counter
decrement will never execute for the xe driver. Does this mean the
num_evicted counter will permanently leak, continuously incrementing and
permanently forcing drm_gpuvm_needs_two_pass() to return true, thereby
defeating the optimization?

>  		return;
> +	}
> =20
>  	if (evict)
>  		drm_gpuvm_bo_list_add(vm_bo, evict, lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814073258.8930=
07-1-matthew.brost@intel.com?part=3D1
