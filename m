Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9BE606A319
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=bAbp0kvc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F52E10F0E2;
	Mon, 19 Oct 2026 23:26:17 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16E810F0E2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 23:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792452365; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=e4aDcG3RP8uWGuly63TN9VfZ+2OD6O1DNeXP5TVlqk2KCZBV964woBMEkOiGvOknXFaunIedHxhXnBOFmCDKukk/gmssODYODe6dTdw6EQjpSgMvzfgFivyq46fRwU9zAu/ef7YZjxyXwMQPNU1jCY+FlQj3z0jiYDBmR/ZQNWI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792452365;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YGaGcmA5s3rLvx2IfexTcXmFWu/hCy7f2gX18xxTm4Q=; 
 b=fMDE5jkQCZep9TcOXNkOTeflkmt4X+qbgzVMKfruAy21VYJHlZ6h5S7cnkBpd9maAkV3XTGqYHD6/TOhK6c65mKX+6ANq4OxrQ1DTXNZn6L2htMF6fubUOwMD62ALhjua8wJqKpgeKQjm07XwIpoASVwlwrZyHDgb7/ba/PSmJU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792452365; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=YGaGcmA5s3rLvx2IfexTcXmFWu/hCy7f2gX18xxTm4Q=;
 b=bAbp0kvcllYTjk024qWXAktfkbLVxSiXOexuveTITj4H9jWug4zhBnxR//MuNePP
 iZoxiz/dgGFi6nbvgQC5zv5LmbzXGsqMde9XkGlSrHNcBfFyLU/z29jtoW95Rypb4tL
 uv9q9Dutth6sfmsR1SyCS2zxEqKXX/Ega0Dt/TFo=
Received: by smtp.zohomail.com with SMTPS id 179245236269923.82180997951889;
 Mon, 19 Oct 2026 16:26:02 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Mon, 19 Oct 2026 16:25:59 -0700
Subject: [PATCH v4 1/2] rust/Makefile: add zerocopy and zerocopy_derive
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-gpu_info_intobytes-v4-1-0bc04df46549@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3187;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=EiejWXSZctCvsEqsl++99TpZc3z0JAszVm9cJejzUMI=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFnXlnPUp3n8lH+gEDZtiliQEYdf8jMhtsuMqnZ7plf2r
 pZg7YrsKGVhEONikBVTZDlrb9QjXvXeSHf+/2aYOaxMIEMYuDgFYCL7jjP8s71vKMthWrL7/R1v
 7+fvzUW/aCuf3vA4rEHWQfPA5LnXRBkZrpRWB816YxW55udW/zmfOUWKfDmkZc3Mq+KUHksY+O9
 iAwA=
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

Make the zerocopy and zerocopy_derive crates available for use when
building the bindings and uapi crates and their tests.

This will be used by the Tyr driver that needs the traits IntoBytes and
Immutable to safely copy the struct byte-for-byte to userspace.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 rust/Makefile | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index da1a7409d984..f59815fac293 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -361,12 +361,18 @@ rusttestlib-kernel: $(src)/kernel/lib.rs rusttestlib-bindings rusttestlib-uapi \
     $(obj)/bindings.o rusttestlib-zerocopy rusttestlib-zerocopy_derive FORCE
 	+$(call if_changed,rustc_test_library)
 
-rusttestlib-bindings: private rustc_target_flags = --extern ffi --extern pin_init
-rusttestlib-bindings: $(src)/bindings/lib.rs rusttestlib-ffi rusttestlib-pin_init FORCE
+rusttestlib-bindings: private rustc_target_flags = --extern ffi --extern pin_init \
+	--extern zerocopy=$(objtree)/$(obj)/test/libzerocopy.rlib \
+	--extern zerocopy_derive=$(objtree)/$(obj)/test/$(libzerocopy_derive_name)
+rusttestlib-bindings: $(src)/bindings/lib.rs rusttestlib-ffi rusttestlib-pin_init \
+	rusttestlib-zerocopy rusttestlib-zerocopy_derive FORCE
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
@@ -774,19 +780,25 @@ $(obj)/ffi.o: private skip_gendwarfksyms = 1
 $(obj)/ffi.o: $(src)/ffi.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
-$(obj)/bindings.o: private rustc_target_flags = --extern ffi --extern pin_init
+$(obj)/bindings.o: private rustc_target_flags = --extern ffi --extern pin_init \
+	--extern zerocopy --extern zerocopy_derive
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
+	--extern zerocopy --extern zerocopy_derive
 $(obj)/uapi.o: private skip_gendwarfksyms = 1
 $(obj)/uapi.o: $(src)/uapi/lib.rs \
     $(obj)/ffi.o \
     $(obj)/pin_init.o \
+    $(obj)/zerocopy.o \
+    $(obj)/$(libzerocopy_derive_name) \
     $(obj)/uapi/uapi_generated.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 

-- 
2.56.0

