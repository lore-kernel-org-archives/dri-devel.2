Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF209FF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 322AB10E6C2;
	Mon, 27 Apr 2026 10:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="l+fjPGUC";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E578A10E6C1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 10:55:04 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-488d3eec9bcso65467875e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 03:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777287303; x=1777892103;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=slNdLl1QnszC1nVfd/YNLxP2CuhQTb4CiAEcELPAfjc=;
 b=l+fjPGUC1WBubqu39wpaRkJrPrMhHK2zioN+OF8Ca/ch6OVtJGPU0GibiRAyTfpK3o
 eEBwQSiD0/dy4Fi/2yUehYzf2neTliqZE/EcdWeTGx5ijzHdbxn8wIvWY08p0Z04x0kt
 0NQ668x+GvPlH4aviNF5MptcyH9gRT/J5W2y0LEIeUt5pu0Lp7d94e4wYnFPWDfIczMz
 BWAu+/qe5IUn06EpEmam9ZhVZC56NAUec7ardYwBcY86mx9/2TB90430sSqQ52myoY7u
 qBcPye+X3koxe8nJN6d+jNW/hde1+Ya4xPOCl+UNFomhF01jmI2dxch5C9v2oTtGr0/B
 o8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777287303; x=1777892103;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=slNdLl1QnszC1nVfd/YNLxP2CuhQTb4CiAEcELPAfjc=;
 b=TL6TMJlxDyQ9xdebX741imsl971TZWBAZYCkCJUSAr2uO+YpgPXFk0WyUhc9lLpeQH
 vr+yGz/NS2T0WwFR2UB8yYrGIAl8caTI1AmvThU/O0oDOup2I7v0jaMbIy3SQkw0ojiP
 Ds/7RfoclwCO1U/qDaxf6LE60cseqFAMdySG/Yao+ONiN2dVJ7WQKV84+0nTqCTxbBAV
 qT5WWRM/1TGi8zu5awVAT3jFXhyAH0v2sGtNy+JVVr/h+krC7462XtH4LEehKpD3GQQV
 /H/ljM5LJad5BdteE1MJAviD8P079+ORjZBLZ+D1OwOcu74LVZHtu34JTrP1u6/Xf9u3
 f++w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+R8hQyYUGP8SzzR2evtdTJtTEcgyoFT7YOW1pCYOGQdSXLGR431QGt9elX+RdCGCg+7RmM4ky/VvU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxbViH6KuY2al0fjh0hrF0Mb54AFQX2yIYsiJk7GVFtmJNOFHdM
 3faj/m96oNQ81hA5SsOTcQz+y+E0orRp1pNgsnqYqWuD0wRzGbIgQQZANU0wurB2t2cJdDKzmMz
 FC9DDYbko0KFjVNiPxA==
X-Received: from wmer8.prod.google.com ([2002:a05:600c:4348:b0:488:e192:6fb1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:2d4b:b0:489:c57:75da with SMTP id
 5b1f17b1804b1-4890c57760emr302303095e9.31.1777287303305; 
 Mon, 27 Apr 2026 03:55:03 -0700 (PDT)
Date: Mon, 27 Apr 2026 10:54:51 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHtA72kC/0XMQQrDIBCF4auEWVeI0jqJVylZGB2ti5pUoxRC7
 l5pCl3+D963Q6YUKIPqdkhUQw5LbMEvHZiHjp5YsK1B9EL2V4HMr6U+mVmiC56hnp3AUaIbLLT
 LmsiF95e7T2cnepWmbuf4R1XXyBvnYviRqeSNzchHo41AbaWqEqbj+ADK3zp0owAAAA==
X-Change-Id: 20260427-gpuvm-config-7abf27967f8d
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2320; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=iC9UKEYFd1hxRN/BBrR4i7U1kEqG/9GdscpolsokoDU=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp70CBb9/adsAFIIObSYbX1ZNaF+oXnWArWBxCj
 xaxSbVnJc6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCae9AgQAKCRAEWL7uWMY5
 RqWtEACALHpNzzwhdlfxjhNjzmy+v3wo3Zf2sOY54zdlI9RRVH6GSyTOT5rEaFUzxp3az68gAQb
 5b7wrFyZEN9vHIAwx+Jv+zJDCuX8jJru4ITocXSrg7J4qD+yVwHKOeYrCpLwDtJDeNAT+JM724s
 z43UNerXJli7UpiArZNXihbDiL4HI5xtXaik4NtWfypz6JkDFTkHx45Brv9jWPRjZRlsAK+DE/4
 IoVbR9CvnYrqCgZlOweuVNl4/gmFVByGIBJSOVrqonrcSoaKLa3ZvxpFUOF/QL1FQd/EGXjFRzf
 SFUn7dbFuRnHJ+DU0pgDlYn54rhei3JFe567gTgJtvoR3kULkRU0ppb/3KAJb/1kWI5E2VwNKh7
 8C65Zi+Y+cuQUO1MpEpY7+XcJAPsbAE33ma9WP6ApoQg5FERjTmPmogiQmedpq89fjLdPpenX17
 lviNOG7bb/IyprxUDiQz26284DsJa7ImMtQNv0PaA7O6updE0CVe6Mi205UqebLIHZQUjiA2hBP
 uNBmBVM61HgctZ2A8+Jvgk35LeBm3XIxkmg9k+6hpUg0fMlrTbOqZdA8zumlbMPmbC9gCh+HXDZ
 L6e4f0bAIWkTAikoQCwhJVzXxHIkuXG8tg6qpE5PnzPn4Oeo9BaA2qY4IPvlXBgWUM954EqgcZH
 30rN2uQjfwTbUVQ==
X-Mailer: b4 0.14.3
Message-ID: <20260427-gpuvm-config-v1-1-8ece03771f8a@google.com>
Subject: [PATCH] drm/gpuvm: rust: add RUST_DRM_GPUVM option to Kconfig
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 "=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
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

Since Rust uses GPUVM via the kernel crate, which is built-in, the GPUVM
module must also be built-in to use GPUVM from Rust. Adjust the Kconfig
settings accordingly.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/gpu/drm/Kconfig      | 7 +++++++
 rust/helpers/drm_gpuvm.c     | 4 ++--
 rust/kernel/drm/gpuvm/mod.rs | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 8f5a8d3012e4..323422861e8f 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -218,6 +218,13 @@ config DRM_GPUVM
 	  GPU-VM representation providing helpers to manage a GPUs virtual
 	  address space
 
+config RUST_DRM_GPUVM
+	bool
+	depends on DRM
+	select DRM_GPUVM
+	help
+	  Choose this if you need GPUVM functions in Rust
+
 config DRM_GPUSVM
 	tristate
 	depends on DRM
diff --git a/rust/helpers/drm_gpuvm.c b/rust/helpers/drm_gpuvm.c
index ca959d9a66f6..4130b6325213 100644
--- a/rust/helpers/drm_gpuvm.c
+++ b/rust/helpers/drm_gpuvm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 
-#ifdef CONFIG_DRM_GPUVM
+#ifdef CONFIG_RUST_DRM_GPUVM
 
 #include <drm/drm_gpuvm.h>
 
@@ -23,4 +23,4 @@ bool rust_helper_drm_gpuvm_is_extobj(struct drm_gpuvm *gpuvm,
 	return drm_gpuvm_is_extobj(gpuvm, obj);
 }
 
-#endif // CONFIG_DRM_GPUVM
+#endif // CONFIG_RUST_DRM_GPUVM
diff --git a/rust/kernel/drm/gpuvm/mod.rs b/rust/kernel/drm/gpuvm/mod.rs
index dc755f248143..ae58f6f667c1 100644
--- a/rust/kernel/drm/gpuvm/mod.rs
+++ b/rust/kernel/drm/gpuvm/mod.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR MIT
 
-#![cfg(CONFIG_DRM_GPUVM = "y")]
+#![cfg(CONFIG_RUST_DRM_GPUVM)]
 
 //! DRM GPUVM in immediate mode
 //!

---
base-commit: 5ba12cca3230f6bee5fe1090a30db6b70733e2c7
change-id: 20260427-gpuvm-config-7abf27967f8d
prerequisite-change-id: 20251128-gpuvm-rust-b719cac27ad6:v6
prerequisite-patch-id: f1f55d8f1e7d6e5378673812830d40a6ab00ac15
prerequisite-patch-id: 69eaacfa09229181832b2c2a19ce1a2f96e5e532
prerequisite-patch-id: 27fb7278e13bb18b493e207720dcad4e41862281
prerequisite-patch-id: 76a7592dd4f4da18243091a615f9a8f8579b5d56
prerequisite-patch-id: 0044f8f6356e6fe0759db08ec663822df204cdad

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

