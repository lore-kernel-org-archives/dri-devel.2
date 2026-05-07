Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0624ECD37A7
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 23:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41E5110F2DB;
	Thu,  7 May 2026 23:33:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="GkgUSVib";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E18910F2BB
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 23:32:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778196771; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FyCnaUAzfM4a/oh4N8AOggjrbsF2bUQSLb/CxAoRu1S+QAH6J1JJ9GYc5nfVcNtLNtAKGIlSnMD5iJmSG6b3WFRbSBhDsugClsggapEt54+wnwTVtoBObsMaPUmBhut4PIJcjIJyMWNkAKxHh0T7bOFvrfTRo7wPIdc9rBvMSzA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778196771;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Yx8JvLQF2DtX5i8OpM+EnULSototWLG5JNcoDKWudLI=; 
 b=OMOgAO7cVfPItTjB9xhEpHkzR1paHTtYyAa6QZ0pZhJJJvfqK7X1Y91TQNDs6XTU7NFMFiYfTqWOl71kc0wTN+TKMXfiKvHyI0zyyMIapkPrrVggwArPcDqFVIQXjQd+Pdp2c5RHFiglEmRGYvwbPO4pQufs4cxsbO2xLxkxwkM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778196771; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Yx8JvLQF2DtX5i8OpM+EnULSototWLG5JNcoDKWudLI=;
 b=GkgUSVibMD711G/3qJz5u1jKCj67ghRtxDc6/G//cT4Lc1dWr+FJAvfZVpdN/xcC
 Y2TvMM1Gh56cEilNzDTW7jxq4twK7cFZJH1LPOmZf4Lm+CSjCS+AdTUbQylo934WhfI
 FHopmkuSWD/kpHo7Z/6Tn08v5ScdKYJPcnMxFLNQ=
Received: by mx.zohomail.com with SMTPS id 1778196770005837.945580734471;
 Thu, 7 May 2026 16:32:50 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Thu, 07 May 2026 16:32:44 -0700
Subject: [PATCH 6/7] drm/tyr: store MMIO physical base address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-tyr-mmap-v1-6-eec048a23c25@collabora.com>
References: <20260507-tyr-mmap-v1-0-eec048a23c25@collabora.com>
In-Reply-To: <20260507-tyr-mmap-v1-0-eec048a23c25@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 boris.brezillon@collabora.com, beata.michalska@arm.com, lyude@redhat.com, 
 acourbot@nvidia.com, work@onurozkan.dev, alvin.sun@linux.dev, 
 Laura Nao <laura.nao@collabora.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1922;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=sq2B5J6Q8s2C6YbTn20oeUOAg0Lb4q68cApUEcd8JXg=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJl/FSUvsz9WfGfwS5Jjx1Zmkz0/XLLjDbkc+TduP+ZuX
 m7UsulWRykLgxgXg6yYIstZe6Me8ar3Rrrz/zfDzGFlAhnCwMUpABNZ5MXIMC93xowtChndQWsN
 e+dY/FieVXkzatv+598ueVtq3/u4ZCrD/zAe/ySGIMPGyVksp+w6WLfffZu8LfwFz7amKXtLy3c
 vZQMA
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

Store the physical base address of the GPU MMIO region in
TyrDrmDeviceData.

This will be used by the Panthor userspace-MMIO mmap path to derive the
physical PFNs inserted into userspace VMAs for USER register page
mappings.

Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index e20a5978eed6..2ba0a22a225b 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -19,7 +19,8 @@
     drm::ioctl,
     io::{
         poll,
-        Io, //
+        Io,
+        PhysAddr, //
     },
     new_mutex,
     of,
@@ -60,6 +61,9 @@ pub(crate) struct TyrPlatformDriverData {
 pub(crate) struct TyrDrmDeviceData {
     pub(crate) pdev: ARef<platform::Device>,
 
+    /// Physical base address of the MMIO region.
+    pub(crate) mmio_phys_addr: PhysAddr,
+
     #[pin]
     clks: Mutex<Clocks>,
 
@@ -119,6 +123,7 @@ fn probe(
         let mali_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"mali")?;
         let sram_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"sram")?;
 
+        let mmio_phys_addr = pdev.resource_by_index(0).ok_or(ENODEV)?.start();
         let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
         let iomem = Arc::pin_init(request.iomap_sized::<SZ_2M>(), GFP_KERNEL)?;
 
@@ -140,6 +145,7 @@ fn probe(
 
         let data = try_pin_init!(TyrDrmDeviceData {
                 pdev: platform.clone(),
+                mmio_phys_addr,
                 clks <- new_mutex!(Clocks {
                     core: core_clk,
                     stacks: stacks_clk,

-- 
2.53.0

