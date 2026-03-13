Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9FF105F781
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 09:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF4310EB5C;
	Fri, 13 Mar 2026 09:17:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="gHaIEutB";
	dkim-atps=neutral
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net
 [178.154.239.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A95D10EB56
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 09:17:55 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:571a:0:640:23e3:0])
 by forward102a.mail.yandex.net (Yandex) with ESMTPS id 2EFB8C00BD;
 Fri, 13 Mar 2026 12:17:53 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id 3HEusrTGkmI0-BP8TrAT5; 
 Fri, 13 Mar 2026 12:17:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=mail; t=1773393472;
 bh=tdqZdIhYVneZTBKoqZpd0WXEPrwKrA6bsUPN0bxfmEQ=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=gHaIEutBFRdy7RkBqeg/y8j/aSGIwNuscD3rYoELHt5ldb05h+76hDxXJTQC/Q5Q6
 5Zjw9znOQCww5bC5jc/oApxZlCEoVxLwNWbBXY5ktMHfH2Rmd4uljXqO4z20Tfngdf
 ccrmyZrW7AgYRDQwy3uVpDCPhNAw5xfploqGEkZo=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net;
 dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH v1 RESEND 3/4] rust: add ordered workqueue wrapper
Date: Fri, 13 Mar 2026 12:16:43 +0300
Message-ID: <20260313091646.16938-4-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260313091646.16938-1-work@onurozkan.dev>
References: <20260313091646.16938-1-work@onurozkan.dev>
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

Add an owned OrderedQueue wrapper for alloc_ordered_workqueue() and
destroy_workqueue().

This gives Rust drivers a simple way to create and own an ordered
workqueue with automatic cleanup in Drop.

Tested-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/helpers/workqueue.c |  6 +++++
 rust/kernel/workqueue.rs | 47 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/rust/helpers/workqueue.c b/rust/helpers/workqueue.c
index ce1c3a5b2150..7cd3b000a5b6 100644
--- a/rust/helpers/workqueue.c
+++ b/rust/helpers/workqueue.c
@@ -14,3 +14,9 @@ __rust_helper void rust_helper_init_work_with_key(struct work_struct *work,
 	INIT_LIST_HEAD(&work->entry);
 	work->func = func;
 }
+
+__rust_helper struct workqueue_struct *
+rust_helper_alloc_ordered_workqueue(const char *name, unsigned int flags)
+{
+	return alloc_ordered_workqueue("%s", flags, name);
+}
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 6acc7b5ba31c..d5aa61a5ef93 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -195,6 +195,7 @@
     types::Opaque,
 };
 use core::marker::PhantomData;
+use core::ptr::NonNull;
 
 /// Creates a [`Work`] initialiser with the given name and a newly-created lock class.
 #[macro_export]
@@ -346,6 +347,52 @@ pub fn try_spawn<T: 'static + Send + FnOnce()>(
     }
 }
 
+/// A kernel work queue that allocates and owns an ordered `workqueue_struct`.
+///
+/// Unlike [`Queue`], [`OrderedQueue`] takes ownership of the underlying C
+/// workqueue and automatically destroys it when dropped.
+pub struct OrderedQueue(NonNull<bindings::workqueue_struct>);
+
+// SAFETY: Workqueue objects are thread-safe to share and use concurrently.
+unsafe impl Send for OrderedQueue {}
+// SAFETY: Workqueue objects are thread-safe to share and use concurrently.
+unsafe impl Sync for OrderedQueue {}
+
+impl OrderedQueue {
+    /// Allocates an ordered workqueue.
+    ///
+    /// It is equivalent to C's `alloc_ordered_workqueue()`.
+    pub fn new(name: &'static CStr, flags: u32) -> Result<Self> {
+        // SAFETY: `name` is a `&'static CStr`, guaranteeing a valid, null-terminated C
+        // string pointer for the duration of this call.
+        let ptr = unsafe { bindings::alloc_ordered_workqueue(name.as_char_ptr(), flags) };
+        let ptr = NonNull::new(ptr).ok_or(ENOMEM)?;
+        Ok(Self(ptr))
+    }
+
+    /// Enqueues a work item.
+    ///
+    /// This may fail if the work item is already enqueued in a workqueue.
+    ///
+    /// The work item will be submitted using `WORK_CPU_UNBOUND`.
+    pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::EnqueueOutput
+    where
+        W: RawWorkItem<ID> + Send + 'static,
+    {
+        // SAFETY: `self.0` is valid while `self` is alive.
+        unsafe { Queue::from_raw(self.0.as_ptr()) }.enqueue(w)
+    }
+}
+
+impl Drop for OrderedQueue {
+    fn drop(&mut self) {
+        // SAFETY:
+        // - Pointer comes from `alloc_ordered_workqueue()` and is owned by `self`.
+        // - `OrderedQueue` does not expose delayed scheduling API.
+        unsafe { bindings::destroy_workqueue(self.0.as_ptr()) };
+    }
+}
+
 /// A helper type used in [`try_spawn`].
 ///
 /// [`try_spawn`]: Queue::try_spawn
-- 
2.51.2

