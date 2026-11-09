Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E8C606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 01:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c45LDURj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0665A10E45E;
	Mon,  9 Nov 2026 01:01:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EB3510E45E
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 01:01:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A0C36111B;
 Mon,  9 Nov 2026 01:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47651F0089F;
 Mon,  9 Nov 2026 01:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794186100;
 bh=j8HDX61roPzKW9Jgrki3A+c5LIi9PEG3+VgTbIn9ds4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c45LDURjw3ekB/wUGcokeAtK5RMvNXkzinRocpxyi9IbEwINbRmupeviOHKsdF9X6
 5Zk2rP/L0osZSQHZzNxHBThFdqXgLGPCYKlyXonBvLtdnNDPyjLXBv26qsIxgXcOS9
 1jg3LylAysTZuFCW47wQkKE/NclgognEVkPDFXDDB68WazrshsFaxO6VV1AfuOwW7P
 eKu3D6reC8BqvL9PlvtNGhB5CawbKSDsxdkSqRev4mn32W/g6Ce3qSM/2DOETAorFN
 Lu5Uz+co92noc6F1ZjBEqe/+vQNT40vFfsPVcf//2/bPCgRny1xzOHEkA2xHeyrcMS
 hPT18UC9uRiDg==
Message-ID: <sashiko-outbox-204272@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/10] drm/tyr: add VM-related ioctls
To: "Ke Sun" <sunke@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261109-tyr-ioctls-v6-7-b2896bf2b3c9@kylinos.cn>
References: <20261109-tyr-ioctls-v6-0-b2896bf2b3c9@kylinos.cn>
 <20261109-tyr-ioctls-v6-7-b2896bf2b3c9@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 01:01:39 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/tyr: resource leak in Vm::map_bo_range() when VM is
  unusable
- [Medium] drm/tyr: partial 2 MiB block unmap in
  GpuVmData::sm_step_remap() fails
- [Low] drm/tyr: inline IdPool in VmPool::new() caps 32-bit VM IDs at 31
--

commit 30d6021aeaa9e7d9a97a8dfc27efff7e1fbee34d
Author: Alvin Sun <alvin.sun@linux.dev>

drm/tyr: add VM-related ioctls

This commit implements the PANTHOR_VM_CREATE, PANTHOR_VM_DESTROY,
PANTHOR_VM_BIND, and PANTHOR_VM_GET_STATE ioctls for the Tyr driver, wiring
them up to per-file VM pool management and synchronous VM bind operations.

> diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
> index 933a365cb016e..49b22e7ee4179 100644
> --- a/drivers/gpu/drm/tyr/file.rs
> +++ b/drivers/gpu/drm/tyr/file.rs

[ ... ]

> +fn vm_bind_exec_op(vm: &Vm<'_>, file: &TyrDrmFile, op: &VmBindOp) -> Res=
ult {

[ ... ]

> +    if (op.va | op.size | op.bo_offset) & (u64::SZ_4K - 1) !=3D 0 {
> +        dev_dbg!(vm.dev(), "VM_BIND op not GPU-page-aligned\n");
> +        return Err(EINVAL);
> +    }
> +
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

[Severity: Medium]
Can a 4 KiB-granularity partial unmap or overlapping remap here split a 2 M=
iB
block mapping and trigger WARN_ONCE in __arm_lpae_unmap()?

VmAsData::new() enables SZ_4K | SZ_2M in pgsize_bitmap, and pt_map() instal=
ls
2 MiB leaf block PTEs whenever both IOVA and physical address are 2 MiB-ali=
gned
and at least 2 MiB remains.  When userspace issues a partial unmap or
overlapping map inside that 2 MiB block, GpuVmData::sm_step_remap() calls
pt_unmap() directly on the unaligned sub-range:

drivers/gpu/drm/tyr/vm.rs:GpuVmData::sm_step_remap() {
    ...
        if unmap_length > 0 {
            let region =3D unmap_start..(unmap_start + unmap_length);
            pt_unmap(context.dev, context.pt, region.clone()).inspect_err(|=
e| {
    ...
}

For a sub-block range, pt_unmap() calls IoPageTable::unmap_pages() with
pgsize =3D SZ_4K against the 2 MiB block PTE, which hits
WARN_ONCE(true, "Unmap of a partial large IOPTE is not allowed") in
__arm_lpae_unmap() and returns 0, failing VM_BIND with EINVAL (whereas C
panthor aligns the unmap range to 2 MiB boundaries and remaps the retained
4 KiB pages of op.prev and op.next).

> diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
> index 44f5046037895..11bc8e2c9d0be 100644
> --- a/drivers/gpu/drm/tyr/vm.rs
> +++ b/drivers/gpu/drm/tyr/vm.rs

[ ... ]

> @@ -664,6 +712,17 @@ pub(crate) fn map_bo_range(
>          };
>          let result =3D {
>              let mut gpuvm_unique =3D self.gpuvm_unique.lock();
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
> +                return Err(EINVAL);
> +            }
>              self.exec_op(gpuvm_unique.as_mut().get_mut(), req, &mut reso=
urces)
>          };
>          // We flush the defer cleanup list now. Things will be different=
 in

[Severity: Medium]
Does returning early here leak the GpuVmBo, the GEM BO, and the GpuVm when a
concurrent PANTHOR_VM_DESTROY kills the VM between self.gpuvm.obtain() and
self.gpuvm_unique.lock()?

Earlier in Vm::map_bo_range(), req.op_type holds the ARef<GpuVmBo> returned=
 by
self.gpuvm.obtain(bo, ()), which takes references on both the GpuVm and the
BO:

drivers/gpu/drm/tyr/vm.rs:Vm::map_bo_range() {
    ...
        let req =3D VmOpRequest {
            op_type: VmOpType::Map(VmMapArgs {
                vm_bo: self.gpuvm.obtain(bo, ())?,
                flags,
                bo_offset,
            }),
            region: va..va_end,
        };
    ...
}

When this early return unwinds req, dropping GpuVmBo calls
drm_gpuvm_bo_put_deferred(), which only queues the GpuVmBo onto gpuvm->bo_d=
efer
while skipping self.gpuvm.deferred_cleanup() at the bottom of the function.
Because Vm::kill() has already finished its own unmap_range() before releas=
ing
gpuvm_unique and the VM has been removed from VmPool, deferred_cleanup() wi=
ll
never run again on this VM, permanently leaking the GpuVmBo, the BO's backi=
ng
pages, and the GpuVm.  Dropping req andgpuvm_unique before calling
self.gpuvm.deferred_cleanup() (or deferring self.gpuvm.obtain() until after
the check) would avoid this.

> @@ -1099,15 +1158,12 @@ pub(crate) struct VmPool<'drm> {
>  /// Error returned when a VM cannot be added to the pool. The caller
>  /// owns the teardown of the VM in [`AddError::vm`].
>  pub(crate) struct AddError<'drm> {
> -    #[expect(dead_code)]
>      pub(crate) error: Error,
> -    #[expect(dead_code)]
>      pub(crate) vm: Arc<Vm<'drm>>,
>  }
> =20
>  impl<'drm> VmPool<'drm> {
>      /// Creates a new [`VmPool`].
> -    #[expect(dead_code)]
>      pub(crate) fn new(dev: &'drm Device<Bound>) -> impl PinInit<Self> {
>          let ids =3D IdPool::new();
>          pin_init!(Self {
> @@ -1123,7 +1179,6 @@ pub(crate) fn new(dev: &'drm Device<Bound>) -> impl=
 PinInit<Self> {
>      /// returned in an [`AddError`] so the caller owns the teardown.
>      // TODO: allocate IDs with the XArray directly (once it grows range
>      // allocation, the equivalent of C's `XA_LIMIT`) and drop the IdPool.
> -    #[expect(dead_code)]
>      pub(crate) fn add(&self, vm: Arc<Vm<'drm>>) -> Result<u32, AddError<=
'drm>> {
>          let id =3D (|| {
>              let mut ids =3D self.ids.lock();

[Severity: Low]
On 32-bit architectures (ARM is enabled in Kconfig), does IdPool::new() lim=
it
each file to 31 VMs instead of MAX_VMS_PER_FILE (32)?

IdPool::new() creates an inline bitmap of usize::BITS bits (indices 0..=3D3=
1 on
32-bit), and VmPool::add() calls ids.find_unused_id(1) without growing the
pool:

drivers/gpu/drm/tyr/vm.rs:VmPool::add() {
    ...
            let mut ids =3D self.ids.lock();
            let unused =3D ids.find_unused_id(1).ok_or(ENOSPC)?;
            if unused.as_usize() > MAX_VMS_PER_FILE {
                return Err(ENOSPC);
            }
    ...
}

Because index 0 is skipped and index 32 is outside the 32-bit inline bitmap,
creating the 32nd VM on a file fails with ENOSPC.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-tyr-ioctls=
-v6-0-b2896bf2b3c9@kylinos.cn?part=3D7
