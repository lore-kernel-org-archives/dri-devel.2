Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5DDCD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 23:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D33410F2BB;
	Thu,  7 May 2026 23:32:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="SlTS1dl0";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B00D610F2BB
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 23:32:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778196771; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HlwKowPEyLHd8XTqzn2Hra/vycEJm3d0epn4K8NOHKiAdnoMdKNvPSEF4IMj+dqpad7BeOxB3OSbfT4DEVgIoxNuw3C0e+VstWpMYiUzsEXPYuGiP1fWTxtX5FuUAVOomdNsynFuEJpjDZ+st2eBAoj6OY81SHMlV3Jkv0JuTN0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778196771;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Eikidck90nifjjcTLSu0Ily0Cr9WozMvVmtwFlS/XfE=; 
 b=NgIiyDRryLQjjXpGsy8XWIGG4d+uW1DlhVYwmYDbJKhTKrAgsQK5S5aWvdXZvFW1H1H2CIRVB/G2NqGlm8YEJNTN6oT3KrppejwLt/TWVTPeNLQZPd5jYgTYKDs3eWlBtLFMqOKLF82N44R2XQbaxkxcfP7LcD5h9very+ljirs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778196771; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=Eikidck90nifjjcTLSu0Ily0Cr9WozMvVmtwFlS/XfE=;
 b=SlTS1dl05j3VDQXRC0dQlJ3v3q8pddW2B0URrmT4bZa72U0lsJs8szbTm/VVsEzW
 0DkByIiOuO+a1Wlppa9N0KPx52vVVM1Ly0/gABMuBUcsOYjwGQUxJLyhNBCzrR3CkdA
 RC+RmBKx3W72DHZyHLVWG/OoS1jCYK3Zkg1IXk+s=
Received: by mx.zohomail.com with SMTPS id 1778196769009768.4916995530741;
 Thu, 7 May 2026 16:32:49 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Thu, 07 May 2026 16:32:43 -0700
Subject: [PATCH 5/7] drm/tyr: add USER register page definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-tyr-mmap-v1-5-eec048a23c25@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=scNdSVkRh8cTxN+OO32Yl1fQfHmpAP8i/Mt1ByfYJjw=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJl/FSXjfMxb9z/6d2NBs+UVUTklqaXL3uzsSPx0cdqc2
 d3zXgat7yhlYRDjYpAVU2Q5a2/UI1713kh3/v9mmDmsTCBDGLg4BWAiE+cw/Pc/Eu/an8fzc0qY
 uNJVsc+TNx4SfG7Mtf8tn4y7dN1F+TJGhkYJfV1RjVkvr1lZvjkwSzUh0Hu7ueedcDEjs6gPX5l
 cmAE=
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

Add the USER register page definition and the LATEST_FLUSH register used
to track GPU cache flush completion.

The USER register page is read-only and user-accessible. Tyr will use
these definitions to support the Panthor userspace-MMIO mmap interface,
which exposes the flush tracking register directly to userspace.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/regs.rs | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 562023e5df2f..98d5625f5bb1 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -1633,6 +1633,24 @@ fn from(sh: PtwShareability) -> Self {
     }
 }
 
+/// This register corresponds to the USER register page.
+///
+/// This register page is read-only and user-mode accessible.
+/// It exposes cache flush tracking to userspace.
+pub(crate) mod user {
+    use kernel::register;
+
+    register! {
+        /// Latest flush ID register. Read-only.
+        pub(crate) LATEST_FLUSH(u32) @ 0x10000 {
+            /// Incremented when a full GPU cache clean-and-invalidate completes.
+            23:0    flush_id;
+            /// Indicates that a cache flush operation is currently pending.
+            31:31   active => bool;
+        }
+    }
+}
+
 /// This module corresponds to the DOORBELL_BLOCK_n[0-63] register pages.
 pub(crate) mod doorbell_block {
     use kernel::register;

-- 
2.53.0

