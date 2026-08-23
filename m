Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BC7C5DF97
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 10:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99C3810E02A;
	Sun, 23 Aug 2026 10:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="ESEovgHG";
	dkim-atps=neutral
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch
 [185.70.43.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD68E10E02A
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 10:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1787482261; x=1787741461;
 bh=Hur3ADIaCcusTzxbTebC/Ylg9Grzu5lROGSsmsYOWzQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=ESEovgHGVHLijgbnL8oti06E/PO9OGSetFj3QMVIW7khpByMuL8p70O1dMRg4Q0Ls
 kvFlw49DLC8xVA6rt+CmNYqnkv0A/XeKidWYIjv2uQblVLTbOSYT15hcjikSlxuT3c
 kUfYBmfWeK0+UqBPnsvSJ0cWkznNWxoc2t7ODbjdbTQ2cMHNMMY3L0ia9R8wiJ18So
 Ek1nEgEWugDcAEwfw/bCVxmu9mczizYCXqigwy29+FIvUHgvoV5uC8QGMdPw/1Ww+J
 VycWmnKceXnGQxNkqdCSsCaNqF1rxyUYmwdKFueFHN7QNspcPm+ZbsRjgXX6FNGZ99
 vCghstrT2Ap/Q==
X-Pm-Submission-Id: 4hSW6n54NPz1DDX4
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH 1/2] drm/tyr: move reset work to platform driver data
Date: Sun, 23 Aug 2026 13:50:07 +0300
Message-ID: <20260823-tyr-gpu-unplug-b4-v1-1-e99c07d4c785@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260823-tyr-gpu-unplug-b4-v1-0-e99c07d4c785@onurozkan.dev>
References: <20260823-tyr-gpu-unplug-b4-v1-0-e99c07d4c785@onurozkan.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Move ResetHandle out of DRM registration data and store it as the first
field of platform driver data. This makes platform teardown drain queued
or running reset work before dropping the DRM registration and the
resources it owns.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 drivers/gpu/drm/tyr/driver.rs | 172 ++++++++++++++++++++++--------------------
 1 file changed, 89 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index c326192f8af2..92ed0de0b4e4 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -51,8 +51,13 @@
 
 #[pin_data(PinnedDrop)]
 pub(crate) struct TyrPlatformDriverData<'bound> {
-    _device: ARef<TyrDrmDevice>,
+    // `ResetHandle::drop()` drains queued/running works and this must happen
+    // before clocks/regulators are dropped. So keep this field before them to
+    // ensure the correct drop order.
+    #[pin]
+    _reset: reset::ResetHandle<'bound>,
     _reg: drm::Registration<'bound, TyrDrmDriver>,
+    _device: ARef<TyrDrmDevice>,
 }
 
 /// Resources kept alive by the DRM registration.
@@ -61,12 +66,6 @@ pub(crate) struct TyrDrmRegistrationData<'bound> {
     /// Parent platform device.
     pub(crate) pdev: &'bound platform::Device<Bound>,
 
-    // `ResetHandle::drop()` drains queued/running works and this must happen
-    // before clocks/regulators are dropped. So keep this field before them to
-    // ensure the correct drop order.
-    #[pin]
-    pub(crate) reset: reset::ResetHandle<'bound>,
-
     /// Firmware sections.
     pub(crate) fw: Arc<Firmware<'bound>>,
 
@@ -101,82 +100,89 @@ fn probe<'bound>(
         pdev: &'bound platform::Device<Core<'_>>,
         _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
-        let core_clk = Clk::get(pdev.as_ref(), Some(c"core"))?;
-        let stacks_clk = OptionalClk::get(pdev.as_ref(), Some(c"stacks"))?;
-        let coregroup_clk = OptionalClk::get(pdev.as_ref(), Some(c"coregroup"))?;
-
-        core_clk.prepare_enable()?;
-        stacks_clk.prepare_enable()?;
-        coregroup_clk.prepare_enable()?;
-
-        let mali_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"mali")?;
-        let sram_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"sram")?;
-
-        let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
-
-        let hw = Arc::pin_init(
-            reset::HwGate::new(request.iomap_sized::<SZ_2M>()?),
-            GFP_KERNEL,
-        )?;
-
-        reset::run_reset(pdev.as_ref(), &hw)?;
-
-        let gpu_info = {
-            let hw_guard = hw.access();
-            let gpu_info = GpuInfo::new(hw_guard.iomem());
-            gpu_info.log(pdev.as_ref());
-            gpu_info
-        };
-
-        let pa_bits = MMU_FEATURES::from_raw(gpu_info.mmu_features)
-            .pa_bits()
-            .get();
-        // SAFETY: No concurrent DMA allocations or mappings can be made because
-        // the device is still being probed and therefore isn't being used by
-        // other threads of execution.
-        unsafe { pdev.dma_set_mask_and_coherent(DmaMask::try_new(pa_bits)?)? };
-
-        let unreg_dev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, Ok(()))?;
-
-        let mmu = Mmu::new(hw.clone(), &gpu_info)?;
-
-        let firmware = Firmware::new(pdev, hw.clone(), &unreg_dev, mmu.as_arc_borrow(), &gpu_info)?;
-
-        firmware.boot()?;
-        firmware.enable_global_interface(&gpu_info, &core_clk)?;
-
-        let reg_data = try_pin_init!(TyrDrmRegistrationData {
-                pdev,
-                // SAFETY: `ResetHandle` is stored in registration data created with `new_with_lt`
-                // and is dropped before the borrowed device and MMIO references expire.
-                reset <- unsafe { reset::ResetHandle::new(pdev, hw.clone())? },
-                fw: firmware,
-                clks <- new_mutex!(Clocks {
-                    core: core_clk,
-                    stacks: stacks_clk,
-                    coregroup: coregroup_clk,
-                }),
-                regulators <- new_mutex!(Regulators {
-                    _mali: mali_regulator,
-                    _sram: sram_regulator,
-                }),
-                gpu_info,
-        });
-
-        // SAFETY: `reg` is stored in the platform driver data and is not leaked or
-        // forgotten, so it is dropped before the `'bound` registration data can become
-        // invalid.
-        let reg = unsafe { drm::Registration::new_with_lt(pdev.as_ref(), unreg_dev, reg_data, 0)? };
-
-        let driver = TyrPlatformDriverData {
-            _device: reg.device().into(),
-            _reg: reg,
-        };
-
-        // We need this to be dev_info!() because dev_dbg!() does not work at
-        // all in Rust for now, and we need to see whether probe succeeded.
-        dev_info!(pdev, "Tyr initialized correctly.\n");
-        Ok(driver)
+        pin_init::pin_init_scope(move || {
+            let core_clk = Clk::get(pdev.as_ref(), Some(c"core"))?;
+            let stacks_clk = OptionalClk::get(pdev.as_ref(), Some(c"stacks"))?;
+            let coregroup_clk = OptionalClk::get(pdev.as_ref(), Some(c"coregroup"))?;
+
+            core_clk.prepare_enable()?;
+            stacks_clk.prepare_enable()?;
+            coregroup_clk.prepare_enable()?;
+
+            let mali_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"mali")?;
+            let sram_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"sram")?;
+
+            let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
+
+            let hw = Arc::pin_init(
+                reset::HwGate::new(request.iomap_sized::<SZ_2M>()?),
+                GFP_KERNEL,
+            )?;
+
+            reset::run_reset(pdev.as_ref(), &hw)?;
+
+            let gpu_info = {
+                let hw_guard = hw.access();
+                let gpu_info = GpuInfo::new(hw_guard.iomem());
+                gpu_info.log(pdev.as_ref());
+                gpu_info
+            };
+
+            let pa_bits = MMU_FEATURES::from_raw(gpu_info.mmu_features)
+                .pa_bits()
+                .get();
+            // SAFETY: No concurrent DMA allocations or mappings can be made because
+            // the device is still being probed and therefore isn't being used by
+            // other threads of execution.
+            unsafe { pdev.dma_set_mask_and_coherent(DmaMask::try_new(pa_bits)?)? };
+
+            let unreg_dev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, Ok(()))?;
+
+            let mmu = Mmu::new(hw.clone(), &gpu_info)?;
+
+            let firmware =
+                Firmware::new(pdev, hw.clone(), &unreg_dev, mmu.as_arc_borrow(), &gpu_info)?;
+
+            firmware.boot()?;
+            firmware.enable_global_interface(&gpu_info, &core_clk)?;
+
+            let reg_data = try_pin_init!(TyrDrmRegistrationData {
+                    pdev,
+                    fw: firmware,
+                    clks <- new_mutex!(Clocks {
+                        core: core_clk,
+                        stacks: stacks_clk,
+                        coregroup: coregroup_clk,
+                    }),
+                    regulators <- new_mutex!(Regulators {
+                        _mali: mali_regulator,
+                        _sram: sram_regulator,
+                    }),
+                    gpu_info,
+            });
+
+            // SAFETY: `reg` is stored in the platform driver data and is not leaked or
+            // forgotten, so it is dropped before the `'bound` registration data can become
+            // invalid.
+            let reg =
+                unsafe { drm::Registration::new_with_lt(pdev.as_ref(), unreg_dev, reg_data, 0)? };
+            let device = reg.device().into();
+
+            let driver = try_pin_init!(TyrPlatformDriverData {
+                // SAFETY: `ResetHandle` is stored in platform driver data and is
+                // dropped before the borrowed device and MMIO references expire.
+                _reset <- unsafe { reset::ResetHandle::new(pdev, hw)? },
+                _reg: reg,
+                _device: device,
+                _: {
+                    // We need this to be dev_info!() because dev_dbg!() does not work at
+                    // all in Rust for now, and we need to see whether probe succeeded.
+                    dev_info!(pdev, "Tyr initialized correctly.\n");
+                },
+            });
+
+            Ok(driver)
+        })
     }
 }
 

-- 
2.51.2
