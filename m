Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCCECD4F3C
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 00:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74B7210E641;
	Sun, 17 May 2026 00:04:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q8hgS6Ur";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F173910E63F
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 00:04:07 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 75451600BB;
 Sun, 17 May 2026 00:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FFAC2BCB7;
 Sun, 17 May 2026 00:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778976247;
 bh=of0MbEhw7cKYbmfkTdKZz0ARgZj1SGnPtOq6mxurdos=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q8hgS6UrmBkobZ9Gx9vMiyYNBZM1t975QQn/bSBNFau3UGhl27s71cvHNdAaLgot3
 vfHTiRswyQF32xOgxaDzHrvP8DEy+8FUi+2S+jCE2srHsOl512QrKsVVFhkaAJCAYi
 AwIR3YJCL3q6oTDsRBMM3vanSiQEk6jif8bsF8MhKwScIV5GIKH84BAwDE+yrN7/8V
 qdxoLtfKYCKyILpIxaX6sVs2Jv1MQoVV1iNWERIrfGf/hDj+YXJqkn65id542T5bgf
 IlOSjyzthUkbw4zqDxk25KOnKt0C5XCDezpB/ZMg3oJvIfWf4JsimLcOArVm4sRqDw
 Dcht6cspeZfjA==
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
 Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 18/27] samples: rust: rust_driver_auxiliary: showcase
 lifetime-bound registration data
Date: Sun, 17 May 2026 02:01:06 +0200
Message-ID: <20260517000149.3226762-19-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517000149.3226762-1-dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
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

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_driver_auxiliary.rs | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 7b15a107fed4..84d18bbfafc5 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -52,14 +52,15 @@ fn probe<'bound>(
     }
 }
 
-struct Data {
+struct Data<'bound> {
     index: u32,
+    parent: &'bound pci::Device<Bound>,
 }
 
 #[allow(clippy::type_complexity)]
 struct ParentDriver {
-    _reg0: Devres<auxiliary::Registration<ForLt!(Data)>>,
-    _reg1: Devres<auxiliary::Registration<ForLt!(Data)>>,
+    _reg0: Devres<auxiliary::Registration<ForLt!(Data<'_>)>>,
+    _reg1: Devres<auxiliary::Registration<ForLt!(Data<'_>)>>,
 }
 
 kernel::pci_device_table!(
@@ -85,14 +86,20 @@ fn probe<'bound>(
                 AUXILIARY_NAME,
                 0,
                 MODULE_NAME,
-                Data { index: 0 },
+                Data {
+                    index: 0,
+                    parent: pdev,
+                },
             )?,
             _reg1: auxiliary::Registration::new(
                 pdev.as_ref(),
                 AUXILIARY_NAME,
                 1,
                 MODULE_NAME,
-                Data { index: 1 },
+                Data {
+                    index: 1,
+                    parent: pdev,
+                },
             )?,
         })
     }
@@ -100,13 +107,11 @@ fn probe<'bound>(
 
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
@@ -114,7 +119,7 @@ fn connect(adev: &auxiliary::Device<Bound>) -> Result {
         );
 
         dev_info!(
-            dev,
+            pdev,
             "Connected to auxiliary device with index {}.\n",
             data.index
         );
-- 
2.54.0

