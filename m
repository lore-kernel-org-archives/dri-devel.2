Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4E3C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 03:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6153510E1BE;
	Tue, 14 Jul 2026 03:26:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="neYvm50t";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADD2D10E1BE
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 03:26:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5658A41759;
 Tue, 14 Jul 2026 03:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E7F1F000E9;
 Tue, 14 Jul 2026 03:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783999593;
 bh=bf9Q/RkY0MrwgNuxSUcTcpkiFThtGp4UEWDHcFB0Ml4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=neYvm50tK71EWTqvgEZVWmXJT6dDTr+xDbmlu71Z48Nlzhszp97DN7mm5mjblnGqX
 d66Av92RCjsG7wv6BI10OumBYD0dL8LjdOGpX7tUgI+sszk6wkpHL6DjS1z8RK6zuw
 0OSsG1X7nFochucCksOfnK/rgxzfaQumSDy8wtdw++UVHOw+y2P1/ZSyY2GPJwX+xI
 kDc0MgcIcmsJ2Xh1sNatv5+rM1kCUrSpUWRjwn7013YqMBUMPcemLunhgjSi9Ig4/9
 UkLX7+nRseZ4douHu00knIBj3eSBuyz63jhXlEsN3ZVM31AePPV2AbY6DmAq3e7K0O
 4DckEvDZaY+lg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/7] drm/tyr: add a kernel buffer object
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260713-fw-boot-b4-v7-5-afd8dc1494dd@collabora.com>
References: <20260713-fw-boot-b4-v7-0-afd8dc1494dd@collabora.com>
 <20260713-fw-boot-b4-v7-5-afd8dc1494dd@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 03:26:32 +0000
Message-Id: <20260714032633.02E7F1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Unhandled `unmap_range` error during `KernelBo` drop leads to =
dangling page table entries and use-after-free.
- [High] Silent truncation of `size` to `usize` on 32-bit architectures lea=
ds to mismatched buffer allocation and VM mapping.
- [Medium] The virtual address range calculation `va + size` can overflow `=
u64`, causing a kernel panic or invalid state.
--

--- Patch [5]: [PATCH v7 5/7] drm/tyr: add a kernel buffer object ---
commit 63ba028b17f1b868f89f67c9bd905f6f1b2dc8cd
Author: Deborah Brouwer <deborah.brouwer@collabora.com>

drm/tyr: add a kernel buffer object

Introduce a buffer object type (KernelBo) for internal driver allocations
that are managed by the kernel rather than userspace.

KernelBo wraps a GEM shmem object and automatically handles GPU virtual
address space mapping during creation and unmapping on drop. This provides
a safe and convenient way for the driver to both allocate and clean up
internal buffers for kernel-managed resources.

> diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
> index c28be61a01bb2..47a05a33388e3 100644
> --- a/drivers/gpu/drm/tyr/gem.rs
> +++ b/drivers/gpu/drm/tyr/gem.rs

[ ... ]

> @@ -56,3 +67,85 @@ pub(crate) fn new_dummy_object(ddev: &TyrDrmDevice) ->=
 Result<ARef<Bo>> {
> =20
>      Ok(bo)
>  }
> +
> +/// Specifies how to choose a GPU virtual address for a [`KernelBo`].
> +/// An automatic VA allocation strategy will be added in the future.
> +pub(crate) enum KernelBoVaAlloc {
> +    /// Explicit VA address specified by the caller.
> +    #[expect(dead_code)]
> +    Explicit(u64),
> +}
> +
> +/// A kernel-owned buffer object with automatic GPU virtual address mapp=
ing.
> +///
> +/// This structure represents a buffer object that is created and manage=
d entirely
> +/// by the kernel driver, as opposed to userspace-created GEM objects. I=
t combines
> +/// a GEM object with automatic GPU virtual address (VA) space mapping a=
nd cleanup.
> +///
> +/// When dropped, the buffer is automatically unmapped from the GPU VA s=
pace.
> +pub(crate) struct KernelBo<'bound> {

[ ... ]

> +impl<'bound> KernelBo<'bound> {
> +    /// Creates a new kernel-owned buffer object and maps it into GPU VA=
 space.
> +    ///
> +    /// This function allocates a new shmem-backed GEM object and immedi=
ately maps
> +    /// it into the specified GPU virtual memory space. The mapping is a=
utomatically
> +    /// cleaned up when the [`KernelBo`] is dropped.
> +    #[expect(dead_code)]
> +    pub(crate) fn new(
> +        ddev: &TyrDrmDevice,
> +        vm: Arc<Vm<'bound>>,
> +        size: u64,
> +        va_alloc: KernelBoVaAlloc,
> +        flags: VmMapFlags,
> +    ) -> Result<Self> {
> +        if size =3D=3D 0 {
> +            pr_err!("Cannot create KernelBo with size 0\n");
> +            return Err(EINVAL);
> +        }
> +
> +        let KernelBoVaAlloc::Explicit(va) =3D va_alloc;
> +
> +        let bo =3D Bo::new(
> +            ddev,
> +            size as usize,

[Severity: High]
Does this silently truncate the allocation size on 32-bit architectures?

If a size larger than 4GB is passed, it appears Bo::new() will allocate the
truncated size, but vm.map_bo_range() will be called with the full u64 size
below.

Could this lead to out-of-bounds GPU virtual memory mappings if the mapping=
 size
isn't strictly validated against the actual allocation?

> +            shmem::ObjectConfig {
> +                map_wc: true,
> +                parent_resv_obj: None,
> +            },
> +            BoCreateArgs { flags: 0 },
> +        )?;
> +
> +        vm.map_bo_range(&bo, 0, size, va, flags)?;
> +
> +        Ok(KernelBo {
> +            bo,
> +            vm,
> +            va_range: va..(va + size),

[Severity: Medium]
Could this addition overflow u64?

If va + size exceeds u64::MAX, it will either panic or wrap around.
If it wraps, va_range.end will be smaller than va_range.start, which
could later cause an underflow panic during drop when calculating
self.va_range.end - self.va_range.start.

> +        })
> +    }
> +}
> +
> +impl Drop for KernelBo<'_> {
> +    fn drop(&mut self) {
> +        let va =3D self.va_range.start;
> +        let size =3D self.va_range.end - self.va_range.start;
> +
> +        if let Err(e) =3D self.vm.unmap_range(va, size) {

[Severity: Critical]
Is it safe to continue dropping the buffer object if unmap_range() fails?

If unmap_range() fails (e.g., due to OOM when splitting page tables or a
hardware timeout), the error is only logged. The underlying self.bo will
still be dropped, potentially freeing its physical pages back to the system.

Since the unmap failed, the GPU's page tables might still contain valid ent=
ries
pointing to those freed pages. Could this allow the GPU to access memory
reallocated to other kernel subsystems or userspace, causing a use-after-fr=
ee?

> +            pr_err!(
> +                "Failed to unmap KernelBo range {:#x}..{:#x}: {:?}\n",
> +                self.va_range.start,
> +                self.va_range.end,
> +                e
> +            );
> +        }
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-fw-boot-b4=
-v7-0-afd8dc1494dd@collabora.com?part=3D5
