Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F17C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3A2C10E3C9;
	Fri, 10 Jul 2026 14:15:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="DgpZKPIV";
	dkim-atps=neutral
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C274710E3C9
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:15:11 +0000 (UTC)
Received: by mail-wr1-f73.google.com with SMTP id
 ffacd0b85a97d-4767036f8faso605631f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 07:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783692910; x=1784297710;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cZ/Rax3JtQ73njUkK4P8UwJJ63zTUvy1XJcf1ykx4E4=;
 b=DgpZKPIV2c+xCvVLi1mKMJKDQhq8Y/UBF9lVRKFRokY7ZBLibd4jKtYkWjDqY5Xsh2
 4Ftbb15qs435BrPWOr65s5BoU9TqZvPT0n4DYnRVy+FLXlivElGOI2VDO/WZpfX9HtIA
 n/YVVHMYTUPWM7uuXLdzjH2/+uqA+kEEajFnyV3UWhgLWVOFk8lmjzr0W+8sX2bU20Fi
 H/dD1kYRd/5qgF2lpJTLL0dwjuwNNB/FG4JuV/fWeEx0aqvMy7Xv5B9OD/wBN69TpPds
 PI7Bk598TOl7ID9uT1bOdTUN2zaKJdVjWQCaF8Q0JHyjb9dYV51Qg4FiaYXI1QTXoEBc
 f70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783692910; x=1784297710;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cZ/Rax3JtQ73njUkK4P8UwJJ63zTUvy1XJcf1ykx4E4=;
 b=Dlc4XSd2MGhZgiLirA+oWb2JOP3k+dQWG8k7OgqkdR6aajFPcHWwJhP/0rA06Xatoc
 16+OeZnai4vz9BWqQGtj8xSQsbPYBuvG/1uMLTlt+isXe0nqaUaA/IBrG2fsVe/HqQQA
 2qyHei9e9CjQB8NCQ7XS3K0QA3p2bmb1SkuhWsspcT8wevOLbkpUAbKcSCORy1ONQJrI
 HYs1pYjmiFgEkvOpFF0Q6ViLWZNoLgvr4S71FZineMRrwFitkd2/UvMBCNThvnegkoho
 829RU1Wjtkq9t3pxO6alhbGQT4zFRMm4lgBp5UGUHk9S0FZcifIXndxufudcAowT4B4F
 Lkjw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfvAO/Q77eXo099BUa/Uvp24GWLyTbq1j5A1EMQtYlz+vYxIgivHlW3Ha62OI+ifiw8EtAu6Uf3JY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6hbDOWqM6R4wHm4oWw0ED+qbArYRuMHWAI3TAXIHgFIhvTHuG
 Y8Q2HCnhPpLT1/IhPqIMUCNymRmqwXzCoaY55skVDf9O2oYx6FfNRdM+Cw+CuyHwiVFTfomYCqQ
 RZ837iFi4yGpVVWj/eQ==
X-Received: from wrqt12.prod.google.com ([2002:a5d:460c:0:b0:463:dd19:ae30])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:24c2:b0:475:f100:360c with SMTP id
 ffacd0b85a97d-47df0822e2dmr12652945f8f.59.1783692909823; 
 Fri, 10 Jul 2026 07:15:09 -0700 (PDT)
Date: Fri, 10 Jul 2026 14:15:09 +0000
In-Reply-To: <20260709-fw-boot-b4-v6-4-ca391e1a4108@collabora.com>
Mime-Version: 1.0
References: <20260709-fw-boot-b4-v6-0-ca391e1a4108@collabora.com>
 <20260709-fw-boot-b4-v6-4-ca391e1a4108@collabora.com>
Message-ID: <alD-bUuMS2913WJO@google.com>
Subject: Re: [PATCH v6 4/7] drm/tyr: add GPU virtual memory (VM) support
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 boris.brezillon@collabora.com, samitolvanen@google.com, acourbot@nvidia.com, 
 alvin.sun@linux.dev, laura.nao@collabora.com, work@onurozkan.dev, 
 beata.michalska@arm.com, steven.price@arm.com, lyude@redhat.com
Content-Type: text/plain; charset="utf-8"
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

On Thu, Jul 09, 2026 at 02:36:44PM -0700, Deborah Brouwer wrote:
> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> Add GPU virtual address space management using the DRM GPUVM framework.
> Each virtual memory (VM) space is backed by ARM64 LPAE Stage 1 page tables
> and can be mapped into hardware address space (AS) slots for GPU execution.
> 
> The implementation provides memory isolation and virtual address
> allocation. VMs support mapping GEM buffer objects with configurable
> protection flags (readonly, noexec, uncached) and handle both 4KB and 2MB
> page sizes. A new_dummy_object() helper is provided to create a dummy GEM
> object for use as a GPUVM root.
> 
> The vm module integrates with the MMU for address space activation and
> provides map/unmap/remap operations with page table synchronization.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

> +impl core::fmt::Display for VmMapFlags {

Use kernel::fmt instead of core::fmt.

> +impl TryFrom<u32> for VmMapFlags {
> +    type Error = Error;
> +
> +    fn try_from(value: u32) -> core::result::Result<Self, Self::Error> {

Simplifies to Result<Self, Self::Error> without full path.

> +        let valid = (kernel::uapi::drm_panthor_vm_bind_op_flags_DRM_PANTHOR_VM_BIND_OP_MAP_READONLY
> +            | kernel::uapi::drm_panthor_vm_bind_op_flags_DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC
> +            | kernel::uapi::drm_panthor_vm_bind_op_flags_DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED)
> +            as u32;

Simplifies to

	let valid = Self::Readonly as u32 | Self::Noexec as u32 | Self::Uncached as u32;

> +impl Drop for PtUpdateContext<'_, '_> {
> +    fn drop(&mut self) {
> +        if let Err(e) = self.mmu.end_vm_update(self.as_data) {
> +            pr_err!("Failed to end VM update {:?}\n", e);
> +        }
> +
> +        if let Err(e) = self.mmu.flush_vm(self.as_data) {
> +            pr_err!("Failed to flush VM {:?}\n", e);
> +        }

I assume it's not possible for this to run during a VM eviction, right?

> +        let gpuvm_unique = kernel::drm::gpuvm::GpuVm::new::<Error, _>(
> +            c_str!("Tyr::GpuVm"),

This can just be c"Tyr::GpuVm". The macro is only needed in macro
contexts where this rewrite is not possible e.g. because the macro's
caller provides a non-c str literal.

> +        let mut gpuvm_unique = self.gpuvm_unique.lock();
> +
> +        self.exec_op(gpuvm_unique.as_mut().get_mut(), req, &mut resources)?;
> +
> +        // We flush the defer cleanup list now. Things will be different in
> +        // the asynchronous VM_BIND path, where we want the cleanup to
> +        // happen outside the DMA signalling path.
> +        self.gpuvm.deferred_cleanup();

You should probably release the gpuvm_unique mutex before invoking
deferred_cleanup().

(Multiple occurances in this patch.)

> +            if gem_offset > 0 {
> +                // Skip the entire SGT entry if the gem_offset exceeds its length
> +                let skip = sgt_entry_length.min(gem_offset);

Nit: this may just be my idiosyncrasy, but I think this is more readable as:

	usize::min(sgt_entry_length, gem_offset)

(Multiple occurances in this file.)

> +            let segment_mapped = match pt_map(context.pt, iova, paddr, len, prot) {
> +                Ok(segment_mapped) => segment_mapped,
> +                Err(e) => {
> +                    // clean up any successful mappings from previous SGT entries.
> +                    let total_mapped = iova - start_iova;
> +                    if total_mapped > 0 {
> +                        pt_unmap(context.pt, start_iova..(start_iova + total_mapped)).ok();

Nit: the idiomatic way to ignore errors is to write:

	let _ = pt_unmap(context.pt, start_iova..(start_iova + total_mapped));

instead of converting the Result into an Option with .ok() and abusing
the fact that Option is not #[must_use].

> +/// This function selects the largest supported block size (currently 4KB or 2MB)
> +/// that can be used for a mapping at the given address and size, respecting alignment constraints.
> +///
> +/// We can map multiple pages at once but we can't exceed the size of the
> +// table entry itself. So, if mapping 4KB pages, figure out how many pages
> +// can be mapped before we hit the 2MB boundary. Or, if mapping 2MB pages,
> +// figure out how many pages can be mapped before hitting the 1GB boundary
> +// Returns the page size (4KB or 2MB) and the number of pages that can be mapped at that size.
> +fn get_pgsize(addr: u64, size: u64) -> (u64, u64) {

Some of these comments are missing a / character.

> +        // SAFETY: Exclusive access to the page table is ensured because
> +        // the pt reference comes from PtUpdateContext, which is created
> +        // during a VM update operation, ensuring the driver does not concurrently
> +        // modify the page table.
> +        let (mapped, result) = unsafe {
> +            pt.map_pages(
> +                curr_iova as usize,
> +                (curr_paddr as usize).try_into().unwrap(),
> +                pgsize as usize,
> +                pgcount as usize,
> +                prot,
> +                GFP_KERNEL,
> +            )
> +        };

It would be ideal if this SAFETY comment explains why this safety
requirement is satisfied:

	This page table must not contain any mapping that overlaps with
	the mapping created by this call.

(It's because GPUVM tells you to unmap pages before it tells you to map
them.)

> +/// Unmaps a virtual address range from the page table.
> +///
> +/// This function removes all page table entries in the specified range,
> +/// automatically handling different page sizes that may be present.
> +fn pt_unmap(pt: &IoPageTable<'_, ARM64LPAES1>, range: Range<u64>) -> Result {
> +    let mut iova = range.start;
> +    let mut bytes_left_to_unmap = range.end - range.start;
> +
> +    while bytes_left_to_unmap > 0 {
> +        let (pgsize, pgcount) = get_pgsize(iova, bytes_left_to_unmap);
> +
> +        // SAFETY: Exclusive access to the page table is ensured because
> +        // the pt reference comes from PtUpdateContext, which was
> +        // created while holding &mut Vm, preventing any other access to the
> +        // page table for the duration of this operation.
> +        let unmapped = unsafe { pt.unmap_pages(iova as usize, pgsize as usize, pgcount as usize) };

It would be ideal if this SAFETY comment explains why this safety
requirement is satisfied:

	This page table must contain one or more consecutive mappings
	starting at `iova` whose total size is `pgcount * pgsize`.

I.e. why can we be sure that this call isn't trying to unmap a 4KB
sub-page in something that exists as a 2MB mapping in the page table?

(It's because GPUVM tells you to unmap exactly the range you were
previously told to map.)

Alice
