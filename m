Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CADC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 14:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05AC010E1CD;
	Fri, 10 Jul 2026 14:27:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="pUR9l/1A";
	dkim-atps=neutral
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com
 [209.85.208.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A905A10E1CD
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 14:27:45 +0000 (UTC)
Received: by mail-ed1-f74.google.com with SMTP id
 4fb4d7f45d1cf-69c20d1d150so1104801a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783693664; x=1784298464;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZJxWnguOTe6CKBDsvGkeHPaaIWVYmyS6i3squ7Maq6Q=;
 b=pUR9l/1AT36eRj+0KgL3XdayqWfPOL2Lt4KEX9sD25+Vqw5M1m9ZrEyhCzxjIHMP64
 izL0fIUifwMPwypTZ8V5DlZHbvRv5PNoEtoJXi7d2QAiqJQ8optS6Qq4BJJKdZ5/FIO9
 gOw5S9pNtvx+KQbsOOikflEJ40p21liL1Vj9NGansDw9IjyNFlfPmeW7L/7tX4pfvrWE
 /kvwFMTIGlf98pQ48dIGTA7R15iusQcC6dNJn1fwIrax6iuMGulMNcvdonHloWOLQBrG
 YmzF0ai4EyaDzlcVxI4/+D0iZuw+5AjZwuUj4gdwut6FO8TTkKmqkJBzGcL/m4ghbTED
 9qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783693664; x=1784298464;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZJxWnguOTe6CKBDsvGkeHPaaIWVYmyS6i3squ7Maq6Q=;
 b=PlHeYhsSz6P2EIN0bHnix2pbx0aMjsYmF0xl2RBBXM2B6n5+B82BPYIfgWkWx98KmE
 cNiuupHVfWsaxqRmIuryfvtZZtm2AQ+LbktTAGx/FvfU5khMM9NL/aHlx7pcrZ+hNuMG
 7hti7fMVwM0kdp7Ysjn6aX8CEFlULhhMik9tpm/jKSz1H3eE7ZKUfsTayM/FIP0ZcVCs
 CqTkGagIcFJ/WqSa9icX2KuS4kCcgnGvMOSg1ihWOkjjRTDV06wVDdeASKBfnG2hjrl7
 aVMKNWF8Ww2Mz4L+K6kRkRh3rTh7c1HmxwgEjJ1Shuvs8Y2Lk1b+tq/3fl1T9Oxzssto
 Ql5A==
X-Forwarded-Encrypted: i=1;
 AHgh+RotNW0+dtjTKwJ8gxnQUrVTVyXiQYqSeeX0RyFfhba6IBLyAeQCaGrBxtYqsRaxCau9EkVw5R583ow=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygTP7/fOf3176Iopn5UTQ5dO3hmI1kHHTZhohe7xlbsvtF45KX
 IllFtBfaap2YoGJCRcvudk6CswcpHluOpWCPLVaP/dsENnpWP7PCwNcfikRLsLX2O7gKFNzEsnl
 75vexIXJoJQLusecUEA==
X-Received: from edqi22.prod.google.com ([2002:aa7:c716:0:b0:698:c0bc:3a7f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1f0d:b0:698:663d:d7bd with SMTP id
 4fb4d7f45d1cf-69ab446e0a8mr4806641a12.11.1783693663712; 
 Fri, 10 Jul 2026 07:27:43 -0700 (PDT)
Date: Fri, 10 Jul 2026 14:27:42 +0000
In-Reply-To: <20260709-fw-boot-b4-v6-4-ca391e1a4108@collabora.com>
Mime-Version: 1.0
References: <20260709-fw-boot-b4-v6-0-ca391e1a4108@collabora.com>
 <20260709-fw-boot-b4-v6-4-ca391e1a4108@collabora.com>
Message-ID: <alEBXhTk2th3aENc@google.com>
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

I'm seeing some build failures on 32-bit arm:

error[E0308]: mismatched types
   --> /home/runner/work/linux/linux/linux/drivers/gpu/drm/tyr/vm.rs:572:45
    |
572 |             let mut sgt_entry_length: u64 = sgt_entry.dma_len();
    |                                       ---   ^^^^^^^^^^^^^^^^^^^ expected `u64`, found `u32`
    |                                       |
    |                                       expected due to this
    |
help: you can convert a `u32` to a `u64`
    |
572 |             let mut sgt_entry_length: u64 = sgt_entry.dma_len().into();
    |                                                                +++++++

error[E0308]: mismatched types
   --> /home/runner/work/linux/linux/linux/drivers/gpu/drm/tyr/vm.rs:581:26
    |
581 |                 paddr += skip;
    |                          ^^^^ expected `u32`, found `u64`

error[E0277]: cannot add-assign `u64` to `u32`
   --> /home/runner/work/linux/linux/linux/drivers/gpu/drm/tyr/vm.rs:581:23
    |
581 |                 paddr += skip;
    |                       ^^ no implementation for `u32 += u64`
    |
    = help: the trait `core::ops::AddAssign<u64>` is not implemented for `u32`
help: `u32` implements trait `core::ops::AddAssign<Rhs>`
   --> /home/runner/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/internal_macros.rs:61:9
    |
 61 |           impl const $imp<&$u> for $t {
    |           ^^^^^^^^^^^^^^^^^^^^^^^^^^^ `core::ops::AddAssign<&u32>`
    |
   ::: /home/runner/work/linux/linux/linux/rust/zerocopy/src/byteorder.rs:316:9
    |
316 |           impl<O: ByteOrder> core::ops::$trait_assign<$name<O>> for $native {
    |           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ `core::ops::AddAssign<zerocopy::byteorder::U32<O>>`
...
720 | / define_type!(
721 | |     A,
722 | |     "A 32-bit unsigned integer",
723 | |     U32,
...   |
735 | |     [U64, U128]
736 | | );
    | |_- in this macro invocation
    |
   ::: /home/runner/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/ops/arith.rs:786:9
    |
786 |           impl const AddAssign for $t {
    |           ^^^^^^^^^^^^^^^^^^^^^^^^^^^ `core::ops::AddAssign`
  CC      drivers/base/firmware_loader/builtin/main.o
...
799 |   add_assign_impl! { usize u8 u16 u32 u64 u128 isize i8 i16 i32 i64 i128 f16 f32 f64 f128 }
    |   ----------------------------------------------------------------------------------------- in this macro invocation
    = note: this error originates in the macro `impl_ops_traits` which comes from the expansion of the macro `add_assign_impl` (in Nightly builds, run with -Z macro-backtrace for more info)

error[E0308]: mismatched types
   --> /home/runner/work/linux/linux/linux/drivers/gpu/drm/tyr/vm.rs:596:65
    |
596 |             let segment_mapped = match pt_map(context.pt, iova, paddr, len, prot) {
    |                                        ------                   ^^^^^ expected `u64`, found `u32`
    |                                        |
    |                                        arguments to this function are incorrect
    |
note: function defined here
   --> /home/runner/work/linux/linux/linux/drivers/gpu/drm/tyr/vm.rs:731:4
    |
731 | fn pt_map(
    |    ^^^^^^
...
734 |     paddr: u64,
    |     ----------
help: you can convert a `u32` to a `u64`
    |
596 |             let segment_mapped = match pt_map(context.pt, iova, paddr.into(), len, prot) {
    |                                                                      +++++++

  CC      net/core/tso.o
error: aborting due to 4 previous errors
