Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308AD606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=TN+Yw/Wd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55C7710E1E1;
	Wed, 25 Nov 2026 16:14:31 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB28010E199
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 16:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795623255; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AvWEkyhmNjIPWBxVOgk8kwKJhfeojEUeIZSZrO16VQO6Dv+OfAUE57pfw8Hib5Lj5VXbnlsvtyvSvqBczekhAK3T8AAjBjutD/7gwEMb3LKMamZpcS0SPavvmkLaBRRr24M1wbcudhOLNAvOZWiI9pQacC36N4+cdHWEo6rNkSU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795623255;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=/LfAVqp4tu/EhbNroPShyI2fdXpjBbXDjj/7F6kfCyc=; 
 b=X4Mc8X2ntQpDU4LoIAywE49THhM89nezm3jtVGXQCJyvQFIoVJPrvVJiLFmdHOd56uOZ1LIWLayaa4FEbZj4lxQFvgeXp8CLHMtqTpGVziRE+M1JTVdQ6a4qcHWjQUONYW0QehYSbmtyiSorhzA4YJHG3gCmg9vraytFcvEEQwY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=TN+Yw/Wd9UaoCNPAZfw1srqtNuTItCwZlueVwBj0rPpAzSorRoAb66EOlBViLXWTPhMmmyawG/ZIwdd6BMcxuFSQXKQtnbTGnKFclPncGnxhCVjm8zgYVIHJRN6mNNXY9AXlwNNClDPmJGeFjO+AgDTzKX4xxGFDUDAhXhCWObc=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=/LfAVqp4tu/EhbNroPShyI2fdXpjBbXDjj/7F6kfCyc=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795623252604897.3662674032689;
 Wed, 25 Nov 2026 08:14:12 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v7 05/10] drm/tyr: add user and MCU VM specifications
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20261122-tyr-ioctls-v7-5-3a2af624b992@linux.dev>
Date: Wed, 25 Nov 2026 13:13:53 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Johan Hovold <johan@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 Ke Sun <sunke@kylinos.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C65C5C96-FF29-41F9-B2F5-66F62BB937F4@collabora.com>
References: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
 <20261122-tyr-ioctls-v7-5-3a2af624b992@linux.dev>
To: Alvin Sun <alvin.sun@linux.dev>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-ZohoMailClient: External
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alvin,

> On 22 Nov 2026, at 09:50, Alvin Sun <alvin.sun@linux.dev> wrote:
>=20
> The MCU and user VMs need different VA layouts. Give each a dedicated
> constructor: new_for_fw() builds the kernel-only 4G layout, while
> new_for_user() splits the address space by task_size or a =
user-provided
> size, rejecting oversized requests rather than clamping. The resulting
> user range is what VM_CREATE reports back as user_va_range.
>=20


I think we should be a bit more thorough in the commit messages, since =
reading
them is a major indicator of how the code evolved and of the reasons =
behind its
current state.

This is a mere example of what I would have written instead:

---
drm/tyr: add VA layouts for the MCU VM and user VMs

Vm::new() creates a VM that spans the whole GPU address range,
0..1 << va_bits. Its only caller creates the MCU VM.

User VMs, which VM_CREATE adds later in this series, cannot use that
range as is, because the uAPI splits a user VM in two. User space gets
the lower part, and the kernel keeps the rest for objects it maps into
the VM. The MCU VM does not need the whole range either, since firmware
sections are mapped at 32-bit addresses and panthor creates this VM
with a 4 GiB range.

Add VmLayout, which holds the full range of a VM and its user part, and
replace Vm::new() with two constructors:

- Vm::new_for_fw() covers 0..4G and has no user part.
- Vm::new_for_user() covers the whole GPU range and splits it with
  VmLayout::compute().

The split follows panthor_vm_create_check_args() and leaves the kernel
at least 256 MiB.

---


> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
> drivers/gpu/drm/tyr/fw.rs |   3 +-
> drivers/gpu/drm/tyr/vm.rs | 157 =
+++++++++++++++++++++++++++++++++++++++++-----
> 2 files changed, 143 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
> index aea151ff1f934..196ffc96d9d99 100644
> --- a/drivers/gpu/drm/tyr/fw.rs
> +++ b/drivers/gpu/drm/tyr/fw.rs
> @@ -51,7 +51,6 @@
>         KernelBoVaAlloc, //
>     },
>     gpu::GpuInfo,
> -
>     mmu::Mmu,
>     regs::{
>         gpu_control::{
> @@ -219,7 +218,7 @@ pub(crate) fn new(
>         mmu: ArcBorrow<'_, Mmu<'drm>>,
>         gpu_info: &GpuInfo,
>     ) -> Result<Firmware<'drm>> {
> -        let vm =3D Vm::new(dev, ddev, mmu, gpu_info)?;
> +        let vm =3D Vm::new_for_fw(dev, ddev, mmu, gpu_info)?;
>         vm.activate()?;
>=20
>         let result =3D (|| {
> diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
> index e67a6efcf451b..029a08051a87e 100644
> --- a/drivers/gpu/drm/tyr/vm.rs
> +++ b/drivers/gpu/drm/tyr/vm.rs
> @@ -8,6 +8,7 @@
> //! mapped into hardware address space (AS) slots for GPU execution.
>=20
> use core::marker::PhantomData;
> +use core::num::NonZeroU64;
> use core::ops::Range;
>=20
> use kernel::{
> @@ -46,6 +47,8 @@
>     num::casts::FromSafeCast,
>     prelude::*,
>     sizes::{
> +        LargeSizeConstants,
> +        SizeConstants,
>         SZ_1G,
>         SZ_2M,
>         SZ_4K, //
> @@ -161,6 +164,90 @@ fn try_from(value: u32) -> Result<Self, =
Self::Error> {
>     }
> }
>=20
> +/// User VA size request for a user VM.
> +pub(crate) enum UserVaRequest {
> +    /// Split based on `task_size()` and the GPU VA range.
> +    Auto,
> +    /// Caller-specified size; construction guarantees `> 0`.
> +    Fixed(NonZeroU64),
> +}
> +
> +impl UserVaRequest {
> +    /// UAPI boundary normalization: `0` -> [`Auto`](Self::Auto).
> +    #[expect(dead_code)]
> +    pub(crate) fn from_uapi(v: u64) -> Self {
> +        match NonZeroU64::new(v) {
> +            Some(size) =3D> Self::Fixed(size),
> +            None =3D> Self::Auto,
> +        }
> +    }
> +}
> +
> +/// Final user/kernel VA layout for a VM.
> +pub(crate) struct VmLayout {
> +    /// Full GPU VA range covered by this VM.
> +    pub(crate) full: Range<u64>,
> +    /// User-accessible VA range. Empty for MCU VMs.
> +    pub(crate) user: Range<u64>,
> +}
> +
> +impl VmLayout {
> +    /// Kernel VA range, reserved for future kernel object =
allocation.
> +    #[expect(dead_code)]
> +    pub(crate) fn kernel(&self) -> Range<u64> {
> +        self.user.end..self.full.end
> +    }
> +
> +    /// Compute a user/kernel split for a user VM from the full GPU =
VA range and
> +    /// a user request.
> +    pub(crate) fn compute(full: Range<u64>, req: UserVaRequest) -> =
Result<Self> {
> +        // Minimum VA space reserved for kernel objects (heaps, ring =
buffers, ...).
> +        const MIN_KERNEL_VA: u64 =3D u64::SZ_256M;
> +
> +        if full.end <=3D MIN_KERNEL_VA {
> +            return Err(EINVAL);
> +        }
> +
> +        let user_max =3D full.end - MIN_KERNEL_VA;
> +
> +        let user_end =3D match req {
> +            UserVaRequest::Fixed(v) =3D> {
> +                let user_size =3D v.get();
> +                if user_size > user_max {
> +                    return Err(EINVAL);
> +                }
> +                user_size
> +            }
> +            UserVaRequest::Auto =3D> {
> +                let task_size =3D current!().task_size() as u64;

Can we please remove this cast? Try FromSafeCast instead.

> +                let candidate =3D if task_size < full.end {
> +                    task_size
> +                } else {
> +                    // If the range exceeds 4G, split it in two so =
CPU and
> +                    // GPU share the same addresses (SVM).
> +                    if full.end > u64::SZ_4G {
> +                        full.end / 2
> +                    } else {
> +                        user_max
> +                    }
> +                };
> +                candidate.min(user_max)
> +            }
> +        };
> +
> +        let delta =3D full.end - user_end;
> +        // Pick a kernel VA range that's a power of two, to have a =
clear split.
> +        let kernel_va_range =3D 1u64 << delta.ilog2();
> +        let kernel_va_start =3D full.end - kernel_va_range;
> +        let full_start =3D full.start;
> +
> +        Ok(Self {
> +            full,
> +            user: full_start..kernel_va_start,
> +        })
> +    }
> +}
> +
> /// Arguments for a virtual memory map operation.
> struct VmMapArgs<'drm> {
>     /// Access permissions and caching behavior for the mapping.
> @@ -336,26 +423,64 @@ pub(crate) struct Vm<'drm> {
>     /// Non-core part of the GPUVM. Can be used for stuff that doesn't =
modify the
>     /// internal mapping tree, like GpuVm::obtain()
>     gpuvm: ARef<GpuVm<GpuVmData<'drm>>>,
> -    /// VA range for this VM.
> -    va_range: Range<u64>,
> +    /// VA layout for this VM.
> +    pub(crate) layout: VmLayout,
> }
>=20
> impl<'drm> Vm<'drm> {
> -    /// Creates a new GPU virtual address space.
> +    /// Creates the MCU/firmware VM.
>     ///
> -    /// The VM is initialized with a page table configured according =
to the GPU's
> -    /// address translation capabilities and registered with the =
GPUVM framework.
> -    pub(crate) fn new(
> +    /// The MCU VM is entirely kernel-managed: it has no =
user-accessible range.
> +    pub(crate) fn new_for_fw(
> +        dev: &'drm Device<Bound>,
> +        ddev: &TyrDrmDevice,
> +        mmu: ArcBorrow<'_, Mmu<'drm>>,
> +        gpu_info: &GpuInfo,
> +    ) -> Result<Arc<Vm<'drm>>> {
> +        // As in panthor: the CSF MCU is a Cortex-M7 and can only =
address 4G.
> +        let layout =3D VmLayout {
> +            full: 0..u64::SZ_4G,
> +            user: 0..0u64,
> +        };
> +        Self::new_internal(dev, ddev, mmu, gpu_info, layout)
> +    }
> +
> +    /// Creates a user VM, splitting the GPU VA range per `user_va`.
> +    #[expect(dead_code)]
> +    pub(crate) fn new_for_user(
>         dev: &'drm Device<Bound>,
>         ddev: &TyrDrmDevice,
>         mmu: ArcBorrow<'_, Mmu<'drm>>,
>         gpu_info: &GpuInfo,
> +        user_va: UserVaRequest,
> +    ) -> Result<Arc<Vm<'drm>>> {
> +        let mmu_features =3D =
MMU_FEATURES::from_raw(gpu_info.mmu_features);
> +        let va_bits =3D mmu_features.va_bits().get();
> +        let range =3D 0..(1u64 << va_bits);
> +
> +        let layout =3D VmLayout::compute(range.clone(), =
user_va).inspect_err(|_| {
> +            dev_dbg!(
> +                dev,
> +                "Failed to split GPU VA range {:#x}..{:#x} into user =
and kernel regions\n",
> +                range.start,
> +                range.end
> +            );
> +        })?;
> +        Self::new_internal(dev, ddev, mmu, gpu_info, layout)
> +    }
> +
> +    /// Initializes a VM with the given layout.
> +    fn new_internal(
> +        dev: &'drm Device<Bound>,
> +        ddev: &TyrDrmDevice,
> +        mmu: ArcBorrow<'_, Mmu<'drm>>,
> +        gpu_info: &GpuInfo,
> +        layout: VmLayout,
>     ) -> Result<Arc<Vm<'drm>>> {
>         let mmu_features =3D =
MMU_FEATURES::from_raw(gpu_info.mmu_features);
>         let va_bits =3D mmu_features.va_bits().get();
>         let pa_bits =3D mmu_features.pa_bits().get();
>=20
> -        let range =3D 0..(1u64 << va_bits);
>         let reserve_range =3D 0..0u64;
>=20
>         // dummy_obj is used to initialize the GPUVM tree.
> @@ -367,7 +492,7 @@ pub(crate) fn new(
>             c"Tyr::GpuVm",
>             ddev,
>             &*dummy_obj,
> -            range.clone(),
> +            layout.full.clone(),
>             reserve_range,
>             GpuVmData::<'drm> {
>                 _phantom: PhantomData::<&()>,
> @@ -387,7 +512,7 @@ pub(crate) fn new(
>                 mmu: mmu.into(),
>                 gpuvm,
>                 gpuvm_unique <- new_mutex!(gpuvm_unique),
> -                va_range: range,
> +                layout,
>             }),
>             GFP_KERNEL,
>         )?;
> @@ -418,10 +543,12 @@ fn deactivate(&self) -> Result {
>=20
>     /// Kills the VM by deactivating it and unmapping all regions.
>     pub(crate) fn kill(&self) {
> -        // TODO: Turn the VM into a state where it can't be used.
>         let _ =3D self.deactivate();
>         let _ =3D self
> -            .unmap_range(self.va_range.start, self.va_range.end - =
self.va_range.start)
> +            .unmap_range(
> +                self.layout.full.start,
> +                self.layout.full.end - self.layout.full.start,
> +            )
>             .inspect_err(|e| {
>                 dev_err!(self.dev, "Failed to unmap range during =
deactivate: {:?}", e);
>             });
> @@ -558,14 +685,14 @@ pub(crate) fn unmap_range(&self, va: u64, size: =
u64) -> Result {
>=20
>         let end =3D va.checked_add(size).ok_or(EINVAL)?;
>=20
> -        if va < self.va_range.start || end > self.va_range.end {
> +        if va < self.layout.full.start || end > self.layout.full.end =
{
>             dev_err!(
>                 self.dev,
>                 "Unmap range {:#x}..{:#x} exceeds VM range =
{:#x}..{:#x}",
>                 va,
>                 end,
> -                self.va_range.start,
> -                self.va_range.end
> +                self.layout.full.start,
> +                self.layout.full.end
>             );
>             return Err(EINVAL);
>         }
> @@ -575,7 +702,7 @@ pub(crate) fn unmap_range(&self, va: u64, size: =
u64) -> Result {
>             region: va..end,
>         };
>=20
> -        let full_vm =3D va =3D=3D self.va_range.start && end =3D=3D =
self.va_range.end;
> +        let full_vm =3D va =3D=3D self.layout.full.start && end =3D=3D =
self.layout.full.end;
>=20
>         let mut resources =3D VmOpResources {
>             preallocated_gpuvas: if full_vm {
>=20
> --=20
> 2.43.0
>=20
>=20

With the fixes above:

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

