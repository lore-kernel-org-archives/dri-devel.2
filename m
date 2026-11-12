Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A0F606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NrTyGKp3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3491E1123FB;
	Thu, 12 Nov 2026 23:38:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 526CA1123FB
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:38:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 84E14605F9;
 Thu, 12 Nov 2026 23:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 203AF1F000C4;
 Thu, 12 Nov 2026 23:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794526728;
 bh=ylszA9npUtMu3F/08wPxGJEajwtNR5qtlHwBWRd6q0A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NrTyGKp3MFgfXO4QCOq5yqCezDcvfjG+8N5JlI04grj3A/cClVRMWAentMwfwynG4
 4KyyTOAcAfqSi/5iSZxOyDW+9xEImni4i7r4FIGUIMyHAIVbGRX/ZEqfFSdS61D7Ox
 VBZU2pkg/5F6M1bmLN/UULsTf2ln4+o8DhmlhINWeTpuIfIfZ5dZp1Hlbrud0gsB6E
 2eGVAlZqYCeFpr/BYDiDPtZj1EUnZV+QBc2fQG3AEH5x5GMwta9QReUyNK69KH1UXo
 eTo4Py2r+8ufaEhrnvl9WIQygqnhkTV+N6P2eUZG6JZIl89bypnEY8nuiaJUV3Qz2x
 8HZ8UXCSlVnkQ==
Message-ID: <sashiko-outbox-211959@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 11/13] drm/powervr_sgx: Validate shader code in the
 kernel
To: "Joseph Telaak" <joseph@telaak.dev>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261112-powervr-sgx-v1-11-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
 <20261112-powervr-sgx-v1-11-c69b84bac011@telaak.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 23:38:47 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [High] drm/powervr_sgx: partial code BO mappings bypass branch and
  phase checks
- [High] drm/powervr_sgx: torn GPU instruction fetch in
  pvrsgx_ioctl_upload_code() at offset >=3D code_end
- [High] drm/powervr_sgx: missing cache maintenance in
  pvrsgx_ioctl_upload_code()
- [Medium] drm/powervr_sgx: code_place_mapped() ignores earlier invalid
  mappings
- [Medium] drm/powervr_sgx: monotonic code_end and code_abs in
  pvrsgx_ioctl_upload_code()
- [Medium] drm/powervr_sgx: code_place_mapped() ignores unmapping BOs in
  UPLOAD_CODE
- [Low] drm/powervr_sgx: spurious -EBUSY in pvrsgx_ioctl_upload_code()
  during VM_BIND error cleanup
--

commit 3c08e583541e226f931172772a47e077e959d3ed
Author: Joseph Telaak <joseph@telaak.dev>

drm/powervr_sgx: Validate shader code in the kernel

This commit adds USSE shader instruction validation, code object mapping
restrictions, and the UPLOAD_CODE ioctl for PowerVR SGX GPUs.

> diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_validate.c b/drivers/gpu/=
drm/powervr_sgx/pvrsgx_validate.c
> new file mode 100644
> index 0000000000000..cf9cfcf87fdac
> --- /dev/null
> +++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_validate.c

[ ... ]

> +/* Code objects, and only they, go into the USSE heaps, read-only. */
> +int pvrsgx_validate_vm_map(struct pvrsgx_device *sdev, struct pvrsgx_vm =
*vm,
> +			   unsigned int heap, struct pvrsgx_bo *bo, u64 offset, u64 size)
> +{
> +	return heap_is_usse(heap) =3D=3D bo_is_code(bo) ? 0 : -EINVAL;
> +}
> +
> +static_assert(PVRSGX_USSE_WINDOW_INSTS * 8 =3D=3D 1u << PVRSGX_USSE_WIND=
OW_LOG2);
> +
> +/*
> + * Where a mapping at addr of the object from offset puts the object's s=
tart,
> + * in instructions from the start of its code base window: what phas.i's
> + * targets count from when the task's PDS program names the window its f=
irst
> + * word is in. One window per object makes that base the same for every =
entry.
> + */
> +static s64 code_place(const struct pvrsgx_heap_layout *h, u64 addr, u64 =
offset)
> +{
> +	u64 base =3D addr >=3D h->usse_vertex.base ? h->usse_vertex.base : h->u=
sse_pixel.base;
> +	s64 start =3D (s64)(addr - base) - (s64)offset;
> +
> +	if (start < 0)
> +		return PVRSGX_USSE_PLACE_NONE;
> +	return (start / 8) & (PVRSGX_USSE_WINDOW_INSTS - 1);
> +}

[Severity: High]
Can a partial mapping of a code object let br or phas.i jump outside the
mapped range and the USSE heap?

pvrsgx_ioctl_upload_code() passes obj->size / 8 to pvrsgx_usse_scan(),
which checks br targets against [0, obj_insts) and phas.i targets against
[place, place + obj_insts).  However, pvrsgx_validate_vm_map() ignores
offset and size, and DRM_POWERVR_SGX_VM_BIND_OP_UNMAP can also split or
partially unmap an existing code mapping.

If userspace creates a 1 MiB + 4 KiB code BO, uploads a br at offset
1 MiB with displacement -131072 instructions (target 0), and maps only
the last 4 KiB page at h->usse_pixel.base, executing that instruction
branches to h->usse_pixel.base - 1 MiB (which lands in kernel_data on
single-context SGX530 with allow_unisolated=3D1).  For phas.i, partial
mappings likewise let targets in [0, obj_insts) jump past the mapped
subrange, and code_place() wraps modulo 512 KiB when addr and
addr - offset fall in different windows.

> +/*
> + * Once code with absolute targets is in an object, every mapping of it =
puts it
> + * where those targets were checked. Called with the object's reservatio=
n held.
> + */
> +int pvrsgx_validate_vm_link(struct pvrsgx_bo *bo, u64 addr, u64 offset)
> +{
> +	if (!bo_is_code(bo) || !bo->code_abs)
> +		return 0;
> +	const struct pvrsgx_heap_layout *h =3D pvrsgx_heaps(to_pvrsgx_device(bo=
->base.base.dev));
> +
> +	return code_place(h, addr, offset) =3D=3D bo->code_place ? 0 : -EINVAL;
> +}
> +
> +/* The one place every mapping of obj puts it, or PVRSGX_USSE_PLACE_NONE=
. */
> +static s64 code_place_mapped(struct drm_gem_object *obj)
> +{
> +	const struct pvrsgx_heap_layout *h =3D pvrsgx_heaps(to_pvrsgx_device(ob=
j->dev));
> +	struct drm_gpuvm_bo *vm_bo;
> +	struct drm_gpuva *va;
> +	s64 place =3D PVRSGX_USSE_PLACE_NONE;
> +
> +	drm_gem_for_each_gpuvm_bo(vm_bo, obj) {
> +		drm_gpuvm_bo_for_each_va(va, vm_bo) {
> +			s64 p =3D code_place(h, va->va.addr, va->gem.offset);
> +
> +			if (place !=3D PVRSGX_USSE_PLACE_NONE && p !=3D place)
> +				return PVRSGX_USSE_PLACE_NONE;
> +			place =3D p;
> +		}
> +	}
> +	return place;
> +}

[Severity: Medium]
Does code_place_mapped() ignore an invalid mapping when it comes before a
valid one in obj->gpuva.list?

PVRSGX_USSE_PLACE_NONE is used both as the initial value of place and as
the failure return of code_place() when va->gem.offset > va->va.addr -
base.  If the first mapping visited returns PVRSGX_USSE_PLACE_NONE, place
stays PVRSGX_USSE_PLACE_NONE, and the next iteration overwrites it with
the second mapping's p, allowing pvrsgx_ioctl_upload_code() to accept
phas.i instructions on an object mapped at conflicting locations.

[ ... ]

> +	/* VM_BIND links a mapping under the same lock. */
> +	err =3D dma_resv_lock_interruptible(obj->resv, NULL);
> +	if (err)
> +		goto out_buf;
> +	/* An unmapped mapping counts until its jobs and the BIF invalidate are=
 done. */
> +	if ((!list_empty(&obj->gpuva.list) || atomic_read(&bo->code_unmapping))=
 &&
> +	    args->offset < bo->code_end) {
> +		err =3D -EBUSY;
> +		goto out_unlock;
> +	}

[Severity: Low]
Can pvrsgx_ioctl_upload_code() spuriously return -EBUSY when racing with
a failed VM_BIND?

In pvrsgx_vm.c, bind_prepare() calls drm_gpuvm_bo_obtain_locked(), which
adds an empty vm_bo to obj->gpuva.list under obj->resv.  If bind_prepare()
later fails, pvrsgx_ioctl_vm_bind() drops obj->resv via drm_exec_fini()
before re-locking it at out: to call drm_gpuvm_bo_put():

CPU0                                   CPU1
pvrsgx_ioctl_vm_bind()
  bind_prepare()
    drm_gpuvm_bo_obtain_locked()
      /* adds empty vm_bo */
  drm_exec_fini(&exec)
                                       pvrsgx_ioctl_upload_code()
                                         dma_resv_lock_interruptible()
                                         !list_empty(&obj->gpuva.list)
                                           <-- returns -EBUSY
  dma_resv_lock(ops[i].obj->resv)
  drm_gpuvm_bo_put(ops[i].vm_bo)

Checking whether any vm_bo on obj->gpuva.list has a linked drm_gpuva
avoids failing on an unmapped BO.

> +	place =3D code_place_mapped(obj);

[Severity: Medium]
Can pvrsgx_ioctl_upload_code() validate phas.i targets against a single
mapping while an earlier unlinked mapping is still in flight on the GPU?

When a mapping is unmapped, va_unlink_locked() increments
bo->code_unmapping and removes the va from obj->gpuva.list before
in-flight jobs and the BIF TLB invalidation finish:

CPU0                                   CPU1
pvrsgx_ioctl_vm_bind()
  /* BO mapped at P1 and P2;
     job using P1 is running */
  bind_step_unmap(P1)
    va_unlink_locked()
      atomic_inc(&bo->code_unmapping)
      drm_gpuva_unlink(va)
                                       pvrsgx_ioctl_upload_code()
                                         /* args->offset >=3D bo->code_end =
*/
                                         place =3D code_place_mapped(obj)
                                           /* sees only P2, returns P2 */
                                         pvrsgx_usse_scan(..., P2, ...)
                                           <-- accepts phas.i for P2 while
                                               job still fetches from P1

Because atomic_read(&bo->code_unmapping) is only checked when
args->offset < bo->code_end and code_place_mapped() only walks
obj->gpuva.list, uploading phas.i at args->offset >=3D bo->code_end allows
the running job at P1 to jump outside the object's bounds at P1.

> +	bad =3D pvrsgx_usse_scan(sdev->family->isa, buf, args->size / 8, args->=
offset / 8,
> +			       obj->size / 8, place, &abs, &why);
> +	if (bad >=3D 0) {
> +		args->bad_offset =3D args->offset + bad * 8;
> +		drm_dbg_driver(drm, "UPLOAD_CODE: word at 0x%llx refused: %s\n",
> +			       args->bad_offset, pvrsgx_usse_refusal_name(why));
> +		err =3D -EINVAL;
> +		goto out_unlock;
> +	}
> +	err =3D drm_gem_shmem_vmap_locked(&bo->base, &map);
> +	if (err)
> +		goto out_unlock;
> +	iosys_map_memcpy_to(&map, args->offset, buf, args->size);
> +	drm_gem_shmem_vunmap_locked(&bo->base, &map);

[Severity: High]
Can a running GPU job fetch a torn 64-bit instruction during
iosys_map_memcpy_to() when uploading at args->offset >=3D bo->code_end?

When a code BO is mapped in a VM, bind_step_map() maps the entire range
up to obj->size into the GPU MMU, and a running task can reach offsets
at or above bo->code_end via its PDS DOUTU entry, a branch validated
against obj_insts, or fallthrough across zero words (fmad r0, r0, r0, r0).
Because uploads at args->offset >=3D bo->code_end are allowed while the BO
is mapped, iosys_map_memcpy_to() can race with GPU instruction fetches:

CPU0                                   GPU (USSE)
pvrsgx_ioctl_upload_code()
  /* args->offset >=3D bo->code_end */
  iosys_map_memcpy_to()
    /* writes upper 32 bits of
       setfc #0, #1 (0xfd100000)
       before lower 32 bits (0x100) */
                                       fetches 0xfd10000000000000
                                         <-- executes setfc #0, #0

Executing setfc #0, #0 disables C10 format control, allowing subsequent
instructions to access internal registers i64..i67 beyond USSE_I_LAST.

> +	bo->code_end =3D max(bo->code_end, end);

[Severity: High]
Does pvrsgx_ioctl_upload_code() miss CPU and GPU cache maintenance for
uploaded instructions?

First, when appending at args->offset >=3D bo->code_end to an already-mapped
code BO, the new instructions can share a GPU cache line with an earlier
shader in [0, bo->code_end) whose trailing zeroes were already cached by a
previous job, but pvrsgx_ioctl_upload_code() never sets
PVRSGX_CC_INVAL_DATA in sdev->fw.cache_control.  Second, on non-x86
platforms, uploading before VM_BIND allocates zeroed shmem pages in
drm_gem_shmem_vmap_locked() with dirty zero lines in the CPU D-cache,
writes through a write-combined vmap directly to RAM, and unpins the pages
in drm_gem_shmem_vunmap_locked(); when VM_BIND later calls
drm_gem_shmem_get_pages_sgt() -> dma_map_sgtable(), cleaning the CPU
D-cache overwrites the WC-written instructions in RAM with zeroes.

> +	if (abs) {
> +		bo->code_abs =3D true;
> +		bo->code_place =3D place;
> +	}

[Severity: Medium]
Can an unmapped, idle code BO be reused once bo->code_end and
bo->code_abs have been set?

bo->code_end only grows via max(bo->code_end, end), and bo->code_abs is
never cleared when a BO is unmapped or overwritten.  If userspace unmaps
an idle code BO to reuse it, mapping it at a new location and uploading a
shader with phas.i at offset 0 fails with -EBUSY because args->offset <
bo->code_end, and overwriting it while unmapped with code that has no
phas.i leaves bo->code_abs set so pvrsgx_validate_vm_link() rejects
mapping it anywhere other than the stale bo->code_place.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-powervr-sg=
x-v1-0-c69b84bac011@telaak.dev?part=3D11
