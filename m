Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFA5606A68E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uj5TMHqs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51FBC112726;
	Thu, 26 Nov 2026 21:37:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5F8E11271C
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 21:37:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A73C5457A0;
 Thu, 26 Nov 2026 21:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA541F0089A;
 Thu, 26 Nov 2026 21:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795729026;
 bh=rwOYEx5SMPYe+yxYxJh2Q26j0qxVbpiATxANscWXb7w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Uj5TMHqs/3sD1DLEEP87oOfnOQNhvX62NoXvDTL32G0RD4gvMc86xmUD0GivkTk2S
 HiiL/QBnmxt/cyGSuvRY5AOW+UUmxJTuxC8Pp2AdSUSwTO97wcBFd6bYknUFBqqzJC
 i5vrngrZopDlyN74WY6QO1IRfFQUjaYmR3kfdjECiKklnSj9RXJ69sE5J2MKpE1m0r
 nFjFSiQ88qc9/jop1AfN1P5J95jYR7dvnL5X8X1MxQgxoMGvjZ7MhEpMzDOLhemOsl
 9e2rcyF9K5C0P0g5bEv1S5wR/MeLeVtsHdjQleCcbTNcKeYm6jo2X3WNinX7PyEwzj
 gX5W8pSkA4gEA==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 airlied@gmail.com, simona@ffwll.ch, lossin@kernel.org, gary@garyguo.net,
 ecourtney@nvidia.com, jhubbard@nvidia.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] gpu: nova-core: mm: initialize GpuMm in place
Date: Thu, 26 Nov 2026 22:36:04 +0100
Message-ID: <20261126213652.3716162-4-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126213652.3716162-1-dakr@kernel.org>
References: <20261126213652.3716162-1-dakr@kernel.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PRAMIN and TLB managers require stable addresses for their mutexes.

Pin-initialize GpuMm so they can be embedded directly instead of
allocating each separately.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/gpu.rs |  5 +++--
 drivers/gpu/nova-core/mm.rs  | 20 ++++++++++----------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 39e57e724a71..2f0399100885 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -399,6 +399,7 @@ pub(crate) struct Gpu<'gpu> {
     ///
     /// Must be kept declared *before* `gsp_resources`, so that its components are dropped while
     /// the GSP is still operational.
+    #[pin]
     mm: GpuMm<'gpu>,
     /// BAR1 user interface for CPU access to GPU virtual memory.
     #[pin]
@@ -562,7 +563,7 @@ pub(crate) fn new<'a>(
             },
 
             // Create GPU memory manager owning memory management resources.
-            mm: {
+            mm <- {
                 let usable_vram = gsp_static_info.usable_fb_regions.first().ok_or(ENODEV)?;
                 let buddy_params = GpuBuddyParams {
                     base_offset: usable_vram.start,
@@ -575,7 +576,7 @@ pub(crate) fn new<'a>(
                     gsp_resources.spec.chipset,
                     buddy_params,
                     VramAddress::from_raw(gsp_static_info.total_fb_end),
-                )?
+                )
             },
 
             // Create BAR1 user interface for CPU access to GPU virtual memory.
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 30a394424e12..94c6f425c867 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -74,10 +74,13 @@ macro_rules! impl_pfn_bounded {
 /// - [`GpuBuddy`] allocator for VRAM page table allocation.
 /// - [`pramin::SharedPramin`] for direct VRAM access.
 /// - [`Tlb`] manager for translation buffer flush operations.
+#[pin_data]
 pub(crate) struct GpuMm<'gpu> {
     buddy: GpuBuddy,
-    pramin: Pin<KBox<pramin::SharedPramin<'gpu>>>,
-    tlb: Pin<KBox<Tlb<'gpu>>>,
+    #[pin]
+    pramin: pramin::SharedPramin<'gpu>,
+    #[pin]
+    tlb: Tlb<'gpu>,
 }
 
 impl<'gpu> GpuMm<'gpu> {
@@ -87,18 +90,15 @@ pub(crate) fn new(
         chipset: Chipset,
         buddy_params: GpuBuddyParams,
         total_fb_end: VramAddress,
-    ) -> Result<Self> {
+    ) -> impl PinInit<Self, Error> {
         // PRAMIN covers all physical VRAM (including GSP-reserved areas
         // above the usable region, e.g. the BAR1 page directory).
         let vram_region = VramAddress::ZERO..total_fb_end;
 
-        Ok(Self {
+        try_pin_init!(Self {
             buddy: GpuBuddy::new(buddy_params)?,
-            pramin: KBox::pin_init(
-                pramin::SharedPramin::new(bar, chipset, vram_region),
-                GFP_KERNEL,
-            )?,
-            tlb: KBox::pin_init(Tlb::new(bar), GFP_KERNEL)?,
+            pramin <- pramin::SharedPramin::new(bar, chipset, vram_region),
+            tlb <- Tlb::new(bar),
         })
     }
 
@@ -116,7 +116,7 @@ fn with_pramin_locked<R>(&self, f: impl FnOnce(&mut pramin::Pramin<'_>) -> R) ->
 
     /// Access the [`Tlb`] manager.
     pub(crate) fn tlb(&self) -> &Tlb<'gpu> {
-        self.tlb.as_ref().get_ref()
+        &self.tlb
     }
 }
 
-- 
2.56.1

