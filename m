Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399F4C9830E
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 00:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA43E10E2D7;
	Sat, 26 Sep 2026 00:26:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="OiEYenyX";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 626EA10E2CB
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 00:26:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790382374; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PeWaetxg2/MImxXj8IxqYYjLG5jnwnAj6vYFnup49O1eJ/gU/3Tkr+U7mVxIDeh+AIgtWoEN6FlpawdfpplCCSs1UfmypE7ON6hdXpEVsdzvAUCiFyd0h+f/jGUEnR90PSKHYuVb9b+XM75LpFYx1CVCAkgWaZFEnZziZEetPSM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790382374;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=LQ/ZbIJR6hiKL9nHx8BBYMj0YSQITVipbyTwUFEg3Rc=; 
 b=Fh0SMjg7fMolf6FCKzsWvnthvHoqfew6gn4KSUihcKYuz+OuhHeh4jP92C0m66wIvclRexYHc+GIO/DRph0YIXE9Pb5BhddUKUF/jyRZwZlbPF/JcBzU8HspPSQGUAWU0xCh/y2SKIR5X1ARe9a6emAHNv7X+oUqWVNM3P/opmM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790382374; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=LQ/ZbIJR6hiKL9nHx8BBYMj0YSQITVipbyTwUFEg3Rc=;
 b=OiEYenyXNiJ3GBhAVE8aXyCFL0dmYQyoG0JQOtYA/oRYVcVUKAelz5GZpFNMeTT0
 u6MPvRLzSJnweT+M5rDGV9/YyHXqtIrH3x4az546gIjUHtYZN3J23KdDmdh2JtJA2Ju
 NtYH3vv+KRWrs3ALA+QmG/asdcNA8Tak3S1oX7zE=
Received: by smtp.zohomail.com with SMTPS id 1790382372759884.051922969394;
 Fri, 25 Sep 2026 17:26:12 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Fri, 25 Sep 2026 17:26:09 -0700
Subject: [PATCH v3 1/2] rust: uapi: add zerocopy/zerocopy_derive
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-b4-gpu_info_intobytes-v3-1-e19bcb71980d@collabora.com>
References: <20260925-b4-gpu_info_intobytes-v3-0-e19bcb71980d@collabora.com>
In-Reply-To: <20260925-b4-gpu_info_intobytes-v3-0-e19bcb71980d@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2711;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=XuWNqj3gYHFgRI2FHenDdAOIjz0nK9cfEl8ozVKL4PI=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFnbBZWqxFVmit1pu217XGSheEDbhEXrS7iO3a1c6TOR4
 6LthgfbO0pZGMS4GGTFFFnO2hv1iFe9N9Kd/78ZZg4rE8gQBi5OAZjI/LkMf3jjPA4c2fHt6Kr1
 kWu3v26ab30rvVfhw/Jj85cseGK5OOoMw/+04nOieY/+iVuw99z//XRNe7GyivMf2RvmGoFGEkm
 Xe7kB
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

Make the zerocopy and zerocopy_derive crates available for use when
building the UAPI crate and its tests. Then attempt to derive most of
the zerocopy traits for struct drm_panthor_gpu_info when generating its
binding. This will be used by the Tyr driver that needs the traits
IntoBytes and Immutable to safely copy the struct byte-for-byte to
userspace.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 rust/Makefile           | 12 +++++++++---
 rust/bindgen_parameters |  3 +++
 2 files changed, 12 insertions(+), 3 deletions(-)

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
2.55.0

