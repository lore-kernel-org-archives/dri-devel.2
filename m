Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF51C9830E
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 14:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C5010E4D1;
	Sun, 27 Sep 2026 14:44:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WKpc7IBo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A83110E4D1
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 14:44:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 44AAF601F7;
 Sun, 27 Sep 2026 14:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545E31F000FF;
 Sun, 27 Sep 2026 14:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790520266;
 bh=DDRi0MR9abY4CvwpfEnFn7ZEXpCGwAXC739+RdWT/Ug=;
 h=From:To:Cc:Subject:Date;
 b=WKpc7IBoxl5iT+laAxikEdpEuU1/OX7/99tsS//QicW2Q2Yp6DF+1RxJ7JbPAZyjt
 pXKSWhaEUTL5T+a6VLvPP4SUhWo3H6fBjjJ7v011r9sD2nydmoQdmaGcU23B0vjM/I
 ZBUy1GzyVi7INHpka5+MssfszKAMq5u2gmtL/iKsHN/rGaeHUV7XeNEvMoN/grsn2d
 gNafpE/pAoPxaaLxK0e0yylX+PFFryvSU+cm6L2dpCPltyH0iKU8EHEN1TaNbz5HZ8
 XbqCIQM3T5l7YaGLJdik+TUKCfQGM+98kAqbPoLq7uHnEUXZweLrwuJT2F5Myxz0eW
 yS2SxQzKqttUg==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 gary@garyguo.net
Cc: nova-gpu@lists.linux.dev,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] gpu: nova-core: use a single try_pin_init!() block in probe()
Date: Sun, 27 Sep 2026 16:44:03 +0200
Message-ID: <20260927144417.1280385-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Just like in Gpu::new() a single try_pin_init!() block makes the code
more readable.

Besides that, it prepares the code for a proper PCI device enable guard
that we will get soon.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs | 105 ++++++++++++++++----------------
 1 file changed, 54 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index bdaed5408a00..623d59dcde6e 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -100,57 +100,60 @@ fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
         _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
-        pin_init::pin_init_scope(move || {
-            dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
-
-            pdev.enable_device_mem()?;
-            pdev.set_master();
-
-            Ok(try_pin_init!(NovaCore {
-                bar: pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar0")?,
-                bar1: {
-                    let bar1_idx = bar1_resource_index(pdev)?;
-                    pdev.iomap_region(bar1_idx, c"nova-core/bar1")?
-                },
-                // TODO: Use self-referential pin-init syntax once available.
-                gpu <- Gpu::new(
-                    pdev,
-                    // SAFETY: `bar` is initialized above, pinned, and outlives `gpu`.
-                    unsafe { &*core::ptr::from_ref(bar) },
-                    // SAFETY: `bar1` is initialized above, pinned, and outlives `gpu`.
-                    unsafe { &*core::ptr::from_ref(bar1) },
-                ).pin_chain(|_gpu| {
-                    #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
-                    _gpu.run_selftests(pdev);
-                    Ok(())
-                }),
-                _reg: {
-                    // TODO: Use `&gpu` self-referential pin-init syntax once available.
-                    //
-                    // SAFETY: `gpu` is initialized before this expression is evaluated
-                    // (`try_pin_init!()` initializes fields in initializer order), lives at
-                    // a pinned stable address, and is dropped after `_reg` (struct field
-                    // drop order).
-                    let gpu = unsafe {
-                        Pin::new_unchecked(&*core::ptr::from_ref(gpu.as_ref().get_ref()))
-                    };
-
-                    // SAFETY: `NovaCore` is dropped when the device is unbound;
-                    // i.e. `mem::forget()` is never called on it.
-                    unsafe {
-                        auxiliary::Registration::new_with_lt(
-                            pdev.as_ref(),
-                            c"nova-drm",
-                            // TODO[XARR]: Use XArray or perhaps IDA for proper ID
-                            // allocation/recycling. For now, use a simple atomic counter that
-                            // never recycles IDs.
-                            AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
-                            crate::MODULE_NAME,
-                            NovaCoreApi { gpu, pdev },
-                        )?
-                    }
-                },
-            }))
+        dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
+
+        try_pin_init!(NovaCore {
+            _: {
+                pdev.enable_device_mem()?;
+                pdev.set_master();
+            },
+
+            bar: pdev.iomap_region_sized::<BAR0_SIZE>(0, c"nova-core/bar0")?,
+
+            bar1: {
+                let bar1_idx = bar1_resource_index(pdev)?;
+                pdev.iomap_region(bar1_idx, c"nova-core/bar1")?
+            },
+
+            // TODO: Use self-referential pin-init syntax once available.
+            gpu <- Gpu::new(
+                pdev,
+                // SAFETY: `bar` is initialized above, pinned, and outlives `gpu`.
+                unsafe { &*core::ptr::from_ref(bar) },
+                // SAFETY: `bar1` is initialized above, pinned, and outlives `gpu`.
+                unsafe { &*core::ptr::from_ref(bar1) },
+            ).pin_chain(|_gpu| {
+                #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
+                _gpu.run_selftests(pdev);
+                Ok(())
+            }),
+
+            _reg: {
+                // TODO: Use `&gpu` self-referential pin-init syntax once available.
+                //
+                // SAFETY: `gpu` is initialized before this expression is evaluated
+                // (`try_pin_init!()` initializes fields in initializer order), lives at
+                // a pinned stable address, and is dropped after `_reg` (struct field
+                // drop order).
+                let gpu = unsafe {
+                    Pin::new_unchecked(&*core::ptr::from_ref(gpu.as_ref().get_ref()))
+                };
+
+                // SAFETY: `NovaCore` is dropped when the device is unbound;
+                // i.e. `mem::forget()` is never called on it.
+                unsafe {
+                    auxiliary::Registration::new_with_lt(
+                        pdev.as_ref(),
+                        c"nova-drm",
+                        // TODO[XARR]: Use XArray or perhaps IDA for proper ID
+                        // allocation/recycling. For now, use a simple atomic counter that
+                        // never recycles IDs.
+                        AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
+                        crate::MODULE_NAME,
+                        NovaCoreApi { gpu, pdev },
+                    )?
+                }
+            },
         })
     }
 }

base-commit: 10a6623a24a85708650efad7be15182289403cd7
-- 
2.55.0

