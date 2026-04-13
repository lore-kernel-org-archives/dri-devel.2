Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E029F531DE
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 600B210E549;
	Mon, 13 Apr 2026 22:32:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="eleT72km";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AAB710E542
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 22:32:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776119519; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WL66qqr/YoqH65wlhh9RThOBuQk8rAxzzgwhY1+RtTzSZQXHlDr3s+yXur13mSwmmsgzYuKXQgEmQX61qvWtSUYdWuCipioRMaA0aY5wx4m8aBFQqRD7esV7KAmryR4itvxOCKR6pgEBuulrQ8DgW+yOyxf2uVQeuUHgeVBTzkc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776119519;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Td95XBU/QVVNPvpNOyHFW9D3+lVJZxs6G6aunCPb574=; 
 b=YmA9IWvNHFLzWS2qvGTNjoix7z2C4gIqqT943u7WWUP6dNnNYiW+rJPtldLbvJzehZxucHWsQYylA9w29MDLNJXoYwJ/lggqdjOOKB8w/4RyE9AMTS+rGNlClRHd/P6NqGLof51FnVKtAcBRlQvx2WlOb3PdXHG4E8sqXEAC7EU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776119519; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Td95XBU/QVVNPvpNOyHFW9D3+lVJZxs6G6aunCPb574=;
 b=eleT72kmB1bxdgQYlfNhl1rZ7ANIagwWPnKbE1pawWu1Nj9X8jbCnkbiIpsqpx+k
 mi6W7SUvgTnWmpkO9bpxiKpYIIgCGC83QyqbfkBuZezTyOxF0oYzinWZ6f1xxo4IFIp
 8hYP1DNPUACBjXiOMR9KR/SoYrpXo4u29mseA6vI=
Received: by mx.zohomail.com with SMTPS id 1776119518776629.4288698832687;
 Mon, 13 Apr 2026 15:31:58 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Mon, 13 Apr 2026 15:31:41 -0700
Subject: [PATCH v3 06/13] drm/tyr: set DMA mask using GPU physical address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-b4-fw-boot-v3-v3-6-b422f3c03885@collabora.com>
References: <20260413-b4-fw-boot-v3-v3-0-b422f3c03885@collabora.com>
In-Reply-To: <20260413-b4-fw-boot-v3-v3-0-b422f3c03885@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com, 
 work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1727;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=K3zABDKgOMYL6fCZDCWZYPbstPK4Q3KaSxiOaydBw08=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJl3867GVWT3zKjjl3/Du6rA77rqrsq0wkW2MiyJLMarg
 9v4Mgs6SlkYxLgYZMUUWc7aG/WIV7030p3/vxlmDisTyBAGLk4BmMiv6YwM7xl6UhL5DHptdC+V
 G8u+L9ggudj3zs1/Mn/PsZ3YvabuBSPDBJaSVWHnvDreKSxV0Vc7LcLHufeAdOaqhb7Tp/Y8/by
 UFQA=
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

From: Beata Michalska <beata.michalska@arm.com>

Configure the device DMA mask during probe using the GPU's physical
address capability reported in GpuInfo. This ensures DMA allocations
use an appropriate address mask.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 26a20e0ab91c..1f09f59e271a 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -11,6 +11,10 @@
         Device, //
     },
     devres::Devres,
+    dma::{
+        Device as DmaDevice,
+        DmaMask, //
+    },
     drm,
     drm::{
         driver::Registration,
@@ -138,6 +142,14 @@ fn probe(
         let gpu_info = GpuInfo::new(pdev.as_ref(), &iomem)?;
         gpu_info.log(pdev.as_ref());
 
+        let pa_bits = MMU_FEATURES::from_raw(gpu_info.mmu_features)
+            .pa_bits()
+            .get();
+        // SAFETY: No concurrent DMA allocations or mappings can be made because
+        // the device is still being probed and therefore isn't being used by
+        // other threads of execution.
+        unsafe { pdev.dma_set_mask_and_coherent(DmaMask::try_new(pa_bits)?)? };
+
         let uninit_ddev = UnregisteredDevice::<TyrDrmDriver>::new(pdev.as_ref())?;
         let platform: ARef<platform::Device> = pdev.into();
 

-- 
2.53.0

