Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73424CD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 21:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D749210EED5;
	Wed,  6 May 2026 21:54:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c7xsYTEE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5807010EED5
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 21:54:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D12696024D;
 Wed,  6 May 2026 21:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212AAC2BCB0;
 Wed,  6 May 2026 21:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778104443;
 bh=ehe2nY6HcH6JtRvtBxvkGvdAIzSzQ7wCS3Ek50X1INE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=c7xsYTEE7d1id01Jb752U8+IgHd50N19/BGVX0reUOcFzLeDHNo4ZO/YSkUZLsKji
 FjsIaU9q1pgzRMnxSFWO2kJRh9gcjJwqjDVzzNTB0oc2vFQnM9de07nvlwNX5fNyIF
 5lMqoCwIgxJyjJest+36C1lDqa/0kbPY/cberHsa3UyI/jt62WNnLrEFvlU6y4evN4
 mHQoqUbmOw7Kgf5tYGCmgSnSvyJlWJTPMqwQLxwFwKj8dPW6xx71WuRrOnQEzJSerU
 GbVjmmYJXgXQbJEeHz0RRtUYsRb9dFC27IWnElrIewo19aHlpNzfGi6rNpuoY71cyZ
 FB7pSrAGDZG8w==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 24/25] gpu: nova-core: replace ARef<Device> with &'bound
 Device in SysmemFlush
Date: Wed,  6 May 2026 23:51:00 +0200
Message-ID: <20260506215113.851360-25-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506215113.851360-1-dakr@kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
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

Now that SysmemFlush is lifetime-parameterized, the ARef<Device> is
unnecessary -- a plain &'bound Device reference suffices.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/fb.rs | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index a707fbfe3ced..e22dec12ae7e 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -15,8 +15,7 @@
         Alignable,
         Alignment, //
     },
-    sizes::*,
-    sync::aref::ARef, //
+    sizes::*, //
 };
 
 use crate::{
@@ -49,7 +48,7 @@
 pub(crate) struct SysmemFlush<'bound> {
     /// Chipset we are operating on.
     chipset: Chipset,
-    device: ARef<device::Device>,
+    device: &'bound device::Device,
     bar: &'bound Bar0,
     /// Keep the page alive as long as we need it.
     page: CoherentHandle,
@@ -58,7 +57,7 @@ pub(crate) struct SysmemFlush<'bound> {
 impl<'bound> SysmemFlush<'bound> {
     /// Allocate a memory page and register it as the sysmem flush page.
     pub(crate) fn register(
-        dev: &device::Device<device::Bound>,
+        dev: &'bound device::Device<device::Bound>,
         bar: &'bound Bar0,
         chipset: Chipset,
     ) -> Result<Self> {
@@ -68,7 +67,7 @@ pub(crate) fn register(
 
         Ok(Self {
             chipset,
-            device: dev.into(),
+            device: dev,
             bar,
             page,
         })
-- 
2.54.0

