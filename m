Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786BFC982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 23:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B440610E4C5;
	Tue, 22 Sep 2026 23:16:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="Yx3HZM8y";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C86EE10EEB2
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 23:16:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790118974; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=n1llWulrYEIajR7IuM3qosDEMUQeCV7BGxsVK8gaFOxPkUo4f4mKqEigC4ADV/XB+cmpOaYSRtRTLKv2wcLzor9v/WgH63c1uZEuTz0ZqdP1ajiTc1m2P5B+PZA4sQypflJBm4qreuMRn8Jz+Ele9r05Tu3enAhS8CQ3kl6JoAk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790118974;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=vhoc42pCqHiQewv5L6Ecg/vqH9ZIuVDppghiEGTI8KU=; 
 b=BYhCsoHVolXDo4zaX3NgCuFJ/iqllm2gj4NlEwopI985mTq7mYlLS3L4wt4EBF0wx63tDsbO2O7jcfwKYZ5aE1pMYw+ND6MlWy9JSM4O3+93iaIJblqptpskfxyrq06m8WvSbqKxgd+c7/e/pVzfYsbvSuB/4O0DTYrVu4U0zXQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790118974; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=vhoc42pCqHiQewv5L6Ecg/vqH9ZIuVDppghiEGTI8KU=;
 b=Yx3HZM8yUTKZo4pSaZayKXxhsC15q2csGUKJLRsAg5sIS4ns3HtCZOp9rrRsB8X1
 +rln+LaGk+cRQY8AUz6XBbZ+NqryQe9hYkygCGfPVNylV4QZMLpN/0hC0B/+EIBisHn
 W6uul6ZX4EcHApBkAntY9vaY5/rSEvz8N+K/cgTA=
Received: by smtp.zohomail.com with SMTPS id 1790118972361369.87324403281946; 
 Tue, 22 Sep 2026 16:16:12 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Tue, 22 Sep 2026 16:16:08 -0700
Subject: [PATCH] drm/tyr: gpu_info: zero out new/unused fields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b4-gpu_info_zero-v1-1-7259840069c6@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAIBRG4a3EHSeUhGVbiYgev3YnGkoRhXtPG
 n6Dc16KCIxIffFSwMWRvcuoy4LWfXYWgrdskpVUlZZSLI2wxzmxM356ELww7QoFKD13mnJ2BBi
 +/+UwpvQBobu/imIAAAA=
X-Change-ID: 20260922-b4-gpu_info_zero-f7ce6ee69a89
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, karunika.choo@arm.com, 
 boris.brezillon@collabora.com, laura.nao@collabora.com, 
 steven.price@arm.com, liviu.dudau@arm.com, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=rA7Q97uhEejy46pnz3jpCfb75C7irewmrdSSzlhAAzo=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFmbeay3hOy4bM72xm6W/M93Dww8W4vmiaQlCUxk536nb
 7pNqoe9o5SFQYyLQVZMkeWsvVGPeNV7I935/5th5rAygQxh4OIUgIncr2P4p6yzQtwpTd0sZvbD
 xv0pRzrfR5gfK1n25vLc1A9qx129cxn+GYTsYJH3fM3i+jxdwHimmXPqr4Oxt0739uq9NZ2WMtG
 fEQA=
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

If a new field is added to the struct drm_panthor_gpu_info in the panthor
uapi, Tyr must initialize this field or it will cause a compile error.

To pre-emptively avoid compile errors, use ..pin_init::zeroed() to zero
out all new fields added to this struct. Tyr can subsequently change the
initialization as necessary. Also use it instead of manually zeroing out
existing fields at the end of the struct.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/gpu.rs | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
index 592b8bb16eba..e1b04a0c5159 100644
--- a/drivers/gpu/drm/tyr/gpu.rs
+++ b/drivers/gpu/drm/tyr/gpu.rs
@@ -74,10 +74,8 @@ pub(crate) fn new(io: &IoMem<'_>) -> Self {
                 io.read(TILER_PRESENT_HI).into_raw(),
             ),
             core_features: io.read(CORE_FEATURES).into_raw(),
-            // Padding must be zero.
-            pad: 0,
-            //GPU_FEATURES register is not available; it was introduced in arch 11.x.
-            gpu_features: 0,
+            // Zero unsupported and newly added UAPI fields.
+            ..pin_init::zeroed()
         })
     }
 

---
base-commit: e1a9f41b896f0d57eb1165dd8a4c7446be6af638
change-id: 20260922-b4-gpu_info_zero-f7ce6ee69a89

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

