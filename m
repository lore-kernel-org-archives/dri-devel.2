Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1274CFF8870
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 22:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D60A10E96B;
	Mon, 27 Apr 2026 22:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B0DI94d2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8326D10E96B
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 22:12:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CA1FB60052;
 Mon, 27 Apr 2026 22:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F904C19425;
 Mon, 27 Apr 2026 22:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777327934;
 bh=ju+F7o8Yl0nyozmN8SThTNujs1B0GOs/rWyZh4FMitg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B0DI94d2eRFKDr3/VwZbkkFsvz36IGsGDJhc8SmdCK5Z5cARqCTNNFlEfE9EwcpKg
 IqSQS7X0la8Qy4Uu9wC5Z47YmGqMDrIdAB6CIl7Kk2CYVGhaghWLzWUiChXNp6wGK3
 sGHygogvD8WI7CopuAM5NyRz9NXzAEZ2ipxldU+Ssx0W/HgaH3OWWeAc2NDKawW9FY
 NY9+I9h8GlXTG1y/UVjx2uovH8iyQ0xKNgmXJQmPg844taSQlRztSkbNfwkrxs9aY1
 IyaoJNYxpsYna35Tk2JTSso2ezu9t73QM1O73Zhb6F2DLvze3BSEujdZ+SjyNc+Zjd
 7nyxZcE1D64lQ==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 01/24] rust: driver core: drop drvdata before devres release
Date: Tue, 28 Apr 2026 00:10:59 +0200
Message-ID: <20260427221155.2144848-2-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427221155.2144848-1-dakr@kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
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

Move the post_unbind_rust callback before devres_release_all() in
device_unbind_cleanup().

With drvdata() removed, the driver's bus device private data is only
accessible by the owning driver itself. It is hence safe to drop the
driver's bus device private data before devres actions are released.

This reordering is the key enabler for Higher-Ranked Lifetime Types
(HRT) in Rust device drivers -- it allows driver structs to hold direct
references to devres-managed resources, because the bus device private
data (and with it all such references) is guaranteed to be dropped while
the underlying devres resources are still alive.

Without this change, devres resources would be freed first, leaving the
driver's bus device private data with dangling references during its
destructor.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/base/dd.c             | 2 +-
 include/linux/device/driver.h | 4 ++--
 rust/kernel/driver.rs         | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 5799a60fd058..be59d2e13a15 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -593,9 +593,9 @@ static DEVICE_ATTR_RW(state_synced);
 
 static void device_unbind_cleanup(struct device *dev)
 {
-	devres_release_all(dev);
 	if (dev->driver->p_cb.post_unbind_rust)
 		dev->driver->p_cb.post_unbind_rust(dev);
+	devres_release_all(dev);
 	arch_teardown_dma_ops(dev);
 	kfree(dev->dma_range_map);
 	dev->dma_range_map = NULL;
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index bbc67ec513ed..38e9a4679447 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -123,8 +123,8 @@ struct device_driver {
 	struct driver_private *p;
 	struct {
 		/*
-		 * Called after remove() and after all devres entries have been
-		 * processed. This is a Rust only callback.
+		 * Called after remove() but before devres entries are released.
+		 * This is a Rust only callback.
 		 */
 		void (*post_unbind_rust)(struct device *dev);
 	} p_cb;
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 36de8098754d..8f0e50729215 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -189,8 +189,8 @@ extern "C" fn post_unbind_callback(dev: *mut bindings::device) {
         // INVARIANT: `dev` is valid for the duration of the `post_unbind_callback()`.
         let dev = unsafe { &*dev.cast::<device::Device<device::CoreInternal>>() };
 
-        // `remove()` and all devres callbacks have been completed at this point, hence drop the
-        // driver's device private data.
+        // `remove()` has been completed at this point; devres resources are still valid and will
+        // be released after the driver's bus device private data is dropped.
         //
         // SAFETY: By the safety requirements of the `Driver` trait, `T::DriverData` is the
         // driver's device private data type.
-- 
2.54.0

