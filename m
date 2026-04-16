Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F57F8D761
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 17:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C9B710E90C;
	Thu, 16 Apr 2026 17:17:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="DYhGdGfP";
	dkim-atps=neutral
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B538D10E90C
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 17:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1776359854; x=1776619054;
 bh=kKkf/oVUaWX/TtBj3YjWMsOXTLOwLzh0/60F3Yx6pE8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=DYhGdGfPAhtnr7lPY5hhM8A9hKJeoqe5+NEamYNoyB/1EfTE4jloxQyVIBBI7pUSY
 M8uerP2o8emFGFhCUQMpjW/yQf6BGD7H9BFEoRh1Rxm5Qd1GhqZKzzJ3VxxVe3azse
 efKyT17mVoPIg6qvdiBFQbxis5gSYzx6X2Ft8YbAf7fG7Cx6GBPl+9VrJwx9uhdCzg
 xmLg7LqXuFcQWg9lO380aUQ98onXVbIxvvtpUPPzCJIU9JG/Y9my+773usWybyufYX
 OBb4+YNAPEZ+IK6nufIwms1Vzj7DUlkS7XYOzSpuWYYWII3NPf34CWSf2BydExiTU9
 KX2v5/kc9VIUw==
X-Pm-Submission-Id: 4fxPpN1zmzz1DDrS
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Cc: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v2 3/4] rust: add Work::disable_sync
Date: Thu, 16 Apr 2026 20:17:27 +0300
Message-ID: <20260416171728.205141-2-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260416171728.205141-1-work@onurozkan.dev>
References: <20260416171728.205141-1-work@onurozkan.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Adds Work::disable_sync() as a safe wrapper for disable_work_sync().

Drivers can use this during teardown to stop new queueing and wait for
queued or running work to finish before dropping related resources.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/workqueue/mod.rs | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/rust/kernel/workqueue/mod.rs b/rust/kernel/workqueue/mod.rs
index e30c21214a81..7f63d778146e 100644
--- a/rust/kernel/workqueue/mod.rs
+++ b/rust/kernel/workqueue/mod.rs
@@ -582,6 +582,21 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
         // the compiler does not complain that the `work` field is unused.
         unsafe { Opaque::cast_into(core::ptr::addr_of!((*ptr).work)) }
     }
+
+    /// Disables this work item and waits for queued/running executions to finish.
+    ///
+    /// # Note
+    ///
+    /// Should be called from a sleepable context if the work was last queued on a non-BH
+    /// workqueue.
+    #[inline]
+    pub fn disable_sync(&self) {
+        let ptr: *const Self = self;
+        // SAFETY: `self` points to a valid initialized work.
+        let raw_work = unsafe { Self::raw_get(ptr) };
+        // SAFETY: `raw_work` is a valid embedded `work_struct`.
+        unsafe { bindings::disable_work_sync(raw_work) };
+    }
 }
 
 /// Declares that a type contains a [`Work<T, ID>`].
-- 
2.51.2

