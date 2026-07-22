Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1AAC4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 01:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BFC210EBF9;
	Wed, 22 Jul 2026 01:06:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dgZcdzPe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ADC010EBFB
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 01:05:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D80E437C4;
 Wed, 22 Jul 2026 01:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FC41F000E9;
 Wed, 22 Jul 2026 01:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784682359;
 bh=SxwmhqqTqsQIVclqxJzXaaYyAGqW4ATM8fvR4R35E08=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dgZcdzPeZfb4LjgmgAJhHy9ocYb4pe3kLBXFuT2mQ5SRau5pXDDItwwJO01PWtNei
 gy26uiSVJaECjRgD3OFBuV/f1oumUqHm+6NU0Chmr1mNYUe6yiyQN3OAR+NuMBXtZY
 GKAN0k8Rc8erGYXztjvlS7q3dy+xkJkxmsibyij9E9fndNmh1/ZoCiQVNEX8IXccM0
 WJcsvia6+HOBk5cnalNMOFlIxyWM9tC8eTB2knptKLn4v4H3CuyF6/3NBxLIn5MvGy
 m9qYkrWNi6XG/LXFw7njafTGfTe64Zu0Yzzv+bFdKrvSdfxcoeX6KEwUULWHe8kfZT
 vxb6KCsh87L2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/7] drm/tyr: add GPU virtual memory (VM) support
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260721-fw-boot-b4-v8-4-b28f744581c9@collabora.com>
References: <20260721-fw-boot-b4-v8-0-b28f744581c9@collabora.com>
 <20260721-fw-boot-b4-v8-4-b28f744581c9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 01:05:58 +0000
Message-Id: <20260722010558.E5FC41F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The `unmap_range` function evaluates `va + size` directly without =
overflow checks, which will panic and cause a Denial of Service if large va=
lues are provided.
- [High] Vm::kill can fail to unmap the VM address space if memory allocati=
on fails, leading to permanent resource leaks.
- [Medium] Early returns on error paths in map_bo_range and unmap_range ski=
p deferred_cleanup(), leaking drm_gpuva objects queued by successful partia=
l steps.
- [Low] The condition `if gem_offset !=3D 0` inside the SG table iteration =
loop in `sm_step_map` is mathematically unreachable.
--

--- Patch [4]: [PATCH v8 4/7] drm/tyr: add GPU virtual memory (VM) support =
---
commit e1f0e3f5135d057c6b2d458da0a1a699b4be92cf
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/tyr: add GPU virtual memory (VM) support

Add GPU virtual address space management using the DRM GPUVM framework.
Each virtual memory (VM) space is backed by ARM64 LPAE Stage 1 page tables
and can be mapped into hardware address space (AS) slots for GPU execution.
The implementation provides memory isolation, virtual address allocation, a=
nd
supports mapping GEM buffer objects with configurable protection flags.

> diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
> new file mode 100644
> index 0000000000000..5431b04a72795
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/vm.rs
[ ... ]
> +    pub(crate) fn kill(&self) {
> +        // TODO: Turn the VM into a state where it can't be used.
> +        let _ =3D self.deactivate();
> +        let _ =3D self
> +            .unmap_range(self.va_range.start, self.va_range.end - self.v=
a_range.start)

[Severity: High]
Can this leak memory permanently if the system is under memory pressure?

In Vm::kill(), we are ignoring the result of unmap_range(). However,
unmap_range() unconditionally allocates GpuVaAlloc objects with GFP_KERNEL.
If a process is being out-of-memory killed or the system is under heavy
memory pressure, these allocations can fail, causing unmap_range() to abort.

If this fails during teardown, will the GPUVM tree remain populated and
cause drm_gpuvm_destroy() to leak the mappings when the VM is dropped?

> +            .inspect_err(|e| {
> +                dev_err!(
> +                    self.dev,
> +                    "Failed to unmap range during deactivate: {:?}\n",
> +                    e
> +                );
> +            });
> +    }
[ ... ]
> +    pub(crate) fn map_bo_range(
[ ... ]
> +        {
> +            let mut gpuvm_unique =3D self.gpuvm_unique.lock();
> +            self.exec_op(gpuvm_unique.as_mut().get_mut(), req, &mut reso=
urces)?;

[Severity: Medium]
Does this leak drm_gpuva objects if exec_op() returns an error?

If an earlier step in the drm_gpuvm_sm_map state machine (like unmapping an
overlap) succeeds, it queues the old objects for deferred cleanup. However,
the ? operator here causes an early return if a subsequent step fails.

This early return bypasses the self.gpuvm.deferred_cleanup() call below,
leaving the queued objects in the deferred list. Could a Drop guard or
similar mechanism be used to ensure deferred cleanup happens even on error
paths?

> +        }
> +        // We flush the defer cleanup list now. Things will be different=
 in
> +        // the asynchronous VM_BIND path, where we want the cleanup to
> +        // happen outside the DMA signalling path.
> +        self.gpuvm.deferred_cleanup();
> +        Ok(())
> +    }
> +
> +    /// Unmaps a virtual address range from the VM.
> +    ///
> +    /// This removes any existing mappings in the specified range, freei=
ng the
> +    /// virtual address space for reuse.
> +    pub(crate) fn unmap_range(&self, va: u64, size: u64) -> Result {
> +        let req =3D VmOpRequest {
> +            op_type: VmOpType::Unmap,
> +            region: va..(va + size),

[Severity: High]
Can this overflow and panic if large values are provided for va and size?

The addition va + size is evaluated directly here. If an attacker supplies
large values (e.g., va =3D u64::MAX - 10), this will overflow. In Rust, this
causes a panic (leading to a denial of service) or a corrupted range
underflow if compiled without overflow checks.

Should this use va.checked_add(size) as is correctly done in map_bo_range()?

> +        };
> +        let mut resources =3D VmOpResources {
> +            preallocated_gpuvas: [
> +                Some(GpuVaAlloc::<GpuVmData<'bound>>::new(GFP_KERNEL)?),
> +                Some(GpuVaAlloc::<GpuVmData<'bound>>::new(GFP_KERNEL)?),
> +                Some(GpuVaAlloc::<GpuVmData<'bound>>::new(GFP_KERNEL)?),
> +            ],
> +        };
> +        {
> +            let mut gpuvm_unique =3D self.gpuvm_unique.lock();
> +            self.exec_op(gpuvm_unique.as_mut().get_mut(), req, &mut reso=
urces)?;
> +        }
[ ... ]
> +    fn sm_step_map<'op>(
[ ... ]
> +        for sgt_entry in sgt.iter() {
> +            // Expressly convert to u64 to work with arm 32-bit builds.
> +            #[allow(clippy::useless_conversion)]
> +            let mut paddr =3D u64::from(sgt_entry.dma_address());
> +            #[allow(clippy::useless_conversion)]
> +            let mut sgt_entry_length =3D u64::from(sgt_entry.dma_len());
> +
> +            if bytes_left_to_map =3D=3D 0 {
> +                break;
> +            }
> +
> +            if gem_offset > 0 {
> +                // Skip the entire SGT entry if the gem_offset exceeds i=
ts length.
> +                let skip =3D u64::min(sgt_entry_length, gem_offset);
> +                paddr +=3D skip;
> +                sgt_entry_length -=3D skip;
> +                gem_offset -=3D skip;
> +            }
> +
> +            if sgt_entry_length =3D=3D 0 {
> +                continue;
> +            }
> +
> +            if gem_offset !=3D 0 {

[Severity: Low]
Is this condition mathematically reachable?

Earlier in the loop, if gem_offset > 0, the code subtracts
skip =3D u64::min(sgt_entry_length, gem_offset) from both variables.

If gem_offset >=3D sgt_entry_length, sgt_entry_length becomes 0, and the
loop continues before reaching this check.
If gem_offset < sgt_entry_length, gem_offset becomes exactly 0.

In all paths that reach this point, gem_offset seems guaranteed to be 0,
making this check and its error return dead code.

> +                dev_err!(
> +                    context.dev,
> +                    "Invalid gem_offset {} in page table mapping.\n",
> +                    gem_offset
> +                );
> +                return Err(EINVAL);
> +            }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-fw-boot-b4=
-v8-0-b28f744581c9@collabora.com?part=3D4
