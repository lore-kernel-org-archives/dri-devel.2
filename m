Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D40F532C3
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 00:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 404D310E581;
	Tue, 24 Mar 2026 00:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="KSIEvKaz";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D6E10E505
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 00:18:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774311506; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QUegx6mofNODLPeZ3Ct6Xdgam2hMr5bxrh6saZoHbXSToHy8+YDd9z6RlPSg4gr6mINkSuEbmhvnykJybAdfdVn8qnTVzIiRLO+n/NhsWkK+NpODpjTitYVMDNOqUtG68HUFvRHjKdNvjUMA/XmrQVLyITZwy3b6WYE59bbOCqk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774311506;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4+RgS92/EWoSjpmuwKSsluUf92gmBEDb9YVjt6U5Qro=; 
 b=gdDfmcZTxUaUZQ8N7nrRVmgX8DvmJpYHlUYlOn9WyXVLFZJNE+uV8ELopu+Spx7xm5hC+B1fuA/wRsx+xrUfO/EHCRwJTv39iWdz1xiVQCNwRn2yoaicfPuLE2KBtzGik+68beExHKc5EV0xe7OavLresvgMrd12iRujpxno5kA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774311506; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=4+RgS92/EWoSjpmuwKSsluUf92gmBEDb9YVjt6U5Qro=;
 b=KSIEvKazKDWqWDh/5syaXqiyWx3JPtl8GnwJ+foKouDNKZCUN3zZLeBvvDowFaO8
 GFr2j7OG0N7z08tReX5Cdi40xId87wPgCAv5RWo1WEJrLt09dHbGqd7cZt3anc7R9mA
 qb/WaT7NNqUejVo61G1N8GDSHYrYBGGb7R9WjEyQ=
Received: by mx.zohomail.com with SMTPS id 1774311505084759.9681303949249;
 Mon, 23 Mar 2026 17:18:25 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Mon, 23 Mar 2026 17:18:14 -0700
Subject: [PATCH v3 12/12] drm/tyr: Add DOORBELL_BLOCK registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-b4-tyr-use-register-macro-v3-v3-12-a87daf9e4701@collabora.com>
References: <20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com>
In-Reply-To: <20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com>
To: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 Boqun Feng <boqun@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Steven Price <steven.price@arm.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Dirk Behme <dirk.behme@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 Boqun Feng <boqun@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=TYEdoU1zwslXb0KMnrr0+nLN8KO78Dq9rlOOiegf9ow=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJkHbziYihV2L09cv+pV1pOnYiETNO8HmLsc1bjCFjN9U
 qvOQfamjlIWBjEuBlkxRZaz9kY94lXvjXTn/2+GmcPKBDKEgYtTACYSZ8LwP33bvI++B2QDIw5b
 FLwXr/G451v6Pmuac+3k7x8bI79slmb4H7RVh0nqslP25oBIf9WLe+b5Tz/82HHfi5Z5nrrenHa
 ibAA=
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

DOORBELL_BLOCK_n[0-63] is an array of GPU control register pages.
Each block is memory-mappable and contains a single DOORBELL register
used to trigger actions in the GPU.

Add definitions for the DOORBELL_BLOCK registers using the register! macro
so they can be used by future Tyr interfaces.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/regs.rs | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 7e895b6e7deccc049a0ee3963d511c4b579e5ec7..9c1da1f039ccf9fc118def974d48dd40c17f4305 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -1474,3 +1474,25 @@ fn from(sh: PtwShareability) -> Self {
         }
     }
 }
+
+/// This module corresponds to the DOORBELL_BLOCK_n[0-63] register pages.
+pub(crate) mod doorbell_block {
+    use kernel::register;
+
+    /// Number of doorbells available.
+    pub(crate) const NUM_DOORBELLS: usize = 64;
+
+    /// Doorbell block stride (64KiB).
+    ///
+    /// Each block occupies a full page, allowing it to be mapped
+    /// separately into a virtual address space.
+    const STRIDE: usize = 0x10000;
+
+    register! {
+        /// Doorbell request register. Write-only.
+        pub(crate) DOORBELL(u32)[NUM_DOORBELLS, stride = STRIDE] @ 0x80000 {
+            /// Doorbell set. Writing 1 triggers the doorbell.
+            0:0    ring => bool;
+        }
+    }
+}

-- 
2.52.0

