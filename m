Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5E8606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T8td8njt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99B8010E5B0;
	Sun, 22 Nov 2026 13:19:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18E8510E5B0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 13:19:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E460C4169E;
 Sun, 22 Nov 2026 13:19:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4B41F000D1;
 Sun, 22 Nov 2026 13:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795353566;
 bh=nnVc73reHRmV7yD7Nwqa9YvwZglzdfM6M4Bh+wsvvIg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T8td8njtdRaF9mrhT+XdJnxENwuyW2kLmgbksZl1AGZz27z+/eSMQLfg6Arurldub
 qGm6YBKtE1vpIFjsInr91Mm1DJeoEjj669Qi3daWN0QqvbQd38lyA8GgpRb8wvXQmV
 9LzcgZzvYEBCgBqaKoePxeEmznMqSrNX8aXWMRUy5AtTlgkHVbHJImGVrNEjHT5GoU
 2YV3p7+/rfHJ4aPKZnwyi/i8A11rgal6pOhmSP4Z2gyOB9DDb43tgyRDpN+8YJKiWb
 wzs0GKUuxeX9qZqFhVYvD0SMx8KdAzKq0jaMzlzK//aIIjrEaxaxgzppgYyLYZdJQC
 g/taqi8WsxpsA==
Message-ID: <sashiko-outbox-227959@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/10] drm/tyr: add VM-related ioctls
To: "Alvin Sun" <alvin.sun@linux.dev>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261122-tyr-ioctls-v7-7-3a2af624b992@linux.dev>
References: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
 <20261122-tyr-ioctls-v7-7-3a2af624b992@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 13:19:26 +0000
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

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/tyr: partial 2 MiB block PTE unmap at 4 KiB in
  sm_step_remap()
- [Medium] drm/tyr: unbounded KVec kmalloc growth before vm_id check in
  vm_bind()
- [Medium] drm/tyr: failed VM operations in exec_op() do not mark the VM
  unusable
- [Medium] drm/tyr: unclamped va_bits in new_for_user() exceeds 32-bit
  usize limit
--

commit 6e66301fc3b3ee2268d9c61dcd5d0c01cc14673d
Author: Alvin Sun <alvin.sun@linux.dev>

drm/tyr: add VM-related ioctls

This commit implements the PANTHOR_VM_CREATE, PANTHOR_VM_DESTROY,
PANTHOR_VM_BIND, and PANTHOR_VM_GET_STATE ioctls for the Tyr DRM driver.

> diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
> index 933a365cb016e..901c0fb951adf 100644
> --- a/drivers/gpu/drm/tyr/file.rs
> +++ b/drivers/gpu/drm/tyr/file.rs
[ ... ]
> @@ -65,4 +86,260 @@ pub(crate) fn dev_query(
[ ... ]
> +    pub(crate) fn vm_bind(
> +        ddev: &TyrDrmDevice<Registered>,
> +        _reg_data: &TyrDrmRegistrationData<'_>,
> +        vmbind: &mut uapi::drm_panthor_vm_bind,
> +        file: &TyrDrmFile,
> +    ) -> Result<u32> {
[ ... ]
> +        let total_len =3D size_of::<VmBindOp>().checked_mul(count).ok_or=
_else(|| {
> +            dev_dbg!(ddev.as_ref(), "VM_BIND ops length overflow\n");
> +            EINVAL
> +        })?;
> +        let mut reader =3D
> +            UserSlice::new(UserPtr::from_addr(vmbind.ops.array as usize)=
, total_len).reader();
> +        let mut ops =3D KVec::new();
> +        for _ in 0..count {
> +            ops.push(reader.read::<VmBindOp>()?, GFP_KERNEL)?;
> +        }
> +
> +        let ret: Result<u32, Error> =3D file.inner_with(|pfile| {
> +            let vm =3D pfile.vm_pool.get(vmbind.vm_id).ok_or_else(|| {
> +                dev_dbg!(ddev.as_ref(), "Invalid VM_BIND vm_id: {}\n", v=
mbind.vm_id);
> +                EINVAL
> +            })?;

[Severity: Medium]
Can pushing a user-controlled count into an unreserved KVec trigger a warni=
ng
in ___kmalloc_large_node() before vmbind.vm_id is validated?

Because VmBindOp is 48 bytes and KVec::push() doubles its kmalloc-backed
capacity on growth, any render-node call with vmbind.ops.count >=3D 65537
attempts a 6 MiB physically contiguous allocation exceeding KMALLOC_MAX_SIZE
without __GFP_NOWARN, hitting WARN_ON_ONCE_GFP(size > KMALLOC_MAX_SIZE, fla=
gs)
instead of falling back to vmalloc.  Validating vmbind.vm_id first and
pre-allocating with KVVec::with_capacity() would avoid unauthenticated work
and fall back to vmalloc for large batches.

[ ... ]

> +fn vm_bind_exec_op(vm: &Vm<'_>, file: &TyrDrmFile, op: &VmBindOp) -> Res=
ult {
[ ... ]
> +    match VmBindOpType::try_from(op.flags) {
> +        Ok(VmBindOpType::Map) =3D> {
[ ... ]
> +            vm.map_bo_range(&bo, op.bo_offset, op.size, op.va, map_flags)
> +        }
> +        Ok(VmBindOpType::Unmap) =3D> {
> +            // Unmap must not carry map-specific flags or BO references.
> +            if op.flags & !VmBindOpType::MASK !=3D 0 || op.bo_handle !=
=3D 0 || op.bo_offset !=3D 0 {
> +                dev_dbg!(
> +                    vm.dev(),
> +                    "VM_BIND UNMAP carries flags/BO refs: flags=3D{:#x} =
bo_handle=3D{} bo_offset=3D{}\n",
> +                    op.flags,
> +                    op.bo_handle,
> +                    op.bo_offset
> +                );
> +                return Err(EINVAL);
> +            }
> +            vm.unmap_range(op.va, op.size)
> +        }

[Severity: High]
What happens when vm_bind_exec_op() partially unmaps or overwrites an
existing 2 MiB block mapping at 4 KiB granularity?

pt_map() creates SZ_2M block mappings when the IOVA, physical address, and
remaining size are 2 MiB-aligned, but GpuVmData::sm_step_remap() passes only
the unmapped sub-range to pt_unmap():

drivers/gpu/drm/tyr/vm.rs:GpuVmData::sm_step_remap() {
    ...
        if unmap_length > 0 {
            let region =3D unmap_start..(unmap_start + unmap_length);
            pt_unmap(context.dev, context.pt, region.clone()).inspect_err(|=
e| {
    ...
}

When that sub-range is not 2 MiB-aligned, get_pgsize() selects SZ_4K and
__arm_lpae_unmap() triggers WARN_ONCE(true, "Unmap of a partial large IOPTE
is not allowed") and returns 0, aborting sm_step_remap() with EINVAL before
op.remap() updates the GpuVm tree and leaving the hardware page tables out =
of
sync with GpuVm if earlier pages were already unmapped.  Like C panthor's
unmap_hugepage_align(), sm_step_remap() needs to widen the unmap range to
2 MiB block boundaries and remap the surviving 4 KiB portions of prev and
next.

> diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
> index 029a08051a87e..45e42e210de29 100644
> --- a/drivers/gpu/drm/tyr/vm.rs
> +++ b/drivers/gpu/drm/tyr/vm.rs
[ ... ]
> @@ -446,7 +484,6 @@ pub(crate) fn new_for_fw(
>      }
> =20
>      /// Creates a user VM, splitting the GPU VA range per `user_va`.
> -    #[expect(dead_code)]
>      pub(crate) fn new_for_user(
>          dev: &'drm Device<Bound>,
>          ddev: &TyrDrmDevice,

[Severity: Medium]
On 32-bit ARM builds, does Vm::new_for_user() compute a 64-bit VA layout th=
at
cannot be mapped by pt_map() and pt_unmap()?

drivers/gpu/drm/tyr/vm.rs:Vm::new_for_user() {
        let mmu_features =3D MMU_FEATURES::from_raw(gpu_info.mmu_features);
        let va_bits =3D mmu_features.va_bits().get();
        let range =3D 0..(1u64 << va_bits);
    ...
}

Because va_bits from MMU_FEATURES (e.g. 48) is not clamped to usize::BITS as
in C panthor_mmu_init(), VmLayout::compute() splits 1u64 << va_bits against=
 a
32-bit task_size, placing the kernel VA region and user_va_range above
u32::MAX where pt_map() and pt_unmap() fail with EOVERFLOW when converting =
the
64-bit IOVA to a 32-bit usize.

[ ... ]

> @@ -656,16 +712,24 @@ pub(crate) fn map_bo_range(
> -        let mut resources =3D VmOpResources {
> -            preallocated_gpuvas: [
> -                Some(GpuVaAlloc::<GpuVmData<'drm>>::new(GFP_KERNEL)?),
> -                Some(GpuVaAlloc::<GpuVmData<'drm>>::new(GFP_KERNEL)?),
> -                Some(GpuVaAlloc::<GpuVmData<'drm>>::new(GFP_KERNEL)?),
> -            ],
> -        };
>          let result =3D {
>              let mut gpuvm_unique =3D self.gpuvm_unique.lock();
> -            self.exec_op(gpuvm_unique.as_mut().get_mut(), req, &mut reso=
urces)
> +            // Check under the GPUVM lock, which the kill path also take=
s to
> +            // unmap, so this serializes against a concurrent teardown.
> +            if self.is_unusable() {
> +                dev_err!(
> +                    self.dev,
> +                    "Failed to map VA {:#x}..{:#x}: VM is unusable\n",
> +                    req.region.start,
> +                    req.region.end
> +                );
> +                // Drop the vm_bo reference before the deferred cleanup
> +                // below runs; otherwise the vm_bo would leak.
> +                drop(req);
> +                Err(EINVAL)
> +            } else {
> +                self.exec_op(gpuvm_unique.as_mut().get_mut(), req, &mut =
resources)
> +            }
>          };

[Severity: Medium]
Should Vm::exec_op() call self.mark_unusable() when an operation fails?

Currently mark_unusable() is only called from Vm::kill() after the VM is
removed from VmPool.  If exec_op() fails partway through map_bo_range() or
unmap_range() (for example, if pt_map() hits ENOMEM after sm_map() has alre=
ady
unmapped or split overlapping mappings), the VM is left partially modified =
in
the pool while vm_get_state() still reports DRM_PANTHOR_VM_STATE_USABLE and
subsequent map operations are not rejected.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-tyr-ioctls=
-v7-0-3a2af624b992@linux.dev?part=3D7
