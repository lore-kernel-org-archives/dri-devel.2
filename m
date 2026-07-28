Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99303C54F54
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E673610E9CF;
	Tue, 28 Jul 2026 18:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nMdW7g7w";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE39510E9CF
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 18:54:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7262660A5E;
 Tue, 28 Jul 2026 18:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2511F000E9;
 Tue, 28 Jul 2026 18:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785264871;
 bh=c08zbo4FraW+KoExGrbDXycjDcKHkQWJ3hRzHuvc/38=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nMdW7g7wuUZPql8I5go8wp3vu72D6nAHTxLyC672xTN+vUMujRB6rot2iWRD3+rj9
 dvanzm0Z/qAU9UnsrSuNBdH6gfSP4PikwSXF0LAhrhTKSMHbazZYL/ybUeh5yhk9aG
 DUSkxO/N4CkbZej6XsnuZUc6xpo8lgldMBN5FzooPxOoInBNaVQfMpVEG8ZJSTTfFF
 JiiYKLW8smlBpzrQ6IDzbSqL7Q1WpTzQmmycSEyPl3VENFTvHxZJfdu71LtC007MF7
 VOUoFb4OdnN/OIA/ouFjwn7ojVB9Q5xNWbqZJNFVmO1B9chwKmSGjxYbmMKT03SLif
 o1q5amgmUhiXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 4/7] drm/tyr: add GPU virtual memory (VM) support
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260728-fw-boot-b4-v10-4-9187aefa3f2f@collabora.com>
References: <20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com>
 <20260728-fw-boot-b4-v10-4-9187aefa3f2f@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 18:54:30 +0000
Message-Id: <20260728185430.EF2511F000E9@smtp.kernel.org>
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
- [High] `map_bo_range` lacks a bounds check against the VM's virtual addre=
ss range, allowing out-of-bounds MMU update commands to be sent to the hard=
ware.
- [High] Partial unmap of 2MB page table blocks causes the ARM LPAE io-pgta=
ble backend to reject the operation, breaking drm_gpuvm unmap and remap.
--

--- Patch [4]: [PATCH v10 4/7] drm/tyr: add GPU virtual memory (VM) support=
 ---
commit 7f9a396490c23472f40e677be97d921859c50864
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/tyr: add GPU virtual memory (VM) support

Add GPU virtual address space management using the DRM GPUVM framework.
Each virtual memory (VM) space is backed by ARM64 LPAE Stage 1 page tables
and can be mapped into hardware address space (AS) slots for GPU execution.

The implementation provides memory isolation and virtual address
allocation. VMs support mapping GEM buffer objects with configurable
protection flags (readonly, noexec, uncached) and handle both 4KB and 2MB
page sizes. A new_dummy_object() helper is provided to create a dummy GEM
object for use as a GPUVM root.

> diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/vm.rs
[ ... ]
> +    pub(crate) fn map_bo_range(
> +        &self,
> +        bo: &Bo,
> +        bo_offset: u64,
> +        map_size: u64,
> +        va: u64,
> +        flags: VmMapFlags,
> +    ) -> Result {
[ ... ]
> +        let bo_end =3D bo_offset.checked_add(map_size).ok_or(EINVAL)?;
> +
> +        if bo_end > bo_size {
> +            dev_err!(
> +                self.dev,
> +                "BO mapping range {:#x}..{:#x} exceeds BO size {:#x}",
> +                bo_offset,
> +                bo_end,
> +                bo_size
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        let va_end: u64 =3D va.checked_add(map_size).ok_or(EINVAL)?;
> +
> +        let req =3D VmOpRequest {

[Severity: High]
Does this code need to check if the calculated va_end exceeds the VM's
virtual address range?

If a user-space caller provides a very large map_size, va + map_size could
exceed the VM's valid range. Because there's no bounds check against
self.va_range.end here (unlike in unmap_range()), the out-of-bounds region
will be passed to PtUpdateContext::new(). This might issue a hardware lock
command to the MMU before drm_gpuvm rejects the mapping. Could this lead to
unhandled hardware faults or device hangs?

> +            op_type: VmOpType::Map(VmMapArgs {
> +                vm_bo: self.gpuvm.obtain(bo, ())?,
> +                flags,
> +                bo_offset,
> +            }),
> +            region: va..va_end,
> +        };
[ ... ]
> +    fn sm_step_remap<'op>(
> +        &mut self,
> +        op: OpRemap<'op, Self>,
> +        context: &mut Self::SmContext<'_>,
> +    ) -> Result<OpRemapped<'op, Self>, Error> {
[ ... ]
> +        let unmap_length =3D unmap_end - unmap_start;
> +
> +        if unmap_length > 0 {
> +            let region =3D unmap_start..(unmap_start + unmap_length);
> +            pt_unmap(context.dev, context.pt, region.clone()).inspect_er=
r(|e| {

[Severity: High]
Will this fail if the region is a partial unmap of a 2MB page table block?

If a buffer object is naturally aligned to 2MB, pt_map() may opportunistica=
lly
use 2MB block descriptors. If a caller later attempts to unmap a 4KB
sub-region, sm_step_remap() will pass this 4KB region to pt_unmap().=20

The ARM LPAE io-pgtable backend (arm_lpae_unmap_pages) does not automatical=
ly
split huge pages, so it might encounter the 2MB leaf descriptor, reject the
operation, and return 0, causing pt_unmap() to return EINVAL.

Could this leave the DRM GPUVM tree out of sync with the hardware page
tables and leak the mapping in the GPU?

> +                dev_err!(
> +                    context.dev,
> +                    "Failed to unmap remap region {:#x}..{:#x}: {:?}",
> +                    region.start,
> +                    region.end,
> +                    e
> +                );
> +            })?;
> +        }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-fw-boot-b4=
-v10-0-9187aefa3f2f@collabora.com?part=3D4
