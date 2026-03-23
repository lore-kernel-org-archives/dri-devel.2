Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD6BF4613F
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 23:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6311810E27E;
	Mon, 23 Mar 2026 23:27:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="VmGRmtYW";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D738710E27E
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 23:27:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774308458; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KMGNzqfr3dD8xZJ+uJvtkNHocdmkHNUvy2H6H6Vt2KWyzfjN2yPIOOP0L2rH/ax/Or/dyOjT86FCzx1rezkO7/r7NirnybzIWwDbOrL1IdRT5fFRaq3sTN657ahNRvBHKy9TYXp5Pm6PD79Lgkm5h9lfdXMjNYczhnoZIF5gEPY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774308458;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pL3o6kS2PJaOTcPfyro8VK/371F0ui4beUIeLBEPyUA=; 
 b=geCFDmVldaWmJqL9trcLLsQM2ylRpPk6cE/bF4v07c1M9aBAq0MBbaUNHHYK6vnnCfxdi2ge7CGetnJymIw5jIhs6rnNTe6m8KtaHODYM3waR47sfC2Xlotdl28Ewjzuf0vzlUBGMzNLRRprfg2tGZA5r7lyfYTLZ1HyZzjOk9M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774308458; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=pL3o6kS2PJaOTcPfyro8VK/371F0ui4beUIeLBEPyUA=;
 b=VmGRmtYWfxo4qWITD4x0K1yVzaJsFDSHjTlCp+cQbbPmh40eioAOqKFj0vdJ38fa
 WPzJf15q5i3+PVnfN6WgHN0qe+zo+0ZuaB4duJaagNVrZ5ARipit+7JFgcQCMqaSNvL
 CUxbXlWPXYCdCRu59PwYr7ivtgsCe5OS4d7zo8Iw=
Received: by mx.zohomail.com with SMTPS id 1774308455694569.5259577932671;
 Mon, 23 Mar 2026 16:27:35 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Mon, 23 Mar 2026 20:27:00 -0300
Subject: [PATCH v3 2/4] rust: drm: dispatch work items to the private data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-aref-workitem-v3-2-f59729b812aa@collabora.com>
References: <20260323-aref-workitem-v3-0-f59729b812aa@collabora.com>
In-Reply-To: <20260323-aref-workitem-v3-0-f59729b812aa@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.3
X-ZohoMailClient: External
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

This implementation dispatches any work enqueued on ARef<drm::Device<T>> to
its driver-provided handler. It does so by building upon the newly-added
ARef<T> support in workqueue.rs in order to call into the driver
implementations for work_container_of and raw_get_work.

This is notably important for work items that need access to the drm
device, as it was not possible to enqueue work on a ARef<drm::Device<T>>
previously without failing the orphan rule.

The current implementation needs T::Data to live inline with drm::Device in
order for work_container_of to function. This restriction is already
captured by the trait bounds. Drivers that need to share their ownership of
T::Data may trivially get around this:

// Lives inline in drm::Device
struct DataWrapper {
  work: ...,
  // Heap-allocated, shared ownership.
  data: Arc<DriverData>,
}

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/drm/device.rs | 56 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 629ef0bd1188..5db5c7e3bb7a 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -6,8 +6,7 @@
 
 use crate::{
     alloc::allocator::Kmalloc,
-    bindings,
-    device,
+    bindings, device,
     drm::{
         self,
         driver::AllocImpl, //
@@ -18,7 +17,12 @@
         ARef,
         AlwaysRefCounted, //
     },
-    types::Opaque, //
+    types::Opaque,
+    workqueue::{
+        HasWork,
+        Work,
+        WorkItem, //
+    },
 };
 use core::{
     alloc::Layout,
@@ -241,3 +245,49 @@ unsafe impl<T: drm::Driver> Send for Device<T> {}
 // SAFETY: A `drm::Device` can be shared among threads because all immutable methods are protected
 // by the synchronization in `struct drm_device`.
 unsafe impl<T: drm::Driver> Sync for Device<T> {}
+
+impl<T, const ID: u64> WorkItem<ID> for Device<T>
+where
+    T: drm::Driver,
+    T::Data: WorkItem<ID, Pointer = ARef<Device<T>>>,
+    T::Data: HasWork<Device<T>, ID>,
+{
+    type Pointer = ARef<Device<T>>;
+
+    fn run(ptr: ARef<Device<T>>) {
+        T::Data::run(ptr);
+    }
+}
+
+// SAFETY:
+//
+// - `raw_get_work` and `work_container_of` return valid pointers by relying on
+// `T::Data::raw_get_work` and `container_of`. In particular, `T::Data` is
+// stored inline in `drm::Device`, so the `container_of` call is valid.
+//
+// - The two methods are true inverses of each other: given `ptr: *mut
+// Device<T>`, `raw_get_work` will return a `*mut Work<Device<T>, ID>` through
+// `T::Data::raw_get_work` and given a `ptr: *mut Work<Device<T>, ID>`,
+// `work_container_of` will return a `*mut Device<T>` through `container_of`.
+unsafe impl<T, const ID: u64> HasWork<Device<T>, ID> for Device<T>
+where
+    T: drm::Driver,
+    T::Data: HasWork<Device<T>, ID>,
+{
+    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<Device<T>, ID> {
+        // SAFETY: The caller promises that `ptr` points to a valid `Device<T>`.
+        let data_ptr = unsafe { &raw mut (*ptr).data };
+
+        // SAFETY: `data_ptr` is a valid pointer to `T::Data`.
+        unsafe { T::Data::raw_get_work(data_ptr) }
+    }
+
+    unsafe fn work_container_of(ptr: *mut Work<Device<T>, ID>) -> *mut Self {
+        // SAFETY: The caller promises that `ptr` points at a `Work` field in
+        // `T::Data`.
+        let data_ptr = unsafe { T::Data::work_container_of(ptr) };
+
+        // SAFETY: `T::Data` is stored as the `data` field in `Device<T>`.
+        unsafe { crate::container_of!(data_ptr, Self, data) }
+    }
+}

-- 
2.53.0

