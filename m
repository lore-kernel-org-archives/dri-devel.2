Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9AE606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=UQIShDyz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98EB9112CF7;
	Fri, 27 Nov 2026 18:31:21 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DEFC112CF2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 18:31:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795804255; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=c7M/SE/n2BIQsM7JPTHveyBNcDqOwmKbEUHW61pGKA/fuFS3tt37P1JICwvuX0xl+897Lk1ubzsVimvCcMUO4MINDjvA/2GtNuVoplxiCyk9lBZLBK4g3NucjyOZYvcI+jHe2RDgveagnEhOMC6UL6RUpJaXYCSHyvurfXoMEBk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795804255;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=3z99BsU30U4rERu+ZiV0NBny6Si8flrmsiUiHE4Lweg=; 
 b=M7nU9Tn5KC0qkSGLIRHvmcg08f+RwwV9hb/wLhoA89Nr8TxcuB2n0/lQqTM8jLiHqG2/wdzJNIkUPoAmb3mp+MwjT3eAAiD5JZ+sJ/8KGApqDWiy0xGVRubiKNysPgag6sn06C1pmizggeBx4WMAP0jC5Hm2tiVerqIH7gjKB3E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=UQIShDyzw7L92zIhABO0WxYb2m0Y0sKeHfFOO1XGZ4NiPjCHiQum57w3F5NJXZQQvvbVNzK+FbnwiWmWiwRaVK8/nSI8jOeWWoxVKRHYn2/R8pVwZADZSa3uHbribJiDV9JUsirzzZd/4B3ygKi6mBPagy6f1gsGyu1usELGhqE=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=3z99BsU30U4rERu+ZiV0NBny6Si8flrmsiUiHE4Lweg=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795804253474968.8695268999385;
 Fri, 27 Nov 2026 10:30:53 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Fri, 27 Nov 2026 15:30:37 -0300
Subject: [PATCH 1/2] rust: dma_buf: dma_fence: add SignallingSection
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-dma-fence-signalling-v1-1-c44e8f4910ca@collabora.com>
References: <20261127-dma-fence-signalling-v1-0-c44e8f4910ca@collabora.com>
In-Reply-To: <20261127-dma-fence-signalling-v1-0-c44e8f4910ca@collabora.com>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-ZohoMailClient: External
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dma_fence_begin_signalling() and dma_fence_end_signalling() mark the
code that the completion of a dma-fence depends on, so that lockdep can
check it against the dma-fence rules. However, up until now, it was not
possible to use the signalling tokens from Rust.

Thus, add SignallingSection, a guard that begins a section when it is
created and ends it when it is dropped. Code on the signalling path can
take a &SignallingSection to require that its caller opened one.

Use it in the DriverFence example, which has a TODO for it.

A later patch in this series makes DriverFence::signal() require one.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/dma_buf/dma_fence.rs | 70 +++++++++++++++++++++++++++++++++++++++-
 rust/kernel/dma_buf/mod.rs       |  3 +-
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
index a1d851656562..7ee87935d3be 100644
--- a/rust/kernel/dma_buf/dma_fence.rs
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -17,6 +17,7 @@
     error::to_result,
     prelude::*,
     types::ForeignOwnable,
+    types::NotThreadSafe,
     types::Opaque, //
 };
 
@@ -589,6 +590,71 @@ unsafe fn dec_ref(ptr: NonNull<Self>) {
     }
 }
 
+/// A dma-fence signalling critical section on the current task.
+///
+/// All code needed to signal a [`DriverFence`] must run in such a section,
+/// from the point where its [`Fence`] becomes visible to other threads up to
+/// the point where it is signalled. With `CONFIG_PROVE_LOCKING`, the section
+/// is a [DMA Fence Signalling Annotation], which validates that code against
+/// the [DMA Fence Cross-Driver Contract]. Without `CONFIG_LOCKDEP`, the
+/// section has no effect.
+///
+/// A function that is part of the signalling path can take a
+/// `&SignallingSection` to require that its caller opened one. Sections nest,
+/// and only the outermost one is annotated.
+///
+/// [DMA Fence Signalling Annotation]: https://docs.kernel.org/driver-api/dma-buf.html#dma-fence-signalling-annotations
+/// [DMA Fence Cross-Driver Contract]: https://docs.kernel.org/driver-api/dma-buf.html#dma-fence-cross-driver-contract
+///
+/// # Examples
+///
+/// ```
+/// use kernel::dma_buf::SignallingSection;
+///
+/// // Code on the signalling path takes a section to require that its caller
+/// // opened one.
+/// fn on_signalling_path(_section: &SignallingSection) {}
+///
+/// let section = SignallingSection::begin();
+/// on_signalling_path(&section);
+/// ```
+///
+/// # Invariants
+///
+/// `cookie` was returned by `dma_fence_begin_signalling()` on the current task
+/// and has not been passed to `dma_fence_end_signalling()` yet.
+#[must_use = "the signalling section ends immediately when the value is unused"]
+pub struct SignallingSection {
+    cookie: bool,
+    _not_send: NotThreadSafe,
+}
+
+impl SignallingSection {
+    /// Begins a signalling section on the current task.
+    #[inline]
+    pub fn begin() -> Self {
+        // SAFETY: `dma_fence_begin_signalling()` has no preconditions.
+        let cookie = unsafe { bindings::dma_fence_begin_signalling() };
+
+        // INVARIANT: `cookie` was just returned by `dma_fence_begin_signalling()`
+        // on the current task.
+        Self {
+            cookie,
+            _not_send: NotThreadSafe,
+        }
+    }
+}
+
+impl Drop for SignallingSection {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, `cookie` comes from
+        // `dma_fence_begin_signalling()` on the current task and has not been
+        // passed to `dma_fence_end_signalling()` yet.
+        unsafe { bindings::dma_fence_end_signalling(self.cookie) };
+    }
+}
+
 // Necessary to guarantee that `inner` always comes first and can be freed by C.
 // Also useful for using casts instead of container_of().
 #[repr(C)]
@@ -654,6 +720,7 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
 ///         FenceContextOps,
 ///         FenceCallback,
 ///         FenceCallbackRegistration,
+///         SignallingSection,
 ///     },
 ///     str::CString,
 ///     sync::aref::ARef, //
@@ -704,9 +771,10 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
 /// let cb_reg = unsafe { FenceCallbackRegistration::new(&waiting_fence, cb_data) };
 /// let cb_reg = KBox::pin_init(cb_reg, GFP_KERNEL)?;
 ///
-/// // TODO signalling guards
+/// let section = SignallingSection::begin();
 /// assert_eq!(waiting_fence.is_signaled(), false);
 /// fence.signal(Ok(()));
+/// drop(section);
 /// assert_eq!(waiting_fence.is_signaled(), true);
 ///
 /// Ok::<(), Error>(())
diff --git a/rust/kernel/dma_buf/mod.rs b/rust/kernel/dma_buf/mod.rs
index 4764a828642e..8dda6d91b650 100644
--- a/rust/kernel/dma_buf/mod.rs
+++ b/rust/kernel/dma_buf/mod.rs
@@ -10,5 +10,6 @@
     FenceCallback,
     FenceCallbackRegistration,
     FenceContext,
-    FenceContextOps, //
+    FenceContextOps,
+    SignallingSection, //
 };

-- 
2.56.0

