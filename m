Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E78CD98F2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 171C410F005;
	Wed, 17 Jun 2026 15:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="Mac7bCRa";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80B4110F000
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 15:02:45 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-491609cdd8fso31704245e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1781708564; x=1782313364;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ok+RjE4+w5Tv/U34IMQhdlbVd3kP3wRLvfnVhKYPL2M=;
 b=Mac7bCRaLmfjw+H/NnlQ6x2qGUjOE5DvEneDx5b349Y09DrX/vPPTZM1lRHsX9bldb
 zYeScTWG12RP6MSa4ahjngYLMVHu7i1ecmeu2q5ASwDx/qNjmP5/8P/Kx1DRmip1nDwq
 7eu14Xi4VyAFAnRRktpl5LZqnYSEF3YccgaOCaLAEBP5P77hgoDqR9wBsph2Tb5mKOF/
 emPdDfaP2kNpK7JJNj1c14XRlnTFPAnH5EGplLB6XMmYLQqq9BQ3l3G8+SIV8mb0sAfa
 gzvFN5s8c89dIAEikF0R2+KHrd8GCyo4rg+9Uzxk0gcu/uV4eV8oWD/YjfbGWH3ZBSRO
 ShOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781708564; x=1782313364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ok+RjE4+w5Tv/U34IMQhdlbVd3kP3wRLvfnVhKYPL2M=;
 b=L31snUUN6BSrChqq4TJrFFTPcNs6CyKWXH9dek8na5Zvbcbo6gg3HUBWxsX7db7ZBt
 x8E+G7jHTLmqRLafh489zEJeF2AnXHJQwIDEZrH+jWNmBkgYZ81jTCZ8AHlJeWehd/I7
 mGUuhYP5Jv0wcHiXU23zwkH6jM91GmT+XjOYhltPptKfFQwSvW0Ek2BgjOjBcFY6tnNc
 5ByaRPwDZKs19Z4R9588dAybBYfBDYQ6RVelhxr0Sj8N1tQJaqTrtImcpx0pDx8iA+b0
 puzlrg1WNkDFMFgKSWDPmgB6Uhk1SrwhrKUSp4xYYDHzD9Mhr/rVf6ZW/hrRdC/DbP9G
 +O7g==
X-Gm-Message-State: AOJu0Yw18IdVxJJL7YqmKxM/4PB7YlfK2dw/wlHb/HptvNDo2u9qAyMc
 j4i5VWYI3E1SxWPebfks6FhlB1L1i24NZv9IvC290cQam7xP/x6V6GrNOb9UrAx1kQ3w0CrtoEn
 cHWhgCT59
X-Gm-Gg: Acq92OFIB8nkXAKL6da0070aXFatpVkMlIQXXmrHtPW5CMBO6Daq2q3ozCFUXmqpuVE
 erGW/L6sPILxufKMxn/7PQjDaUh1HMl4TClLM3BHGnbkfXQWM5h2XHMLgA3p1V57W8GQ0isx4YW
 JnG/nAt+YZYzgzp+PlukcznpRKTK1CvtJxJMclbTbJ83QNK/dWyqxIfSDjyieGqkHs8mEPQNvok
 1DTX0By2rFpn4zGN2I0kk19zzIMcuFtb46vr/uVP5HoUZbVztvb+GHsyA/bg4tnpZQS9IBzFKHY
 G6Bfrm6+7e5M9NTtsjYMxMehlEqGG/+wFE9L5lOdh+haoWKfiOSKsxn1QmQKhkABeF8diqs+0E+
 7geAt/7IyRgNVWIakhdDiUFc7lHHPLdQN8sjS5BVmW9KIYr6n+SqZ0FHM1+pzB+eKqlp8DTANgI
 ipGj66/K497zlF8LCQ8Bbtdo5TGp9x4a+kskmh8ppFNAdK2u+iZpEIryj/
X-Received: by 2002:a05:600c:8189:b0:490:b355:9c70 with SMTP id
 5b1f17b1804b1-492333aaa9emr69289915e9.11.1781708563939; 
 Wed, 17 Jun 2026 08:02:43 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f1cdsm57264311f8f.11.2026.06.17.08.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 08:02:43 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Asahi Lina <lina+kernel@asahilina.net>, Lorenzo Stoakes <ljs@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/4] rust: drm: expose drm_blend.h and the atomic
 new-CRTC-state accessor
Date: Wed, 17 Jun 2026 16:02:26 +0100
Message-ID: <20260617150232.2210-5-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617150232.2210-1-mike@fireburn.co.uk>
References: <20260617150232.2210-1-mike@fireburn.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Two further KMS binding prerequisites used by the in-tree DisplayLink
DL3 (vino) driver, beyond the simple-display-pipe header set:

- drm_blend.h, for drm_plane_create_rotation_property() and the
  DRM_MODE_ROTATE_* / DRM_MODE_REFLECT_* constants, so a driver can
  attach the standard atomic plane rotation property.

- a rust_helper for drm_atomic_get_new_crtc_state(): it is static
  inline in <drm/drm_atomic.h> and so is not callable from Rust
  directly. It returns a CRTC's new state within an atomic commit
  (NULL when the CRTC is not part of the commit), letting a driver
  inspect the proposed configuration from its mode_config
  atomic_check(). vino uses it to sum the pixel clocks of all heads
  and reject a modeset that would exceed the dock's USB bandwidth.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/drm.c              | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 5b311944cc14..5ff21c33385e 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -31,6 +31,7 @@
 #include <linux/acpi.h>
 #include <linux/gpu_buddy.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
diff --git a/rust/helpers/drm.c b/rust/helpers/drm.c
index 65f3f22b0e1d..5087daa23ed8 100644
--- a/rust/helpers/drm.c
+++ b/rust/helpers/drm.c
@@ -1,11 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_vma_manager.h>
 
 #ifdef CONFIG_DRM
 
+/* Read-only accessor for a CRTC's *new* state within an atomic commit (returns NULL if the CRTC
+ * is not part of the commit). It is static-inline in <drm/drm_atomic.h>, so Rust cannot call it
+ * directly; the vino driver uses it in its combined-bandwidth atomic_check.
+ */
+__rust_helper struct drm_crtc_state *
+rust_helper_drm_atomic_get_new_crtc_state(const struct drm_atomic_commit *state,
+					  struct drm_crtc *crtc)
+{
+	return drm_atomic_get_new_crtc_state(state, crtc);
+}
+
 __rust_helper void rust_helper_drm_gem_object_get(struct drm_gem_object *obj)
 {
 	drm_gem_object_get(obj);
-- 
2.54.0

