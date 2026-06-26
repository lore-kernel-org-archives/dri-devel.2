Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD86C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AE7510F6F1;
	Fri, 26 Jun 2026 18:37:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NsWIRQpF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91D4D10F6F1
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 18:37:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 153D160A5C;
 Fri, 26 Jun 2026 18:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8EC1F000E9;
 Fri, 26 Jun 2026 18:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782499021;
 bh=OucBYBkRxDTmORV5wKRKnI3Arj/SWZDC4DcjOFwYK78=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NsWIRQpFAtq9jd1nP6FRJPyXaa6z5ho/a5RVcC+fGpZC0NtesuFeajEI4sOLn6x1z
 Zo8VMH5qXG0trUI7wOX69VP7bJLv/vQntzTS7B1W81rquKREUh011F4tX3l+H8M5bH
 6qB7ItTL4ikQma2kXmiGi50M/jZOkXnDIFZtnDarKaSTU1Gzmyo0z85cltIWG06UzC
 Fm8xqI1YwKl0CeO+m62sDo9RAr4XZsGPKKE7QJUoVNjGwZK55Ts3LE1Oj40tn5Lx8p
 Uld3ZwRCKvr7/WM5DpUoAkBW9+HbURQHP1wDWviXB7C5nrVcfAS3hbhBfsrCg2tu4B
 xUKZW1OULpGAQ==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, acourbot@nvidia.com,
 ecourtney@nvidia.com, m.wilczynski@samsung.com, david.m.ertman@intel.com,
 ira.weiny@intel.com, leon@kernel.org, daniel.almeida@collabora.com,
 bhelgaas@google.com, kwilczynski@kernel.org
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v4 4/7] rust: auxiliary: sample: demonstrate ForLt with
 invariant Mutex type
Date: Fri, 26 Jun 2026 20:36:11 +0200
Message-ID: <20260626183630.2585057-5-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626183630.2585057-1-dakr@kernel.org>
References: <20260626183630.2585057-1-dakr@kernel.org>
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

Extend the auxiliary driver sample to demonstrate both access patterns:

  - registration_data() with CovariantForLt!(Data<'_>) for the covariant
    data type that holds a plain &'bound reference.

  - registration_data_with() with ForLt!(MutexData<'_>) for an invariant
    data type that wraps a Mutex<&'bound Device>. Since Mutex<T> is
    invariant over T, MutexData cannot implement CovariantForLt and must
    use the closure-based accessor.

Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_driver_auxiliary.rs | 94 +++++++++++++++++++--------
 1 file changed, 68 insertions(+), 26 deletions(-)

diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 92ee6a6d348e..e441ae81fa2c 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -11,14 +11,21 @@
         Core, //
     },
     driver,
+    new_mutex,
     pci,
     prelude::*,
-    types::CovariantForLt,
+    sync::Mutex,
+    types::{
+        CovariantForLt,
+        ForLt, //
+    },
     InPlaceModule, //
 };
 
 const MODULE_NAME: &CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
 const AUXILIARY_NAME: &CStr = c"auxiliary";
+const COVARIANT_DEV_ID: u32 = 0;
+const INVARIANT_DEV_ID: u32 = 1;
 
 struct AuxiliaryDriver;
 
@@ -56,12 +63,26 @@ struct Data<'bound> {
     parent: &'bound pci::Device<Bound>,
 }
 
+/// Registration data with interior mutability.
+///
+/// `Mutex<&'bound T>` is invariant over `'bound`, so this type cannot implement
+/// [`CovariantForLt`](trait@CovariantForLt). Access must go through the closure-based
+/// [`auxiliary::Device::registration_data_with()`].
+#[pin_data]
+struct MutexData<'bound> {
+    #[pin]
+    parent: Mutex<&'bound pci::Device<Bound>>,
+    index: u32,
+}
+
 struct ParentDriver;
 
 #[allow(clippy::type_complexity)]
+#[pin_data]
 struct ParentData<'bound> {
     _reg0: auxiliary::Registration<'bound, CovariantForLt!(Data<'_>)>,
-    _reg1: auxiliary::Registration<'bound, CovariantForLt!(Data<'_>)>,
+    #[pin]
+    _reg1: auxiliary::Registration<'bound, ForLt!(MutexData<'_>)>,
 }
 
 kernel::pci_device_table!(
@@ -81,17 +102,17 @@ fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
         _info: &'bound Self::IdInfo,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
-        Ok(ParentData {
+        try_pin_init!(ParentData {
             // SAFETY: `ParentData` is the driver's private data, which is dropped when the
             // device is unbound; i.e. `mem::forget()` is never called on it.
             _reg0: unsafe {
                 auxiliary::Registration::new_with_lt(
                     pdev.as_ref(),
                     AUXILIARY_NAME,
-                    0,
+                    COVARIANT_DEV_ID,
                     MODULE_NAME,
                     Data {
-                        index: 0,
+                        index: COVARIANT_DEV_ID,
                         parent: pdev,
                     },
                 )?
@@ -101,12 +122,16 @@ fn probe<'bound>(
                 auxiliary::Registration::new_with_lt(
                     pdev.as_ref(),
                     AUXILIARY_NAME,
-                    1,
+                    INVARIANT_DEV_ID,
                     MODULE_NAME,
-                    Data {
-                        index: 1,
-                        parent: pdev,
-                    },
+                    pin_init!(MutexData {
+                        parent <- {
+                            let pdev: &pci::Device<Bound> = pdev;
+
+                            new_mutex!(pdev)
+                        },
+                        index: INVARIANT_DEV_ID,
+                    }),
                 )?
             },
         })
@@ -115,22 +140,39 @@ fn probe<'bound>(
 
 impl ParentDriver {
     fn connect(adev: &auxiliary::Device<Bound>) -> Result {
-        let data = adev.registration_data::<CovariantForLt!(Data<'_>)>()?;
-        let pdev = data.parent;
-
-        dev_info!(
-            pdev,
-            "Connect auxiliary {} with parent: VendorID={}, DeviceID={:#x}\n",
-            adev.id(),
-            pdev.vendor_id(),
-            pdev.device_id()
-        );
-
-        dev_info!(
-            pdev,
-            "Connected to auxiliary device with index {}.\n",
-            data.index
-        );
+        match adev.id() {
+            // CovariantForLt types can use the direct-reference accessor.
+            COVARIANT_DEV_ID => {
+                let data = adev.registration_data::<CovariantForLt!(Data<'_>)>()?;
+                let pdev = data.parent;
+
+                dev_info!(
+                    pdev,
+                    "Connect auxiliary {} with parent: VendorID={}, DeviceID={:#x}\n",
+                    adev.id(),
+                    pdev.vendor_id(),
+                    pdev.device_id()
+                );
+
+                dev_info!(
+                    pdev,
+                    "Connected to auxiliary device with index {}.\n",
+                    data.index
+                );
+            }
+            // Invariant ForLt types (e.g. containing a Mutex) require the closure-based accessor.
+            INVARIANT_DEV_ID => {
+                adev.registration_data_with::<ForLt!(MutexData<'_>), _>(|data| {
+                    let pdev = *data.parent.lock();
+                    dev_info!(
+                        pdev,
+                        "Connected to auxiliary device with index {} (via Mutex).\n",
+                        data.index
+                    );
+                })?;
+            }
+            _ => return Err(EINVAL),
+        }
 
         Ok(())
     }
-- 
2.54.0

