Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41204606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=DH2nIci1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 670E110F0F4;
	Mon, 19 Oct 2026 23:26:25 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 580AE10F0ED
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 23:26:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792452365; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=U8ld6WWX3mcb1RV1pJIc+LCY7QkKDA7/ldPaGJ4ETA4Sx8/tv+SOPpdvRE9v1EdDAuB4DwosKrSZ8r450gB9OwdogHmP3QIj9Sq07/JW8+ztCyQAQg9Gv/UFmcVuS3qQOmyDp7UNH+1+t/aJhNDeXlvAiew3C9IT5J37vGiy8ek=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792452365;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=moqLdOiXIDJEjW3F803DCdqiZDaCP8DoGvvPaOoz/Ac=; 
 b=AGk1lyzQf56GLIEct82TwJjEWQ8RKEPq30/uJ6/lDJfginva/Z9ZtCCP92VUixucNAHB2UMngkFI/8S4Jr35l5/yo+39lo5gJvfVluAUswNxhFStAIekYwT/kcs7n7Cd9Q1QD8JeNqAvJxxZHbaqcUcWIs+NOtwdhayHFfcUK9c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792452365; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=moqLdOiXIDJEjW3F803DCdqiZDaCP8DoGvvPaOoz/Ac=;
 b=DH2nIci1Vbqc9fQt9bi+uL3AHYkQknniCaILc/ecHByIla5MuB7apuNwah+P/2vQ
 bVkdu31EG7nYy/OgjzDVYJ36CG4gbrmpkhd77S29K5M2rZ3l7Vore6IDOpOOe+Vjxxc
 h8rkrG4mlGyj96lmMMHj3sQfhR+FQIAeJoiKIkoo=
Received: by smtp.zohomail.com with SMTPS id 17924523640151015.6731131646758; 
 Mon, 19 Oct 2026 16:26:04 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Mon, 19 Oct 2026 16:26:00 -0700
Subject: [PATCH v4 2/2] drm/tyr: safely write GpuInfo to userspace
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-gpu_info_intobytes-v4-2-0bc04df46549@collabora.com>
References: <20261019-b4-gpu_info_intobytes-v4-0-0bc04df46549@collabora.com>
In-Reply-To: <20261019-b4-gpu_info_intobytes-v4-0-0bc04df46549@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3790;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=q6p6zlWWJ8BQv6wAOLNRbYzWEvvkZCGR72/7FruQfKg=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFnXlnOEz58s0h7nzWKiF6wcOl/URqpNeFfS8ckRcTs0X
 p2rbUnuKGFhEONikBVTZDlrb9QjXvXeSHf+/2aYOaxMIEMYuDgFYCLT5Bh+zPlWtGXT/Lxn+89V
 nfj9Krx7yoRLZquN15wRrJ5mOdvtOiPDgaBJsxpnOR3x/PU0ps34j5aIxgRdrjdKlzifH7751Ia
 ZFwA=
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Instead, use the derive macro `zerocopy_derive::most_traits` for struct
drm_panthor_gpu_info. This macro will attempt to implement the zerocopy
traits for struct drm_panthor_gpu_info. If the Panthor UAPI changes so
that the traits IntoBytes or Immutable can no longer be implemented, Tyr
will no longer compile.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/file.rs |  2 +-
 drivers/gpu/drm/tyr/gpu.rs  | 16 +++-------------
 rust/bindgen_parameters     |  3 +++
 3 files changed, 7 insertions(+), 14 deletions(-)

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
index e1b04a0c5159..4808bcbcc3b9 100644
--- a/drivers/gpu/drm/tyr/gpu.rs
+++ b/drivers/gpu/drm/tyr/gpu.rs
@@ -16,7 +16,6 @@
     },
     prelude::*,
     time::Delta,
-    transmute::AsBytes,
     uapi, //
 };
 
@@ -28,6 +27,8 @@
     }, //
 };
 
+use zerocopy_derive::Immutable;
+
 /// Struct containing information that can be queried by userspace. This is read from
 /// the GPU's registers.
 ///
@@ -35,7 +36,7 @@
 ///
 /// - The layout of this struct is identical to the C `struct drm_panthor_gpu_info`.
 #[repr(transparent)]
-#[derive(Clone, Copy)]
+#[derive(Clone, Copy, IntoBytes, Immutable)]
 pub(crate) struct GpuInfo(pub(crate) uapi::drm_panthor_gpu_info);
 
 impl GpuInfo {
@@ -134,17 +135,6 @@ fn deref_mut(&mut self) -> &mut Self::Target {
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
diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
index 8402b0c93545..332bc8d6a9f7 100644
--- a/rust/bindgen_parameters
+++ b/rust/bindgen_parameters
@@ -71,3 +71,6 @@
 # Structs should implement `Zeroable` when all of their fields do.
 --with-derive-custom-struct .*=MaybeZeroable
 --with-derive-custom-union .*=MaybeZeroable
+
+# `drm_panthor_gpu_info` is copied byte-for-byte to userspace.
+--with-derive-custom-struct '^drm_panthor_gpu_info$'=zerocopy_derive::most_traits

-- 
2.56.0

