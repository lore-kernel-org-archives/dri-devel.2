Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6710FC88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 21:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D94910E4C2;
	Sun, 13 Sep 2026 21:13:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=matt3o12.de header.i=@matt3o12.de header.b="gx6Y5lTp";
	dkim-atps=neutral
Received: from mx1.mail-out.lima-city.de (mx1.mail-out.lima-city.de
 [91.216.248.203])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B18210EA2A
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:08:44 +0000 (UTC)
From: Matteo Kloiber <kernel@matt3o12.de>
X-Lima-ML-UUID: e475dc44-34e1-4b7b-9a94-9cce70d58b60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=matt3o12.de;
 s=securedbylima-20230709; t=1789333722;
 bh=VSxCVx5n7jBoCIWNbQL4S4W0Yci3j9iKVIuzpXWUH1k=;
 h=From:To:Cc:Subject:Date:From;
 b=gx6Y5lTp3AUXnX5WtdvLJg46oHnBl8Fvjh8iT/UkrP2rBqkCXyLKMDmmgYG/sANgI
 0flvarruUGh6sMbShoMrLXJwSW8KS4Tb4iIbxPp6sETFXQ/x2vfl6FMX9hTLJxqHeJ
 boKugDYInjO4/zFCIwUvyl13C04fjo5xWxgfeh2T6axBRNp8uwBCFNzo2C6K1lNAc/
 s2RsSEQK/LE17G86wrjasrD11AhikOlfRE513kzZlRA+DigohG6fGXrosJggTfM8dR
 umh7+fWHZQGDv4r+/xs1ew79TZcZv+C6UjW5OWZ44tBykaNev7kbiBA5WB3PHX44uj
 O6GskA+LEdb8A==
To: dakr@kernel.org,
	acourbot@nvidia.com
Cc: aliceryhl@google.com, ojeda@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com, a.hindborg@kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matteo Kloiber <kernel@matt3o12.de>
Subject: [PATCH v2 0/2] rust: honor the maximum DMA segment size
Date: Sun, 13 Sep 2026 23:08:26 +0200
Message-ID: <20260913210828.125655-1-kernel@matt3o12.de>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 13 Sep 2026 21:13:31 +0000
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

Booting nova-core against a real GSP with CONFIG_DMA_API_DEBUG=y warns
when the ~60 MiB firmware image is mapped as a scatter-gather table:

  DMA-API: nova-core 0000:00:03.0: mapping sg segment longer than
  device claims to support [len=62914560] [max=65536]

There are two separate issues behind it.

Patch 1 has nova-core declare the segment size it actually supports. It
re-decomposes every segment into 4 KiB GSP page-table entries, so it has
no upper bound on segment length.

Furthermore, I also checked what other GPUs do, and most do the same:
set the max segment size u32::MAX. So this should be the correct
behavior for nova as well.

Patch 2 has SGTable::new() honor dma_get_max_seg_size() in addition to
dma_max_mapping_size(). The abstraction is generic, so a driver with a
real hardware segment limit would otherwise silently be handed segments
it cannot express in a single descriptor.

Tested on an RTX 5080 (GB203) passed through to a QEMU guest via VFIO
with CONFIG_DMA_API_DEBUG=y: the warning is gone, and GSP boot and RPC
still work.

Discussed on Zulip:
https://rust-for-linux.zulipchat.com/#narrow/channel/509436-Nova/topic/nova.20core.3A.20DMA-API.3A.20nova-core.200000.3A00.3A03.2E0.3A.20mapping.20sg.20segme/with/618319830

Changes in v2, all from Alexandre Courbot's review:
- Patch 1: use the `Assisted-by: LLM` form documented in
  Documentation/process/coding-assistants.rst, and place the tag before
  the Signed-off-by.
- Patch 1: trim the comment above dma_set_max_seg_size(), and state the
  SAFETY invariant in full instead of referring to the comment above it.
- Patch 2: rename max_mapping -> max_mapping_size.
- Patch 2: drop the paragraph claiming nova-core is the only user; the
  Rust DMA sample is one too, and neither is broken by this patch
  landing without patch 1.
- Patch 2: picked up Alexandre's Reviewed-by.

No functional change since v1.

v1: https://lore.kernel.org/r/20260831233215.287881-1-kernel@matt3o12.de

Matteo Kloiber (2):
  gpu: nova-core: declare unlimited DMA max segment size
  rust: scatterlist: honor the device's maximum segment size

 drivers/gpu/nova-core/gpu.rs |  7 +++++++
 rust/helpers/dma.c           |  5 +++++
 rust/kernel/scatterlist.rs   | 12 ++++++++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

Range-diff against v1:
1:  bd1a05a64e05 ! 1:  8a8637f02fa1 gpu: nova-core: declare unlimited DMA max segment size
    @@ Commit message
     
         CONFIG_DMA_API_DEBUG=y is required to see this warning.
     
    +    Assisted-by: LLM
         Signed-off-by: Matteo Kloiber <kernel@matt3o12.de>
    -    Assisted-by: Claude:claude-opus-4-8
     
      ## drivers/gpu/nova-core/gpu.rs ##
     @@ drivers/gpu/nova-core/gpu.rs: pub(crate) fn new<'a>(
                      // still constructing it, so no concurrent DMA allocations can exist.
                      unsafe { pdev.dma_set_mask_and_coherent(dma_mask)? };
      
    -+                // Nova re-decomposes SG segments into 4 KiB page-table entries, so it
    -+                // has no upper bound on segment length; declare that to the DMA layer.
    ++                // Nova walks SG segments to build page tables, so their length is
    ++                // irrelevant to the device.
     +                //
    -+                // SAFETY: same invariant as above -- still constructing, no concurrent
    -+                // DMA mapping can exist.
    ++                // SAFETY: `Gpu` owns all DMA allocations for this device, and we are
    ++                // still constructing it, so no concurrent DMA allocations can exist.
     +                unsafe { pdev.dma_set_max_seg_size(u32::MAX) };
     +
                      hal.wait_gfw_boot_completion(bar)
2:  69ea96f9290b ! 2:  4f8a19794529 rust: scatterlist: honor the device's maximum segment size
    @@ Commit message
         potentially causing problems for future drivers that use this
         abstraction.
     
    -    nova-core declares an unlimited segment size, so this does not change
    -    its behavior.
    -
         Fixes: 05aa6fb1c21d ("rust: scatterlist: Add abstraction for sg_table")
         Signed-off-by: Matteo Kloiber <kernel@matt3o12.de>
    +    Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
     
      ## rust/helpers/dma.c ##
     @@ rust/helpers/dma.c: __rust_helper void rust_helper_dma_set_max_seg_size(struct device *dev,
    @@ rust/kernel/scatterlist.rs: fn new(
              //
              // SAFETY: `dev.as_raw()` is a valid pointer to a `struct device`.
     -        let max_segment = match unsafe { bindings::dma_max_mapping_size(dev.as_raw()) } {
    -+        let max_mapping = match unsafe { bindings::dma_max_mapping_size(dev.as_raw()) } {
    ++        let max_mapping_size = match unsafe { bindings::dma_max_mapping_size(dev.as_raw()) } {
                  0 => u32::MAX,
     -            max_segment => u32::try_from(max_segment).unwrap_or(u32::MAX),
    -+            max_mapping => u32::try_from(max_mapping).unwrap_or(u32::MAX),
    ++            max_mapping_size => u32::try_from(max_mapping_size).unwrap_or(u32::MAX),
              };
      
     +        // SAFETY: `dev.as_raw()` is a valid pointer to a `struct device`.
     +        let max_seg_size = unsafe { bindings::dma_get_max_seg_size(dev.as_raw()) };
     +
    -+        let max_segment = max_mapping.min(max_seg_size);
    ++        let max_segment = max_mapping_size.min(max_seg_size);
     +
              Ok(try_pin_init!(&this in Self {
                  // SAFETY:

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.51.2
