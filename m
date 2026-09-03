Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5F7C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18E8D10E161;
	Thu,  3 Sep 2026 18:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Zfb0i+vc";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D1E10E161
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 18:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1788459025; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fa1cdIREy4hSIlYRXtNFVHHhpVk9er2or51ag2f7EvDWHBPoAHq1Pq0X6G5xkDr3IpMfMGzTMv/8XKW18aeH/kK0nWfcZlozHylMSHj2SX7tsfJLB2CHmrT+IZUxA3PuEO1oORKPypMTBJ5sJHnW5FPC+yKNW2Da17w95UwghZA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1788459025;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pvOUkOdgY7w3bkmqjiShZYzv6GBc2rD4vaEVe45u4tw=; 
 b=fWNn6CPqQEHr0ZeYjb26S2TVncd02ILGOulyhaxsJ8AbrP9Ba7Q9wQt9TfTtVOB8mUI2E2tOYr0SSUj8LlUSXpP4YVGX+Y8ZWJBgIPprSqQluy6NRGXGdCT82GuIlHn3GOOC6jS0i0LwNGXnnRAzQCnDEvu8g3F4jkwkGyTxBLE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788459025; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=pvOUkOdgY7w3bkmqjiShZYzv6GBc2rD4vaEVe45u4tw=;
 b=Zfb0i+vcr/TOvnzv8VNZ+H7jxcMDqooC+pu3DhHAraHdwjP9+DECE3OeL9XqYPkC
 pylPOuiUehUUqlFioVlrL0qNkQMc7O3olT2kFZ9SIaRwDooV6L/L0HcDt8J4zPII8LO
 PNv4vIOcoDdD/a93MA2eMHBAxnJ10qK2tTUTHJOo=
Received: by mx.zohomail.com with SMTPS id 1788459023242789.6849040267263;
 Thu, 3 Sep 2026 11:10:23 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 5/9] drm/tyr: add user and MCU VM specifications
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260902-tyr-ioctls-v1-5-e0fdbf8bd108@kylinos.cn>
Date: Thu, 3 Sep 2026 15:10:05 -0300
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 Alvin Sun <alvin.sun@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6112DB77-73A9-444F-B98B-4EEE9B69E393@collabora.com>
References: <20260902-tyr-ioctls-v1-0-e0fdbf8bd108@kylinos.cn>
 <20260902-tyr-ioctls-v1-5-e0fdbf8bd108@kylinos.cn>
To: sunke@kylinos.cn
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>



> On 1 Sep 2026, at 13:09, Ke Sun via B4 Relay =
<devnull+sunke.kylinos.cn@kernel.org> wrote:
>=20
> From: Alvin Sun <alvin.sun@linux.dev>
>=20
> Distinguish MCU VMs from user VMs, and compute the user/kernel
> GPU VA split for user VMs.

Same comment as the previous commit: please write a few
more words here if possible :)

>=20
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
> drivers/gpu/drm/tyr/fw.rs |   8 +--
> drivers/gpu/drm/tyr/vm.rs | 134 =
+++++++++++++++++++++++++++++++++++++++++++---
> 2 files changed, 131 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
> index 47d25c901bd01..9b4b488521b85 100644
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
> @@ -66,7 +65,10 @@
>             JOB_IRQ_RAWSTAT, //
>         }, //
>     },
> -    vm::Vm, //
> +    vm::{
> +        Vm,
> +        VmSpec, //
> +    }, //
> };
>=20
> mod parser;
> @@ -220,7 +222,7 @@ pub(crate) fn new(
>         mmu: ArcBorrow<'_, Mmu<'drm>>,
>         gpu_info: &GpuInfo,
>     ) -> Result<Firmware<'drm>> {
> -        let vm =3D Vm::new(dev, ddev, mmu, gpu_info)?;
> +        let vm =3D Vm::new(dev, ddev, mmu, gpu_info, VmSpec::Mcu)?;
>         vm.activate()?;
>=20
>         let result =3D (|| {
> diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
> index c5e307b1e2416..76c3d60bb2fe2 100644
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
> @@ -43,6 +44,8 @@
>     new_mutex,
>     prelude::*,
>     sizes::{
> +        LargeSizeConstants,
> +        SizeConstants,
>         SZ_1G,
>         SZ_2M,
>         SZ_4K, //
> @@ -154,6 +157,109 @@ fn try_from(value: u32) -> Result<Self, =
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
> +    pub(crate) fn from_uapi(v: u64) -> Self {
> +        match NonZeroU64::new(v) {
> +            Some(size) =3D> Self::Fixed(size),
> +            None =3D> Self::Auto,
> +        }
> +    }
> +}
> +
> +pub(crate) enum VmSpec {

Instead of having an enum, I think we could go with the current
tyr-dev design, i.e.:

- new_fw() (or, perhaps even better, new_for_fw())
- new_for_user()

> +    /// MCU/firmware VM, entirely kernel-managed.
> +    Mcu,
> +    /// User VM: full GPU VA range, split into user/kernel per =
`user_va`.
> +    User { user_va: UserVaRequest },
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
> +        /// Minimum VA space reserved for kernel objects (heaps, ring =
buffers, ...).
> +        const MIN_KERNEL_VA: u64 =3D u64::SZ_256M;
> +
> +        if full.end <=3D MIN_KERNEL_VA {
> +            pr_err!(
> +                "Invalid VA range {:#x}..{:#x}, kernel VA min =
required: >{:#x}\n",
> +                full.start,
> +                full.end,
> +                MIN_KERNEL_VA
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        let user_max =3D full.end - MIN_KERNEL_VA;
> +
> +        let user_end =3D match req {
> +            UserVaRequest::Fixed(v) =3D> {
> +                let user_size =3D v.get();
> +                if user_size > user_max {
> +                    pr_err!(
> +                        "Requested user VA range {:#x} exceeds =
maximum {:#x}\n",
> +                        user_size,
> +                        user_max
> +                    );
> +                    return Err(EINVAL);
> +                }
> +                user_size
> +            }
> +            UserVaRequest::Auto =3D> {
> +                let task_size =3D current!().mm().map(|mm| =
mm.task_size());
> +                let candidate =3D match task_size {
> +                    // `task_size()` returns usize; widen to u64 for =
the comparison.
> +                    Some(t) if (t as u64) < full.end =3D> t as u64,
> +                    None | Some(_) =3D> {
> +                        // If the range exceeds 4G, split it in two =
so CPU and
> +                        // GPU share the same addresses (SVM).
> +                        if full.end > u64::SZ_4G {
> +                            full.end / 2
> +                        } else {
> +                            user_max
> +                        }
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
> @@ -329,8 +435,8 @@ pub(crate) struct Vm<'drm> {
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
> @@ -343,6 +449,7 @@ pub(crate) fn new(
>         ddev: &TyrDrmDevice,
>         mmu: ArcBorrow<'_, Mmu<'drm>>,
>         gpu_info: &GpuInfo,
> +        spec: VmSpec,
>     ) -> Result<Arc<Vm<'drm>>> {
>         let mmu_features =3D =
MMU_FEATURES::from_raw(gpu_info.mmu_features);
>         let va_bits =3D mmu_features.va_bits().get();
> @@ -351,6 +458,14 @@ pub(crate) fn new(
>         let range =3D 0..(1u64 << va_bits);
>         let reserve_range =3D 0..0u64;
>=20
> +        let layout =3D match spec {
> +            VmSpec::Mcu =3D> VmLayout {
> +                full: range.clone(),
> +                user: 0..0u64,
> +            },
> +            VmSpec::User { user_va } =3D> =
VmLayout::compute(range.clone(), user_va)?,
> +        };
> +
>         // dummy_obj is used to initialize the GPUVM tree.
>         let dummy_obj =3D gem::new_dummy_object(ddev).inspect_err(|e| =
{
>             dev_err!(dev, "Failed to create dummy GEM object: {:?}", =
e);
> @@ -380,7 +495,7 @@ pub(crate) fn new(
>                 mmu: mmu.into(),
>                 gpuvm,
>                 gpuvm_unique <- new_mutex!(gpuvm_unique),
> -                va_range: range,
> +                layout,
>             }),
>             GFP_KERNEL,
>         )?;
> @@ -414,7 +529,10 @@ pub(crate) fn kill(&self) {
>         // TODO: Turn the VM into a state where it can't be used.
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
> @@ -551,14 +669,14 @@ pub(crate) fn unmap_range(&self, va: u64, size: =
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
> @@ -568,7 +686,7 @@ pub(crate) fn unmap_range(&self, va: u64, size: =
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

