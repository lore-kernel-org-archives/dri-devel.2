Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0C6606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matt3o12.de header.i=@matt3o12.de header.a=rsa-sha256 header.s=securedbylima-20230709 header.b=eXH+cTpt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD47710F1D4;
	Mon, 23 Nov 2026 20:40:09 +0000 (UTC)
Received: from mx1.mail-out.lima-city.de (mx1.mail-out.lima-city.de
 [91.216.248.203])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B11B310F1D4
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 20:39:53 +0000 (UTC)
From: Matteo Kloiber <kernel@matt3o12.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=matt3o12.de;
 s=securedbylima-20230709; t=1795466392;
 bh=Lr6DCDd2JVmMA2pnLdm6Y0re5QDYDWHDXLkvL8wD3vM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eXH+cTptI3CiNW1vjnVa+sMF4hw1g8i+pvhAMiHST5LuUz/UAkC4a+UR4dwz7sgct
 x4D02R8Ucu+0uodMP2j13gV7w4ZWOx+mS9846asQNnsMqZRpSYUVX11yU3XCUwkAfK
 m+iHwnNnbIf6W1ghWD6X6Bob4RCQJzkkmM8HWQPyBOrGKPs7R9xJiJqs3zZF3LHyaG
 oEjF/Ca2/n1OLvFQAnHeoZBKcLDBkakX0laSC/s7GTVGsX4sD7ergkNvxASLa2lUZc
 ng10T6grJw+8TRZSq1fddyhtjoE3ylgngb7N653s4mwuvwgrlq+8bINOVrpMIAUN92
 M+qAMQk9Vjgog==
To: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Matteo Kloiber <kernel@matt3o12.de>
Subject: [RFC PATCH 2/3] gpu: nova-core: build Gpu inside pin_init_scope
Date: Mon, 23 Nov 2026 21:39:25 +0100
Message-ID: <20261123203926.1787169-3-kernel@matt3o12.de>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20261123203926.1787169-1-kernel@matt3o12.de>
References: <20261123203926.1787169-1-kernel@matt3o12.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Gpu::new() sets the DMA mask and maximum segment size from inside the
try_pin_init!() initializer, after Tree::new(). A follow-up change
replaces these setters with a DMA configuration step that returns a
handle, and that handle must be available to several fields of the
initializer.

Wrap the initializer in pin_init_scope(), compute the chip spec before
it, and set the DMA parameters right after the spec is known. This
keeps the reindentation out of the follow-up change.

No functional change, except that the DMA parameters are now set
before Tree::new() instead of after it.

Signed-off-by: Matteo Kloiber <kernel@matt3o12.de>
---
 drivers/gpu/nova-core/gpu.rs | 233 ++++++++++++++++++-----------------
 1 file changed, 118 insertions(+), 115 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 8ab1687847ff..993f1512c391 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -455,142 +455,145 @@ pub(crate) fn new<'a>(
     ) -> impl PinInit<Self, Error> + use<'gpu, 'a> {
         let dev = pdev.as_ref();
 
-        try_pin_init!(Self {
-            spec: Spec::new(dev, bar).inspect(|spec| {
-                dev_info!(dev,"NVIDIA ({})\n", spec);
-            })?,
+        pin_init::pin_init_scope(move || {
+            let spec = Spec::new(dev, bar).inspect(|spec| {
+                dev_info!(dev, "NVIDIA ({})\n", spec);
+            })?;
+            let dma_mask = hal::gpu_hal(spec.chipset).dma_mask();
+            // SAFETY: `Gpu` owns all DMA allocations for this device, and we are
+            // still constructing it, so no concurrent DMA allocations can exist.
+            unsafe { pdev.dma_set_mask_and_coherent(dma_mask)? };
+
+            // Nova walks SG segments to build page tables, so their length is
+            // irrelevant to the device.
+            //
+            // SAFETY: `Gpu` owns all DMA allocations for this device, and we are
+            // still constructing it, so no concurrent DMA allocations can exist.
+            unsafe { pdev.dma_set_max_seg_size(u32::MAX) };
+
+            Ok(try_pin_init!(Self {
+                spec,
+
+                tree: Tree::new(pdev, bar, spec.chipset, irq::gsp::GSP_SUBTREE.into())?,
+
+                _: {
+                    // We must wait for GFW_BOOT completion before doing any significant setup on
+                    // the GPU.
+                    Self::wait_gfw_boot_completion(dev, bar, spec.chipset)?;
+                },
 
-            tree: Tree::new(pdev, bar, spec.chipset, irq::gsp::GSP_SUBTREE.into())?,
+                // Initialize this early because `gsp_resources` depends on it.
+                sysmem_flush: SysmemFlush::register(dev, bar, spec.chipset)?,
 
-            _: {
-                let dma_mask = hal::gpu_hal(spec.chipset).dma_mask();
+                gsp_resources <- try_pin_init!(GspResources {
+                    device: pdev,
 
-                // SAFETY: `Gpu` owns all DMA allocations for this device, and we are
-                // still constructing it, so no concurrent DMA allocations can exist.
-                unsafe { pdev.dma_set_mask_and_coherent(dma_mask)? };
+                    spec: *spec,
 
-                // Nova walks SG segments to build page tables, so their length is
-                // irrelevant to the device.
-                //
-                // SAFETY: `Gpu` owns all DMA allocations for this device, and we are
-                // still constructing it, so no concurrent DMA allocations can exist.
-                unsafe { pdev.dma_set_max_seg_size(u32::MAX) };
+                    bar,
 
-                // We must wait for GFW_BOOT completion before doing any significant setup on the GPU.
-                Self::wait_gfw_boot_completion(dev, bar, spec.chipset)?;
-            },
+                    gsp_falcon: Falcon::new(dev, spec.chipset, bar)?,
 
-            // Initialize this early because `gsp_resources` depends on it.
-            sysmem_flush: SysmemFlush::register(dev, bar, spec.chipset)?,
+                    sec2_falcon: Falcon::new(dev, spec.chipset, bar)?,
 
-            gsp_resources <- try_pin_init!(GspResources {
-                device: pdev,
+                    fsp: Fsp::try_new(dev, bar, spec.chipset)?,
 
-                spec: *spec,
+                    timer: Timer::setup(dev, bar, spec.chipset, fsp.as_ref())?,
 
-                bar,
+                    vgpu: VgpuManager::new(pdev, spec.chipset, fsp.as_mut()),
 
-                gsp_falcon: Falcon::new(dev, spec.chipset, bar)?,
+                    gsp <- Gsp::new(pdev, bar),
 
-                sec2_falcon: Falcon::new(dev, spec.chipset, bar)?,
+                    // This member must be initialized last, so the `UnloadBundle` can never be
+                    // dropped from outside of the constructed `GspResources`, ensuring that the
+                    // unload sequence is properly run in case of failure.
+                    unload_bundle: gsp.boot(GspBootContext {
+                        pdev,
+                        bar,
+                        chipset: spec.chipset,
+                        gsp_falcon,
+                        sec2_falcon,
+                        fsp: fsp.as_mut(),
+                        vgpu,
+                    })?,
+                }),
 
-                fsp: Fsp::try_new(dev, bar, spec.chipset)?,
+                _: {
+                    irq::gsp::quiesce(tree.get_ref(), &gsp_resources.gsp_falcon);
+                },
 
-                timer: Timer::setup(dev, bar, spec.chipset, fsp.as_ref())?,
+                // SAFETY: The registration is owned by `Gpu`, which is dropped when the device is
+                // unbound, so the registration's `Drop` runs.
+                _gsp_subtree <- unsafe {
+                    GspSubtree::new(
+                        pdev,
+                        tree.get_ref(),
+                        &gsp_resources.get_ref().gsp_falcon,
+                        &gsp_resources.get_ref().gsp.cmdq,
+                    )
+                },
 
-                vgpu: VgpuManager::new(pdev, spec.chipset, fsp.as_mut()),
+                // No interrupt announces the messages that the GSP posted during boot, before the
+                // SWGEN0 latch was cleared.
+                _: {
+                    gsp_resources.gsp.cmdq.drain()?;
+                },
 
-                gsp <- Gsp::new(pdev, bar),
+                gsp_static_info: {
+                    // Obtain and display basic GPU information.
+                    let info = gsp_resources.gsp.get_static_info()?;
+                    match info.gpu_name() {
+                        Ok(name) => dev_info!(dev, "GPU name: {}\n", name),
+                        Err(e) => dev_warn!(dev, "GPU name unavailable: {:?}\n", e),
+                    }
 
-                // This member must be initialized last, so the `UnloadBundle` can never be dropped
-                // from outside of the constructed `GspResources`, ensuring that the unload sequence
-                // is properly run in case of failure.
-                unload_bundle: gsp.boot(GspBootContext {
-                    pdev,
-                    bar,
-                    chipset: spec.chipset,
-                    gsp_falcon,
-                    sec2_falcon,
-                    fsp: fsp.as_mut(),
-                    vgpu,
-                })?,
-            }),
-
-            _: {
-                irq::gsp::quiesce(tree.get_ref(), &gsp_resources.gsp_falcon);
-            },
-
-            // SAFETY: The registration is owned by `Gpu`, which is dropped when the device is
-            // unbound, so the registration's `Drop` runs.
-            _gsp_subtree <- unsafe {
-                GspSubtree::new(
-                    pdev,
-                    tree.get_ref(),
-                    &gsp_resources.get_ref().gsp_falcon,
-                    &gsp_resources.get_ref().gsp.cmdq,
-                )
-            },
-
-            // No interrupt announces the messages that the GSP posted during boot, before the
-            // SWGEN0 latch was cleared.
-            _: {
-                gsp_resources.gsp.cmdq.drain()?;
-            },
-
-            gsp_static_info: {
-                // Obtain and display basic GPU information.
-                let info = gsp_resources.gsp.get_static_info()?;
-                match info.gpu_name() {
-                    Ok(name) => dev_info!(dev, "GPU name: {}\n", name),
-                    Err(e) => dev_warn!(dev, "GPU name unavailable: {:?}\n", e),
-                }
+                    if !info.usable_fb_regions.is_empty() {
+                        dev_dbg!(dev, "Usable FB regions:\n");
+                        for region in &info.usable_fb_regions {
+                            dev_dbg!(dev, "  - {:#x?}\n", region);
+                        }
 
-                if !info.usable_fb_regions.is_empty() {
-                    dev_dbg!(dev, "Usable FB regions:\n");
-                    for region in &info.usable_fb_regions {
-                        dev_dbg!(dev, "  - {:#x?}\n", region);
+                        dev_dbg!(
+                            dev,
+                            "Total usable VRAM: {} MiB\n",
+                            info.vram_size() / u64::SZ_1M
+                        );
                     }
 
-                    dev_dbg!(
-                        dev,
-                        "Total usable VRAM: {} MiB\n",
-                        info.vram_size() / u64::SZ_1M
-                    );
-                }
-
-                info
-            },
+                    info
+                },
 
-            // Create GPU memory manager owning memory management resources.
-            mm: {
-                let usable_vram = gsp_static_info.usable_fb_regions.first().ok_or(ENODEV)?;
-                let buddy_params = GpuBuddyParams {
-                    base_offset: usable_vram.start,
-                    size: usable_vram.end - usable_vram.start,
-                    chunk_size: Alignment::SZ_4K,
-                };
+                // Create GPU memory manager owning memory management resources.
+                mm: {
+                    let usable_vram = gsp_static_info.usable_fb_regions.first().ok_or(ENODEV)?;
+                    let buddy_params = GpuBuddyParams {
+                        base_offset: usable_vram.start,
+                        size: usable_vram.end - usable_vram.start,
+                        chunk_size: Alignment::SZ_4K,
+                    };
+
+                    GpuMm::new(
+                        bar,
+                        gsp_resources.spec.chipset,
+                        buddy_params,
+                        VramAddress::from_raw(gsp_static_info.total_fb_end),
+                    )?
+                },
 
-                GpuMm::new(
-                    bar,
-                    gsp_resources.spec.chipset,
-                    buddy_params,
-                    VramAddress::from_raw(gsp_static_info.total_fb_end),
-                )?
-            },
-
-            // Create BAR1 user interface for CPU access to GPU virtual memory.
-            bar_user <- {
-                let pdb_addr = VramAddress::from_raw(gsp_static_info.bar1_pde_base);
-                let bar1_idx = crate::driver::bar1_resource_index(pdev)?;
-                let bar1_size = pdev.resource_len(bar1_idx)?;
-
-                BarUser::new(
-                    pdb_addr,
-                    gsp_resources.spec.chipset,
-                    bar1_size,
-                    bar1,
-                )
-            },
+                // Create BAR1 user interface for CPU access to GPU virtual memory.
+                bar_user <- {
+                    let pdb_addr = VramAddress::from_raw(gsp_static_info.bar1_pde_base);
+                    let bar1_idx = crate::driver::bar1_resource_index(pdev)?;
+                    let bar1_size = pdev.resource_len(bar1_idx)?;
+
+                    BarUser::new(
+                        pdb_addr,
+                        gsp_resources.spec.chipset,
+                        bar1_size,
+                        bar1,
+                    )
+                },
+            }))
         })
     }
 
-- 
2.51.2

