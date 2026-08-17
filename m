Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C20C5DF7A
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A042210E3FE;
	Mon, 17 Aug 2026 11:41:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="DQ2nwZjb";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61C2610E3F1
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 11:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786966865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcBfFGBouFqsx+ABHHYb+Wnv6e6DiBO6Gs1BOe4gNuo=;
 b=DQ2nwZjbf237+k2Y7i95rQpSvxSdxJJtkQ9nI3RVu7VDIJTGHa8L7y5vp6RYBNpRtMg5AD
 fsxkh6rZ7WJmQMp3+52VExHEXCpQbICHWnv0tZiIq8rr8L2aErBhOX/AWhFl9MsdUNioru
 iC798cOD07iYNQJSAu0k1RV9ToeOocs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-So7fCxQpN4eMF9XmS5UGKA-1; Mon,
 17 Aug 2026 07:41:03 -0400
X-MC-Unique: So7fCxQpN4eMF9XmS5UGKA-1
X-Mimecast-MFC-AGG-ID: So7fCxQpN4eMF9XmS5UGKA_1786966861
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F27E8195609D; Mon, 17 Aug 2026 11:41:00 +0000 (UTC)
Received: from [192.168.1.153] (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19CD4422; Mon, 17 Aug 2026 11:40:55 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 17 Aug 2026 13:40:46 +0200
Subject: [PATCH 1/5] rust: of: add Node type
MIME-Version: 1.0
Message-Id: <20260817-drm_panel_bindings-v1-1-1f974508a31c@redhat.com>
References: <20260817-drm_panel_bindings-v1-0-1f974508a31c@redhat.com>
In-Reply-To: <20260817-drm_panel_bindings-v1-0-1f974508a31c@redhat.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: devicetree@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Albert Esteve <aesteve@redhat.com>, mripard@kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786966849; l=3194;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=ZRV3ir9Mip4kV3HKkGcK9iC14+NTymLEZwyObo6R3pk=;
 b=tCLXlJC3jyytEXh/j3/QVe5pUEC9LZnGxNHzOen73iHx48cTODEaeJvYVebqEB8B1v13rQ1fx
 /bJqTcAh88+B13yWchudIT6SSYDRPWiAf3NReL5A0oidUA/hQmyJD2j
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 2jVK9c7aU2T4Q3l5pqfqBz0-QCO78LaalEUlFSvNHoI_1786966861
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Add a Rust abstraction for `struct device_node`, the device
tree node type.

`Node` wraps `device_node` type pointer and implements
`AlwaysRefCounted`, allowing owned references to device
tree nodes to be held. To do so, add C helpers to make
them always accesible from Rust bindings, independently
from the configuration.

This abstraction is needed for subsequent patches, in particular
for creating drm_panel instances from a `const struct device_node`
pointer argument.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 rust/helpers/of.c | 10 ++++++++++
 rust/kernel/of.rs | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/rust/helpers/of.c b/rust/helpers/of.c
index 8f62ca69e8ba5..dca306852975e 100644
--- a/rust/helpers/of.c
+++ b/rust/helpers/of.c
@@ -6,3 +6,13 @@ __rust_helper bool rust_helper_is_of_node(const struct fwnode_handle *fwnode)
 {
 	return is_of_node(fwnode);
 }
+
+__rust_helper struct device_node *rust_helper_of_node_get(struct device_node *node)
+{
+	return of_node_get(node);
+}
+
+__rust_helper void rust_helper_of_node_put(struct device_node *node)
+{
+	of_node_put(node);
+}
diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
index 58b20c367f993..e75ab81cfe1f7 100644
--- a/rust/kernel/of.rs
+++ b/rust/kernel/of.rs
@@ -6,7 +6,10 @@
     bindings,
     device_id::{RawDeviceId, RawDeviceIdIndex},
     prelude::*,
+    sync::aref::AlwaysRefCounted,
+    types::Opaque,
 };
+use core::ptr::NonNull;
 
 /// IdTable type for OF drivers.
 pub type IdTable<T> = &'static dyn kernel::device_id::IdTable<DeviceId, T>;
@@ -63,3 +66,43 @@ macro_rules! of_device_table {
         $crate::module_device_table!("of", $module_table_name, $table_name);
     };
 }
+
+/// A device tree node (`struct device_node`).
+///
+/// # Invariants
+///
+/// The inner pointer is always a valid, non-null pointer to a `struct device_node`
+/// with a positive reference count.
+#[repr(transparent)]
+pub struct Node(Opaque<bindings::device_node>);
+
+impl Node {
+    /// Creates a reference from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be a valid, non-null `struct device_node` pointer that remains
+    /// valid for the lifetime `'a`.
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::device_node) -> &'a Self {
+        // SAFETY: Caller guarantees `ptr` is valid and lives for `'a`.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns the raw pointer to the underlying `struct device_node`.
+    pub fn as_raw(&self) -> *const bindings::device_node {
+        self.0.get() as _
+    }
+}
+
+// SAFETY: By the type invariants, this type is always refcounted.
+unsafe impl AlwaysRefCounted for Node {
+    fn inc_ref(&self) {
+        // SAFETY: The type invariant guarantees the pointer is valid.
+        unsafe { bindings::of_node_get(self.as_raw().cast_mut()) };
+    }
+
+    unsafe fn dec_ref(obj: NonNull<Self>) {
+        // SAFETY: The safety requirements guarantee that the refcount is non-zero.
+        unsafe { bindings::of_node_put(obj.cast().as_ptr()) };
+    }
+}

-- 
2.55.0

