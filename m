Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34317109E55C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B833D10E9FF;
	Thu, 26 Mar 2026 06:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="Dsy2GIVE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 564B110E9FE
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 06:56:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3A8E0445A5;
 Thu, 26 Mar 2026 06:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13924C2BCB2;
 Thu, 26 Mar 2026 06:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1774508153; bh=zL5FrjNYRExq05w4y+ltuADdEYgPsEZFqeymHWAQazQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Dsy2GIVEyHd1mOD7zAXOz+H5evVeYD/2ucq1rUyGhnnguZsRla/aB5kCj1h4gl6GJ
 43O5QaaaQQ3wr6pCNkIGNv9iHuoV4YEefUYqRydNAWBAc6Xq+t7BAt69+a08CgByFe
 eG0UnhbkCo/tuBD16nXZrm7UcjlRp+9HKqQ3NJiI=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 04A62109E55A;
 Thu, 26 Mar 2026 06:55:53 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 26 Mar 2026 14:53:01 +0800
Subject: [PATCH 08/13] rust: drm/gem: add GEM object query helpers for debugfs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-b4-tyr-debugfs-v1-8-074badd18716@linux.dev>
References: <20260326-b4-tyr-debugfs-v1-0-074badd18716@linux.dev>
In-Reply-To: <20260326-b4-tyr-debugfs-v1-0-074badd18716@linux.dev>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774508149; l=2727;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=zL5FrjNYRExq05w4y+ltuADdEYgPsEZFqeymHWAQazQ=;
 b=xeg2tv+GVi/mVtf9/Q72RSTVPloo2p7WIG6SCogYnIj2i9KzuvIMMkTWQwy4p6b+i7dG2pfqN
 CLNEpRQ+vBuCaG1hTr343uZ+972glXwF1KDReKDX4AHrd8MFsq7944A
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684
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

Add name(), refcount(), is_imported(), is_exported(), and mmap_offset()
to BaseObject so drivers can expose GEM state in debugfs.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/drm/gem/mod.rs | 49 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 276ba3c53475d..b6188c8873ece 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -21,9 +21,13 @@
     },
     error::to_result,
     prelude::*,
-    sync::aref::{
-        ARef,
-        AlwaysRefCounted, //
+    sync::{
+        aref::{
+            ARef,
+            AlwaysRefCounted, //
+        },
+        atomic::Relaxed,
+        Refcount, //
     },
     types::Opaque,
 };
@@ -177,6 +181,45 @@ fn size(&self) -> usize {
         unsafe { (*self.as_raw()).size }
     }
 
+    /// Returns the name of the object.
+    #[inline]
+    fn name(&self) -> i32 {
+        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `struct drm_gem_object`.
+        unsafe { (*self.as_raw()).name }
+    }
+
+    /// Returns the reference count of the object.
+    #[inline]
+    fn refcount(&self) -> u32 {
+        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `struct drm_gem_object`.
+        let raw_refcount = unsafe { &raw mut (*self.as_raw()).refcount }.cast::<Refcount>();
+        // SAFETY: `raw_refcount` has the same layout as `Refcount`.
+        let refcount = unsafe { &*raw_refcount };
+
+        refcount.as_atomic().load(Relaxed) as u32
+    }
+
+    /// Returns true if the object is imported.
+    #[inline]
+    fn is_imported(&self) -> bool {
+        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `struct drm_gem_object`.
+        !unsafe { (*self.as_raw()).import_attach }.is_null()
+    }
+
+    /// Returns true if the object is exported.
+    #[inline]
+    fn is_exported(&self) -> bool {
+        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `struct drm_gem_object`.
+        !unsafe { (*self.as_raw()).dma_buf }.is_null()
+    }
+
+    /// Returns the offset for mmap, or 0 if no offset has been allocated.
+    #[inline]
+    fn mmap_offset(&self) -> u64 {
+        // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `struct drm_gem_object`.
+        unsafe { (*self.as_raw()).vma_node.vm_node.start }
+    }
+
     /// Creates a new handle for the object associated with a given `File`
     /// (or returns an existing one).
     fn create_handle<D, F>(&self, file: &drm::File<F>) -> Result<u32>

-- 
2.43.0


