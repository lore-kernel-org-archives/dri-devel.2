Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF70CD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 20:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F9CF10E40D;
	Mon, 25 May 2026 20:32:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E5Z15P9j";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F0C10E40D
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 20:32:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1FB5343C2A;
 Mon, 25 May 2026 20:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269F31F000E9;
 Mon, 25 May 2026 20:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779741144;
 bh=+rPmKZf6uaQzYhVqY2DDZC+3sDd3VtNWS1o0vbSmOWw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=E5Z15P9jRyUCpIVYHnJfOk9/D8atKgXHRLvLuzY1yly8rDaOEcFJr6aenLpt9wHkp
 /w1H2/iDK/CnanATE6FZIVUJjMGIiJaMeujyma+KBb5394RaHkIALs2YfTi5S4eZQZ
 IVmrNIqu0IQYPP5bqkgyH5stRJqYoDMAzQb4A9Jkw2dJoegGPX1CSsF+cCMMZ56PG7
 QR0c7fRMSXTWyNelz2+V3zbiV6ZLXRloDG7wZ48WsDWNiMGDkVK6VBjERevJDCeaeI
 GohDsI7+lvwSPSkn9t8Cud0GrpoCkF8iQUbbZLpfaCFu+vtTFo/qYNVAEJKeNpHz2x
 UHOVDH2VZAwEg==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com,
 pcolberg@redhat.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v5 24/24] samples: rust: rust_driver_auxiliary: showcase
 lifetime-bound registration data
Date: Mon, 25 May 2026 22:21:11 +0200
Message-ID: <20260525202921.124698-25-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525202921.124698-1-dakr@kernel.org>
References: <20260525202921.124698-1-dakr@kernel.org>
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

Make the Data struct lifetime-parameterized, storing a reference to the
parent pci::Device<Bound>. This demonstrates that registration data can
hold device resources tied to the parent driver's lifetime.

In connect(), retrieve the parent PCI device from the registration data
rather than casting through adev.parent().

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_driver_auxiliary.rs | 58 ++++++++++++++++-----------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index e3e811a14110..2c1351040e45 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -51,16 +51,17 @@ fn probe<'bound>(
     }
 }
 
-struct Data {
+struct Data<'bound> {
     index: u32,
+    parent: &'bound pci::Device<Bound>,
 }
 
 struct ParentDriver;
 
 #[allow(clippy::type_complexity)]
 struct ParentData<'bound> {
-    _reg0: auxiliary::Registration<'bound, ForLt!(Data)>,
-    _reg1: auxiliary::Registration<'bound, ForLt!(Data)>,
+    _reg0: auxiliary::Registration<'bound, ForLt!(Data<'_>)>,
+    _reg1: auxiliary::Registration<'bound, ForLt!(Data<'_>)>,
 }
 
 kernel::pci_device_table!(
@@ -81,33 +82,44 @@ fn probe<'bound>(
         _info: &'bound Self::IdInfo,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
         Ok(ParentData {
-            _reg0: auxiliary::Registration::new(
-                pdev.as_ref(),
-                AUXILIARY_NAME,
-                0,
-                MODULE_NAME,
-                Data { index: 0 },
-            )?,
-            _reg1: auxiliary::Registration::new(
-                pdev.as_ref(),
-                AUXILIARY_NAME,
-                1,
-                MODULE_NAME,
-                Data { index: 1 },
-            )?,
+            // SAFETY: `ParentData` is the driver's private data, which is dropped when the
+            // device is unbound; i.e. `mem::forget()` is never called on it.
+            _reg0: unsafe {
+                auxiliary::Registration::new_with_lt(
+                    pdev.as_ref(),
+                    AUXILIARY_NAME,
+                    0,
+                    MODULE_NAME,
+                    Data {
+                        index: 0,
+                        parent: pdev,
+                    },
+                )?
+            },
+            // SAFETY: See `_reg0` above.
+            _reg1: unsafe {
+                auxiliary::Registration::new_with_lt(
+                    pdev.as_ref(),
+                    AUXILIARY_NAME,
+                    1,
+                    MODULE_NAME,
+                    Data {
+                        index: 1,
+                        parent: pdev,
+                    },
+                )?
+            },
         })
     }
 }
 
 impl ParentDriver {
     fn connect(adev: &auxiliary::Device<Bound>) -> Result {
-        let dev = adev.parent();
-        let pdev: &pci::Device<Bound> = dev.try_into()?;
-
-        let data = adev.registration_data::<ForLt!(Data)>()?;
+        let data = adev.registration_data::<ForLt!(Data<'_>)>()?;
+        let pdev = data.parent;
 
         dev_info!(
-            dev,
+            pdev,
             "Connect auxiliary {} with parent: VendorID={}, DeviceID={:#x}\n",
             adev.id(),
             pdev.vendor_id(),
@@ -115,7 +127,7 @@ fn connect(adev: &auxiliary::Device<Bound>) -> Result {
         );
 
         dev_info!(
-            dev,
+            pdev,
             "Connected to auxiliary device with index {}.\n",
             data.index
         );
-- 
2.54.0

