Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB39C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:41:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD8EA10E764;
	Mon, 17 Aug 2026 11:41:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gVti5fj5";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38EAB10E763
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 11:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786966884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yF5hSMmrhAchBrFi1aBwQrM8p8lTLNxn2Y/Hj6Zq5sA=;
 b=gVti5fj5DSVAa30p70RiSQcpoJGQRvNvs9coBbXLLu0XyKmk1DoTHmvjCJX+ZJ3Yf7YNr7
 zp70yzGbh41ZRBrORRnB27zK2zEi7uKPOlXxbb4FMBoOpJ9Su9tIl/s19kCmqK1sx10KeR
 CrpHcjmZe8vtyIK2/t9Uo+mwCf7uyQk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-AcEoYBedOZm0vnA0TqXCCA-1; Mon,
 17 Aug 2026 07:41:09 -0400
X-MC-Unique: AcEoYBedOZm0vnA0TqXCCA-1
X-Mimecast-MFC-AGG-ID: AcEoYBedOZm0vnA0TqXCCA_1786966866
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A7DF1800471; Mon, 17 Aug 2026 11:41:06 +0000 (UTC)
Received: from [192.168.1.153] (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52B69422; Mon, 17 Aug 2026 11:41:01 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 17 Aug 2026 13:40:47 +0200
Subject: [PATCH 2/5] rust: drm: add connector abstraction
MIME-Version: 1.0
Message-Id: <20260817-drm_panel_bindings-v1-2-1f974508a31c@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786966849; l=2548;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=iF8KpoytzvpnqLwM+WPDFZesluui1b680ixY9h/BEKs=;
 b=3yFrkKa4o8rqbjEkeGSkXfrl1LovnqUzx3mw+hXpd+psOy8Bh6nBQuEewpstRcMUwhbafMc2i
 0hvL9nzn65LCnTCZvI6rGEcY5VlFbAOeqhlZ+rP99E3KZ2maq6NhzXs
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: rSLySTxDYmKuHGNpJ0t7j4y5V311_YbMhHQyZA9l3NE_1786966866
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

Add DRM Connector abstraction wrapping `struct drm_connector`.
Used by the DRM panel abstractions added in the following patch.
Since it is merely used as a raw pointer and managed internally in
the panel's C functions, the Connector does not need to expose
anything else for now.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/drm/connector.rs    | 33 +++++++++++++++++++++++++++++++++
 rust/kernel/drm/mod.rs          |  1 +
 3 files changed, 35 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 1124785e210b3..7f3030ac0feb6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -30,6 +30,7 @@
 
 #include <linux/acpi.h>
 #include <linux/gpu_buddy.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
diff --git a/rust/kernel/drm/connector.rs b/rust/kernel/drm/connector.rs
new file mode 100644
index 0000000000000..b3b36644375dd
--- /dev/null
+++ b/rust/kernel/drm/connector.rs
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! DRM connector abstractions.
+//!
+//! C header: [`include/drm/drm_connector.h`](srctree/include/drm/drm_connector.h)
+
+use crate::{bindings, types::Opaque};
+
+/// A DRM connector (`struct drm_connector`).
+///
+/// # Invariants
+///
+/// The inner pointer is always a valid, non-null pointer to a `struct drm_connector`.
+#[repr(transparent)]
+pub struct Connector(Opaque<bindings::drm_connector>);
+
+impl Connector {
+    /// Creates a reference to a [`Connector`] from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must be a valid, non-null pointer to a `struct drm_connector` that
+    /// remains valid for at least the lifetime `'a`.
+    pub unsafe fn from_raw<'a>(ptr: *mut bindings::drm_connector) -> &'a Self {
+        // SAFETY: Caller guarantees `ptr` is valid and lives for `'a`.
+        unsafe { &*ptr.cast() }
+    }
+
+    /// Returns the raw pointer to the underlying `struct drm_connector`.
+    pub fn as_raw(&self) -> *mut bindings::drm_connector {
+        self.0.get()
+    }
+}
diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
index a66e7166f66b5..672ea8728e1c3 100644
--- a/rust/kernel/drm/mod.rs
+++ b/rust/kernel/drm/mod.rs
@@ -2,6 +2,7 @@
 
 //! DRM subsystem abstractions.
 
+pub mod connector;
 pub mod device;
 pub mod driver;
 pub mod file;

-- 
2.55.0

