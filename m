Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDB3606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=curye+Pz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5D6210F840;
	Tue, 20 Oct 2026 23:48:11 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B068710F839
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 23:48:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792540074; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LBu7GexQf4uyuZKE8Hmsguyxg6btlq1xjlYOov/whde8TdHkQ8BYxMovYdgzp7JWvzs3PzI7F8QQYu92qRx8hZ8FMeWdtyUepRdw5QaDGXCeiz7Ky1s3j1Ux0uVVBFxQWWgq3D9rUwSU8T6c7JD7EjMTN4jrSoWwTH1/CUFSPE0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792540074;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YmHrXWU3qMwB9b2uAxX6OMWoxOJoFBDFFfj/j0paiqk=; 
 b=aHHCV9nEN6yGYpbnGttwkFYkE+x7kZ48lLB5eZVHZVtudycQEzHClYXObazs5BVzPorw/RAIVLAuTGNYjHYpg32vNB4kLbCLA4TtWPG8LJzYGVvCfUpliISkvsQT7b4pnwI3hiG2Z3IugaojrAE7ddR74iftMSHssO+GtTlLCr0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792540074; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=YmHrXWU3qMwB9b2uAxX6OMWoxOJoFBDFFfj/j0paiqk=;
 b=curye+PzcNaYM1m8osNL+K+/wnECKiC7OjnUfmgV5AwrfNTYc+bLtv9eUEY1Y/EB
 wKaSbW/owLurT23yRFrvNNI3ZwwTboofkBu7+QWrAWIaU9r3aVDcXFQojC/QHpJmEXy
 3BcbRUj8aLXUlrQCWyqbmNzvRcA/QqdLoT+rmXKY=
Received: by smtp.zohomail.com with SMTPS id 1792540072479813.6681805514874;
 Tue, 20 Oct 2026 16:47:52 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Tue, 20 Oct 2026 16:47:48 -0700
Subject: [PATCH v5 1/2] rust: add zerocopy to bindings and uapi
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-b4-gpu_info_intobytes-v5-1-3e0c7c93223c@collabora.com>
References: <20261020-b4-gpu_info_intobytes-v5-0-3e0c7c93223c@collabora.com>
In-Reply-To: <20261020-b4-gpu_info_intobytes-v5-0-3e0c7c93223c@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Jesung Yang <y.j3ms.n@gmail.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4236;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=ksUdZjJLS9NRl0QqnesGr43vVVUDSiP4F76anxruEjA=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFnX/y5NSJrI5vJzr66YxOPuH9z7Os3PMigz30m8tO3og
 QUvZ8wT6ChlYRDjYpAVU2Q5a2/UI1713kh3/v9mmDmsTCBDGLg4BWAipqyMDDMTTtzMye6fO99Q
 b5LNBZZZUe6tctsenFQQPHHarveA7z2G/8Ebdq5kN+7p267t6C595t2B0Go+z3yBXf3pNn2ak7U
 38gAA
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

Make the zerocopy and zerocopy_derive crates available to use when
building the bindings and uapi crates and their tests. Also make the
zerocopy and zerocopy_derive crates available to rust-analyzer when it
runs on the bindings and uapi crates.

This will be used by the Tyr driver that needs the traits IntoBytes and
Immutable to safely copy the struct byte-for-byte to userspace.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 rust/Makefile                     | 24 ++++++++++++++++++------
 scripts/generate_rust_analyzer.py |  4 ++--
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index da1a7409d984..a182c0e96974 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -361,12 +361,18 @@ rusttestlib-kernel: $(src)/kernel/lib.rs rusttestlib-bindings rusttestlib-uapi \
     $(obj)/bindings.o rusttestlib-zerocopy rusttestlib-zerocopy_derive FORCE
 	+$(call if_changed,rustc_test_library)
 
-rusttestlib-bindings: private rustc_target_flags = --extern ffi --extern pin_init
-rusttestlib-bindings: $(src)/bindings/lib.rs rusttestlib-ffi rusttestlib-pin_init FORCE
+rusttestlib-bindings: private rustc_target_flags = --extern ffi --extern pin_init \
+    --extern zerocopy=$(objtree)/$(obj)/test/libzerocopy.rlib \
+    --extern zerocopy_derive=$(objtree)/$(obj)/test/$(libzerocopy_derive_name)
+rusttestlib-bindings: $(src)/bindings/lib.rs rusttestlib-ffi rusttestlib-pin_init \
+    rusttestlib-zerocopy rusttestlib-zerocopy_derive FORCE
 	+$(call if_changed,rustc_test_library)
 
-rusttestlib-uapi: private rustc_target_flags = --extern ffi --extern pin_init
-rusttestlib-uapi: $(src)/uapi/lib.rs rusttestlib-ffi rusttestlib-pin_init FORCE
+rusttestlib-uapi: private rustc_target_flags = --extern ffi --extern pin_init \
+    --extern zerocopy=$(objtree)/$(obj)/test/libzerocopy.rlib \
+    --extern zerocopy_derive=$(objtree)/$(obj)/test/$(libzerocopy_derive_name)
+rusttestlib-uapi: $(src)/uapi/lib.rs rusttestlib-ffi rusttestlib-pin_init \
+    rusttestlib-zerocopy rusttestlib-zerocopy_derive FORCE
 	+$(call if_changed,rustc_test_library)
 
 quiet_cmd_rustdoc_test = RUSTDOC T $<
@@ -774,19 +780,25 @@ $(obj)/ffi.o: private skip_gendwarfksyms = 1
 $(obj)/ffi.o: $(src)/ffi.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
-$(obj)/bindings.o: private rustc_target_flags = --extern ffi --extern pin_init
+$(obj)/bindings.o: private rustc_target_flags = --extern ffi --extern pin_init \
+    --extern zerocopy --extern zerocopy_derive
 $(obj)/bindings.o: $(src)/bindings/lib.rs \
     $(obj)/ffi.o \
     $(obj)/pin_init.o \
+    $(obj)/zerocopy.o \
+    $(obj)/$(libzerocopy_derive_name) \
     $(obj)/bindings/bindings_generated.rs \
     $(obj)/bindings/bindings_helpers_generated.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
-$(obj)/uapi.o: private rustc_target_flags = --extern ffi --extern pin_init
+$(obj)/uapi.o: private rustc_target_flags = --extern ffi --extern pin_init \
+    --extern zerocopy --extern zerocopy_derive
 $(obj)/uapi.o: private skip_gendwarfksyms = 1
 $(obj)/uapi.o: $(src)/uapi/lib.rs \
     $(obj)/ffi.o \
     $(obj)/pin_init.o \
+    $(obj)/zerocopy.o \
+    $(obj)/$(libzerocopy_derive_name) \
     $(obj)/uapi/uapi_generated.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index dc1219736f77..6255a81591eb 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -313,8 +313,8 @@ def generate_crates(
         }
         return register_crate(crate_with_generated)
 
-    bindings = append_crate_with_generated("bindings", [core, ffi, pin_init])
-    uapi = append_crate_with_generated("uapi", [core, ffi, pin_init])
+    bindings = append_crate_with_generated("bindings", [core, ffi, pin_init, zerocopy, zerocopy_derive])
+    uapi = append_crate_with_generated("uapi", [core, ffi, pin_init, zerocopy, zerocopy_derive])
     kernel = append_crate_with_generated(
         "kernel", [core, macros, build_error, pin_init, ffi, bindings, uapi, zerocopy, zerocopy_derive]
     )

-- 
2.56.0

