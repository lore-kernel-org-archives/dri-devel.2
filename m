Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC8CC9830D
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 00:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C5E610F247;
	Thu, 24 Sep 2026 00:21:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="S9G62yRf";
	dkim-atps=neutral
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD54B10E4A4
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 00:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790209260; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RmFSmR+1S/O8XJgs4Qq+OihW6QlUM8YP+T7Z/RrdX3m3THAK/9Xv6d3W7c6tiGIUnzd8mx1IoA+v1Lnxah/ZKjzq809PjeuLfzle9CtcErnx5PtwturgfslcG5GNxFLCckCevSNthJfMgXmU/URPeow6LCRdqBGj8HdnlMu5Hvg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790209260;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=+KorbPrqnzxaHJHprvzhFbK2cDqoGlVN/qVwcgSSmY8=; 
 b=fHjBBGlSuVeTwrNq74hCBsevsJWPBCnbEJl2CYPYyfFyquskfD8ijO16gp7mWo50qKvpBOcWHxFBk83sMbrl9NbXk3PQq41w1rOPTt3LeIoEpfqni/o6i0IaTjiYENDCus4YCfqQ0pFvttuIAexjCxie07natRgs73VzrBExyZg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790209260; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=+KorbPrqnzxaHJHprvzhFbK2cDqoGlVN/qVwcgSSmY8=;
 b=S9G62yRfWOj9Bujog9JzgkRDlQqanHnsx7MdtIao3Ps19dcm+bEVYvFQgV4jyM5B
 +Jypcm2lDsTWxssXqxUtV2r6tFJu3MMtnCPiKbNPLyFjusGF556WYp/1HcMzeBrXI1X
 +s6swrAJolnUOtr9avsrFSEnU3fgK9CShkWvKr4s=
Received: by smtp.zohomail.com with SMTPS id 1790209260058565.5535614783416;
 Wed, 23 Sep 2026 17:21:00 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Wed, 23 Sep 2026 17:20:57 -0700
Subject: [PATCH] drm/tyr: safely write GpuInfo to userspace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-b4-gpu_info_intobytes-v1-1-bb2173f91e11@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQ5AMBAAvyJ71oRVgq+ICLVlL620JUT6d43LJ
 HOYecGTY/LQZy84utizNUnKPAO1z2YjwWtywAKbosNKLFJsxzmx0TYh2OUJ5IXCVdYau6pWLaT
 2cKT5/r/DGOMHkbTHdWcAAAA=
X-Change-ID: 20260923-b4-gpu_info_intobytes-c2d45f2935c8
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5507;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=rYcXIJB0H9vuXe1TlPZ+/eIGNDr4asuuq5vLlOyvj5I=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFlbcl6922VbouxzKmSFrbzFd6MNlXNart8quMbbsaiTg
 TGZ71BaRykLgxgXg6yYIstZe6Me8ar3Rrrz/zfDzGFlAhnCwMUpABMRc2X4p/Gy6n0xK8P7eTm/
 lHabdfV/idkXb6wiF3PRaCXXBtX3vYwMK6oqNtQ2egm/ebDEZYvKU90s6VorqfxpGcJ7DV1181Z
 wAwA=
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

Tyr creates the struct drm_panthor_gpu_info from the Panthor UAPI
bindings. It initializes this struct by querying the gpu and then writes
the struct into userspace memory faithfully byte-by-byte.

Currently, the struct drm_panthor_gpu_info does not have any implicit
padding, but if implicit padding were added in the future Rust does not
guarantee that it would be initialized. Then when Tyr writes the struct
back to userspace it could expose uninitialized kernel memory.

Tyr implements the unsafe trait AsBytes for GpuInfo whereby the developer
guarantees that struct drm_panthor_gpu_info does not include implicit
padding, pointers, or interior mutability. This allows Tyr to safely copy
the struct into userspace memory. However, relying on the unsafe trait
AsBytes is fragile because if the Panthor UAPI changes, the SAFETY
guarantees may no longer be accurate.

Instead, use the macros provided by the zerocopy crate to safely derive
the traits IntoBytes and Immutable for struct drm_panthor_gpu_info. This
will cause a compile error if the Panthor UAPI changes in a way that the
traits IntoBytes or Immutable can no longer be implemented.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/file.rs |  2 +-
 drivers/gpu/drm/tyr/gpu.rs  | 12 ------------
 rust/Makefile               | 12 +++++++++---
 rust/bindgen_parameters     |  4 ++++
 rust/uapi/lib.rs            |  4 ++++
 5 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index 9f60a90d4948..ceadde976502 100644
--- a/drivers/gpu/drm/tyr/file.rs
+++ b/drivers/gpu/drm/tyr/file.rs
@@ -54,7 +54,7 @@ pub(crate) fn dev_query(
                     )
                     .writer();
 
-                    writer.write(&reg_data.gpu_info)?;
+                    writer.write_slice(reg_data.gpu_info.as_bytes())?;
 
                     Ok(0)
                 }
diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
index e1b04a0c5159..fde5bd0f87a1 100644
--- a/drivers/gpu/drm/tyr/gpu.rs
+++ b/drivers/gpu/drm/tyr/gpu.rs
@@ -16,7 +16,6 @@
     },
     prelude::*,
     time::Delta,
-    transmute::AsBytes,
     uapi, //
 };
 
@@ -134,17 +133,6 @@ fn deref_mut(&mut self) -> &mut Self::Target {
     }
 }
 
-// SAFETY: `GpuInfo`'s invariant guarantees that it is the same type that is
-// already exposed to userspace by the C driver. This implies that it fulfills
-// the requirements for `AsBytes`.
-//
-// This means:
-//
-// - No implicit padding,
-// - No kernel pointers,
-// - No interior mutability.
-unsafe impl AsBytes for GpuInfo {}
-
 struct GpuModels {
     name: &'static str,
     arch_major: u32,
diff --git a/rust/Makefile b/rust/Makefile
index da1a7409d984..bf02a1efd6f3 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -365,8 +365,11 @@ rusttestlib-bindings: private rustc_target_flags = --extern ffi --extern pin_ini
 rusttestlib-bindings: $(src)/bindings/lib.rs rusttestlib-ffi rusttestlib-pin_init FORCE
 	+$(call if_changed,rustc_test_library)
 
-rusttestlib-uapi: private rustc_target_flags = --extern ffi --extern pin_init
-rusttestlib-uapi: $(src)/uapi/lib.rs rusttestlib-ffi rusttestlib-pin_init FORCE
+rusttestlib-uapi: private rustc_target_flags = --extern ffi --extern pin_init \
+	--extern zerocopy=$(objtree)/$(obj)/test/libzerocopy.rlib \
+	--extern zerocopy_derive=$(objtree)/$(obj)/test/$(libzerocopy_derive_name)
+rusttestlib-uapi: $(src)/uapi/lib.rs rusttestlib-ffi rusttestlib-pin_init \
+	rusttestlib-zerocopy rusttestlib-zerocopy_derive FORCE
 	+$(call if_changed,rustc_test_library)
 
 quiet_cmd_rustdoc_test = RUSTDOC T $<
@@ -782,11 +785,14 @@ $(obj)/bindings.o: $(src)/bindings/lib.rs \
     $(obj)/bindings/bindings_helpers_generated.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
-$(obj)/uapi.o: private rustc_target_flags = --extern ffi --extern pin_init
+$(obj)/uapi.o: private rustc_target_flags = --extern ffi --extern pin_init \
+	--extern zerocopy --extern zerocopy_derive
 $(obj)/uapi.o: private skip_gendwarfksyms = 1
 $(obj)/uapi.o: $(src)/uapi/lib.rs \
     $(obj)/ffi.o \
     $(obj)/pin_init.o \
+    $(obj)/zerocopy.o \
+    $(obj)/$(libzerocopy_derive_name) \
     $(obj)/uapi/uapi_generated.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 8402b0c93545..65d913181eec 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -71,3 +71,7 @@
 # Structs should implement `Zeroable` when all of their fields do.
 --with-derive-custom-struct .*=MaybeZeroable
 --with-derive-custom-union .*=MaybeZeroable
+
+# `drm_panthor_gpu_info` is copied byte-for-byte to userspace.
+--with-derive-custom-struct '^drm_panthor_gpu_info$'=IntoBytes
+--with-derive-custom-struct '^drm_panthor_gpu_info$'=Immutable
diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
index 797ead5b5626..ddb35ffcd4b6 100644
--- a/rust/uapi/lib.rs
+++ b/rust/uapi/lib.rs
@@ -36,5 +36,9 @@
 type __kernel_ptrdiff_t = isize;
 
 use pin_init::MaybeZeroable;
+use zerocopy_derive::{
+    Immutable,
+    IntoBytes, //
+};
 
 include!(concat!(env!("OBJTREE"), "/rust/uapi/uapi_generated.rs"));

---
base-commit: 896ed083362758b33c49a1b5e5a3423c5814d87e
change-id: 20260923-b4-gpu_info_intobytes-c2d45f2935c8

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

