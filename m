Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991D4FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 19:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 048DB10E367;
	Tue, 28 Apr 2026 19:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="hCZxDNNN";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFC3910E364
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 19:19:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777403981; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dGp9LiGwOtchhpSP/OnxzEFL/uYpOYTVkFh+A7RRImR8DvKkMB/oN1RXXmvTTFBs7k+BYGbLqjgOneHN/dzctBd0dEZlGJX1VtFwLAVbp9zu8pQ92Xo8J+DuRsy8vefWX55E4nwYRqmedQV/9HxT9fH0pzxbZ+uET3rT77xRzos=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777403981;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pta7rQUsKJLFtag3990jQEAgOYeNAUEXuJSZ560zJmg=; 
 b=jOINHIbuJHFccykiT5cIjVpEH9ex4CMNsAvR7YXxZtG/UUIKuRYxLYpFFBpKpfNZjn1P+LDoO7flFxOyq3hQ58tl34nKO8VMgy+f92PyfFZm2drHl7YYg27D6ef+HnqSTGYQHXbOMpo3NqE2fohTjPYOecO4ewv+qt6YMSdSwN8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777403981; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=pta7rQUsKJLFtag3990jQEAgOYeNAUEXuJSZ560zJmg=;
 b=hCZxDNNNXnb3g29VROxyomRqAw02MNa7QWzGonxlnyIReOpB1hKsBoxuWuGyCP9n
 xguys2WNBpGuFm/lScXfq/NnEX94HXZELybLpSPN5CQVrwsP2KAsYLn6rT+0tZCwM6t
 dcHwPAffVOT/VxgpM3c7aC2Et1huNv5HciVUaZfA=
Received: by mx.zohomail.com with SMTPS id 177740398101057.39194490898353;
 Tue, 28 Apr 2026 12:19:41 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Tue, 28 Apr 2026 12:19:31 -0700
Subject: [PATCH 4/5] drm/tyr: set DMA mask using GPU physical address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-fw-boot-prerequisites-v1-4-c69af9abe1af@collabora.com>
References: <20260428-fw-boot-prerequisites-v1-0-c69af9abe1af@collabora.com>
In-Reply-To: <20260428-fw-boot-prerequisites-v1-0-c69af9abe1af@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1681;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=G2uA6uMAoMkNqcilH/Un/4YRA4TPOwE/AUmWdl1k7z0=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJkfOdyd5nYlcSgd9b+xzcvBVun411ZTNf/ktIdtXpXdB
 emezTIdpSwMYlwMsmKKLGftjXrEq94b6c7/3wwzh5UJZAgDF6cATOSTKMN/l3vxSSk/DkS7vt7B
 /2zvHO91/Wlpjyq7uF0+GD2sEsw7z8iwn6Gco6wuRfFZez/vVLlT5bf+tT6SZN6l6LevaMHXuFw
 +AA==
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
index cdb9b13bdb32..e20a5978eed6 100644
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
     drm::ioctl,
     io::{
@@ -124,6 +128,14 @@ fn probe(
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
         let platform: ARef<platform::Device> = pdev.into();
 
         let data = try_pin_init!(TyrDrmDeviceData {

-- 
2.53.0

