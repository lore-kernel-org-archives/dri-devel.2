Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F26606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 03:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fi9K7iVV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 167CC10E297;
	Mon, 26 Oct 2026 03:50:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A87610E1D5
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 03:50:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F5DE4401F;
 Mon, 26 Oct 2026 03:50:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792986652;
 b=FJOVJKjJfobybKganAutlca0e1pZrkzuGQrf/9ibF4xcZDWSju16sD5/uZxUS6abnAOE
 DxC3Uhhh9UfI4Wkq2ubZPmxW6RTW/ckdx6eG22pRZk/B4mmhlI3z65S1ExjkN9f8JvGZ4
 5WxwSLf9/w2460mE1AcNM9KwaB3shFT2gMPLS+B43b0rNoyJkUEOQWNSBvzdi0HZi7s1A
 +kW6uPX8/VRe7J34X2QXkthQRorzJKODxAs+iuLiEVenL/Ih8IXx5t/hPjQeMPukMS9Dp
 /7nbUsZzeCEJvJs4fXtsiASphlgZd5qKt8W2MADfkPqatOiLP/Fh3aJ0v1RjZQP5/oA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792986652;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Dstu2QTm1JHio+YJD9hJVau24sRsy1SlCffFKN29bM4=;
 b=xT4xndSKthuRuvnIQi4actfzcsf6S5luS0JSWltj1mcDNpsqEltcGgAqyPJ1kLd7N3NI
 qLn0lqK+kyVCS95RMN7RW40oKkGlR31Tur9BG41cYoMshjztggPJnd+l96+iLuYRxq0s7
 qtztqgE/86WTs1P2DRZntrY+fLRZ1+Y7bHVbOwttaTDXbuqbvvkBrtSP//o4nQxEN8rfg
 v5+OgV1+PQj+JnwKy0XWBZ4HLWLJzQhjZux769yeMPL4uBWyAkrDmnFPAafgxsjhdR/Cs
 J1K/uLOnaaCLZiWAK9+M++Fbb2ydqgyXVQ/bNxhLi0V8m/hUFwQpgi53MeyUU6S7g3A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 5DE9C1F031E3;
 Mon, 26 Oct 2026 03:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792986652;
 bh=Dstu2QTm1JHio+YJD9hJVau24sRsy1SlCffFKN29bM4=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=fi9K7iVVvw3j36l8DVntctjhWTdnb1V1Hmp9PYu6SUwPj7yypd6H0GmVzscR0t43S
 NV4m+oApZmG6RyifgSLd3ouHmdaYMMBO7TJvnagIqJ7eqybTcUvbxx3kyv7h0cIIrx
 uDrw2TcjJLhHiqKZboKqpq4qsEHou8bwiE0Zie0kZr7i1DzcCVuS70puq4sFcF+NYS
 iAAE21WtrtpQaYlRtUf0XgCuLhpJDlrUKO/1oNov3n1JTrNOTfz+QQnbfOJlHJ2AIn
 cXuqdEYI+E/lbFP/0lqMPHMnAuEQh99f8sQqTilwyPF1guQwUrLA5B7MEYHiiKwPjf
 eKxjLoo5PkmKA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B13A244BEB;
 Mon, 26 Oct 2026 03:50:46 +0000 (UTC)
From: Dave Airlie via B4 Relay <devnull+airlied.redhat.com@kernel.org>
Date: Mon, 26 Oct 2026 13:50:36 +1000
Subject: [PATCH] gpu: nova-core: make bar1 optional
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261026-nova-bar1-option-v1-1-8b43585881a3@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDINbNyy9L1E1KLDLUzS8oASrWNTEwTzNMM7FMSzFMVgJqKyhKTcusABs
 ZHVtbCwDUigH0YgAAAA==
X-Change-ID: 20261026-nova-bar1-option-407f1f49fd1c
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6274; i=airlied@redhat.com;
 h=from:subject:message-id;
 bh=dnbs8MiQY9p4YqWZ5cbaKv+lRKOcVPL0FWNe0TMwC5o=;
 b=owEBbQKS/ZANAwAKAQx081l5xIa+AcsmYgBq3s4Q/TNd+lWgDL8MspWTCvRZdcoGJ8ZHKMrs0
 8RTzD3Xr4iJAjMEAAEKAB0WIQQQptkdobBb0p9t66wMdPNZecSGvgUCat7OEAAKCRAMdPNZecSG
 vn8XD/9Gu8KXT5NpE4TThSzqSJmeOiOMyIvBslZfD8V6j8z4vsTmwBXNBPSZqEJC0N0Lwx17rp8
 kGevMXV0Lb1UpdDzi5u49puaMFZqT7zVnr93J5/ENpZalhA5snHN5p2CHWl/59y+gzNyYWQv4lU
 AdtqZfOMcoaNxiTmghwws6/vFBI04mjNu+2e/x5YvFBabj01IzDmk/482Hiylw+J5vWw87asemX
 56HpZQMGoRkmned+u0un1g/miCqJ4WeA/IoznfDA5XjyM6jZ6NiYNCh+gP2pCfeHnp47ivBQDfR
 htJD2SPOeX8AWKzz/K3fFGBFdwXWMAqWQuTT06krbu0VHoX7EhQXc6YjJY5G/5GByFO4aUIqXPG
 i0pxAy24p6X7BLKV+Ulv25WLHSj8ncBvavoB0KLBtH6XL1lUgFvvpcb3k3vqxeccbS+UcOpX73J
 TygHuJdgmKHMqPVn/frsyn2cNpMMk2U2zmIbzCEk6IOaZa/UliTp+NTwd0lyEwedpBS/4gCsToQ
 B/IrBChJYNbNqQp3UFO3IYXoW2pLKjoPvUSrVoOGxwQ0EO+iGcbfcQPRul+JKycNl9FcYIPAwvF
 SSI6yc0a0Q6U1bR7MkkO7XYCVcrC8celjW2x49enzU45/Uxr4xoHsYpocxRgnkDgZ1okEYzlmFE
 +o3T09YDUDcMXsQ==
X-Developer-Key: i=airlied@redhat.com; a=openpgp;
 fpr=10A6D91DA1B05BD29F6DEBAC0C74F35979C486BE
X-Endpoint-Received: by B4 Relay for airlied@redhat.com/default with
 auth_id=1321
X-Original-From: Dave Airlie <airlied@redhat.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: airlied@redhat.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Dave Airlie <airlied@redhat.com>

Not all devices have BAR1 so make it optional.

Signed-off-by: Dave Airlie <airlied@redhat.com>
---
 drivers/gpu/nova-core/driver.rs      | 15 ++++++++++++---
 drivers/gpu/nova-core/gpu.rs         | 37 ++++++++++++++++++++----------------
 drivers/gpu/nova-core/mm.rs          |  2 +-
 drivers/gpu/nova-core/mm/bar_user.rs |  7 ++++++-
 4 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 560a70c4f5a7..ccf26008abe8 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -37,7 +37,7 @@ pub(crate) struct NovaCore<'bound> {
     #[pin]
     pub(crate) gpu: Gpu<'bound>,
     bar: pci::Bar<'bound, BAR0_SIZE>,
-    bar1: pci::Bar<'bound>,
+    bar1: Option<pci::Bar<'bound>>,
 }
 
 pub(crate) struct NovaCoreDriver;
@@ -112,7 +112,11 @@ fn probe<'bound>(
 
             bar1: {
                 let bar1_idx = bar1_resource_index(pdev)?;
-                pdev.iomap_region(bar1_idx, c"nova-core/bar1")?
+                if pdev.resource_len(bar1_idx)? == 0 {
+                    None
+                } else {
+                    Some(pdev.iomap_region(bar1_idx, c"nova-core/bar1")?)
+                }
             },
 
             // Run self-tests that do not depend on the `Gpu` instance.
@@ -135,7 +139,12 @@ fn probe<'bound>(
                 // SAFETY: `bar` is initialized above, pinned, and outlives `gpu`.
                 unsafe { &*core::ptr::from_ref(bar) },
                 // SAFETY: `bar1` is initialized above, pinned, and outlives `gpu`.
-                unsafe { &*core::ptr::from_ref(bar1) },
+                unsafe {
+                    match bar1 {
+                        None => None,
+                        Some(bar1) => Some(&*core::ptr::from_ref(bar1)),
+                    }
+                },
             ).pin_chain(|_gpu| {
                 #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
                 _gpu.run_selftests(pdev);
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 4e59072cab50..79018aff37f3 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -394,9 +394,8 @@ pub(crate) struct Gpu<'gpu> {
     /// Must be kept declared *before* `gsp_resources`, so that its components are dropped while
     /// the GSP is still operational.
     mm: GpuMm<'gpu>,
-    /// BAR1 user interface for CPU access to GPU virtual memory.
-    #[pin]
-    bar_user: BarUser<'gpu>,
+    /// BAR1 user interface for CPU access to GPU virtual memory, if the device has BAR1.
+    bar_user: Option<Pin<KBox<BarUser<'gpu>>>>,
     /// GSP and its resources.
     #[pin]
     gsp_resources: GspResources<'gpu>,
@@ -448,7 +447,7 @@ impl<'gpu> Gpu<'gpu> {
     pub(crate) fn new<'a>(
         pdev: &'gpu pci::Device<device::Core<'a>>,
         bar: Bar0<'gpu>,
-        bar1: Bar1<'gpu>,
+        bar1: Option<Bar1<'gpu>>,
     ) -> impl PinInit<Self, Error> + use<'gpu, 'a> {
         let dev = pdev.as_ref();
 
@@ -580,17 +579,23 @@ pub(crate) fn new<'a>(
             },
 
             // Create BAR1 user interface for CPU access to GPU virtual memory.
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
+            bar_user: match bar1 {
+                None => None,
+                Some(bar1) => Some({
+                    let pdb_addr = VramAddress::from_raw(gsp_static_info.bar1_pde_base);
+                    let bar1_idx = crate::driver::bar1_resource_index(pdev)?;
+                    let bar1_size = pdev.resource_len(bar1_idx)?;
+
+                    KBox::pin_init(
+                        BarUser::new(
+                            pdb_addr,
+                            gsp_resources.spec.chipset,
+                            bar1_size,
+                            bar1,
+                        ),
+                        GFP_KERNEL,
+                    )?
+                }),
             },
         })
     }
@@ -623,7 +628,7 @@ pub(crate) fn run_selftests(self: Pin<&mut Self>, pdev: &pci::Device<device::Bou
             dev,
             this.mm,
             regions,
-            &this.bar_user,
+            this.bar_user.as_deref(),
             this.gsp_static_info.bar1_pde_base,
             this.spec.chipset,
         ) {
diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
index 8a934c55169f..557bf76c2f5b 100644
--- a/drivers/gpu/nova-core/mm.rs
+++ b/drivers/gpu/nova-core/mm.rs
@@ -308,7 +308,7 @@ pub(crate) fn run(
         dev: &device::Device<device::Bound>,
         mm: &mut GpuMm<'_>,
         usable_fb_regions: &[Range<u64>],
-        bar_user: &bar_user::BarUser<'_>,
+        bar_user: Option<&bar_user::BarUser<'_>>,
         bar1_pdb: u64,
         chipset: Chipset,
     ) -> Result {
diff --git a/drivers/gpu/nova-core/mm/bar_user.rs b/drivers/gpu/nova-core/mm/bar_user.rs
index 6e9384f06f43..205082df27bc 100644
--- a/drivers/gpu/nova-core/mm/bar_user.rs
+++ b/drivers/gpu/nova-core/mm/bar_user.rs
@@ -184,7 +184,7 @@ fn drop(&mut self) {
 pub(crate) fn run_self_test(
     dev: &device::Device<device::Bound>,
     mm: &mut GpuMm<'_>,
-    bar_user: &BarUser<'_>,
+    bar_user: Option<&BarUser<'_>>,
     bar1_pdb: u64,
     chipset: Chipset,
 ) -> Result {
@@ -202,6 +202,11 @@ pub(crate) fn run_self_test(
         },
     };
 
+    let Some(bar_user) = bar_user else {
+        dev_info!(dev, "MM: Self-test SKIPPED - no BAR1\n");
+        return Ok(());
+    };
+
     // Test patterns.
     const PATTERN_PRAMIN: u32 = 0xDEAD_BEEF;
     const PATTERN_BAR1: u32 = 0xCAFE_BABE;

---
base-commit: 3497a403264b094ebd61b8b755165d56e7d9dc37
change-id: 20261026-nova-bar1-option-407f1f49fd1c

Best regards,
-- 
Dave Airlie <airlied@redhat.com>


