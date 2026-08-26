Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51E8C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C3C10ED4A;
	Wed, 26 Aug 2026 16:36:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="UnBxBrYi";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD3610ED4A
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:36:02 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so9407495e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762160; x=1788366960;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0nvAIuzjWICzRaerW41m6ADpOsCWM5ip30oIcAiVpx0=;
 b=UnBxBrYiQbJSAtqgAy37/sVLdAix9CX7XaEJmVPSMT5lzluWarLl+zeN60oHCBDCtj
 NPB9YL8nnGCZ7FTFXzvg+4GdD21gXiF+Mo/7SA36t5YfIYxZk6bZdjSPrKLARO5AAtEd
 H+8WMU+i4xm0dmbZ6SoZXTosxWlXY0YP0r03OynbvopMU9yrM8yLIxxkUMdQ95/5RGeS
 b7Rpfd0T/naB3Abwprc+9IAYP2T2kePEmMj7WsVjPN+HQPGpIn/a2A1El7NbHGMPMxzQ
 0MunIvt1/BMidQO/M5W48v5BhKgVOHB19aAf6QVATuhQl7wpF8ULEQ5FBtFrE3F1MT9Q
 hhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762160; x=1788366960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0nvAIuzjWICzRaerW41m6ADpOsCWM5ip30oIcAiVpx0=;
 b=g4jpHMuv1dZp/Mhii8Z3JuFvZI4AAbyk4sY0uZI7Gd6aooY2mVAO3PH3VOgrMSipTT
 PVKgOsLEUy4jOqpp10gG1GOElWYVwGkcm4vZvG5NreRKbVMDyNCje/DLMxby7Sccj4Rl
 k/gOJM5Hk9hE4LaAkFPOuqhJSG2kxviZ6sDFLT9hzULIbUdVxp2eErkAlO4PWWY6HpQD
 /D5qLof0tfxv5BulO8CxL9CM8xTmgTe1WGdgPnR3n3cKimMJTYMbFNfdBqt7mASrLWPc
 MH5ZoTcN35GFqOxB9+SBOfRV7P8shWUNiMvDl3fc/dmVy2/036JOags5wEdbk65v7ylF
 yEWQ==
X-Gm-Message-State: AFuF++nG+ddQod1ahWxxogvBIbqXRS5iKZ1fBX64xWB2IKNcyuyJ05cg
 +KO5sbOeHV2LSl3mtyFFOlM0pS4K/aiajhbWVIZr5CdO/LwaxvQw6b4dxq2/CsEDGQoSQcz64bG
 NN4Rn3A==
X-Gm-Gg: AR+sD13M05nFGDumtpXD5ylV2Q+/IoToAHUoOJ31RCM6jW389BRxtyzzehV3w1oeYO5
 YzrhhbP5iMhu0wQnmjEtA9dmFZrMqGTKANcz0aANhWZzUypISh/lv4mLPyQJG2lExQ0IWL0hAnu
 iBeUtTkfY1ZDCwM+7zc9AU827X5OCjZpaEdMaQRSaRhAhi7WiIUybL/uQptcVCE7DY5BiwJ6u3t
 0OxPhSbaUfJWx2fU4NYrQ+knh3OGzO/6Is6mTDWGRVNOWQyLMVAkTLM7GI0mLmIoFLCXRtmn6/R
 NNQzQTv0L+ETRUV/Xyfu7zEgloSeSMbH+AvBjTsvJyBkKMfXi5X4Qucon9o8K4PNJ8pg7DsfrC9
 qbnVKSNEjGes6ORAK4pmKlp/vnW87rdi/kaPsdTmvbV6qtC6WeL2gO8wdCoYEMNWQE7uM93AZds
 bMd6342Clr+JQz8IRt7GaH1lRWxa8xKBj3ECvys56CpDaGxGSuVUX7VJDurCF9QxpMC9OiijnBM
 b2ih98GS1gsIGA=
X-Received: by 2002:a05:600c:4503:b0:499:8b13:3a98 with SMTP id
 5b1f17b1804b1-499dc6f6856mr83360345e9.4.1787762160620; 
 Wed, 26 Aug 2026 09:36:00 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:36:00 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/23] rust: drm: kms: plane: add FB_DAMAGE_CLIPS property
 support
Date: Wed, 26 Aug 2026 17:31:44 +0100
Message-ID: <20260826163359.4998-14-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826163359.4998-1-mike@fireburn.co.uk>
References: <20260826163359.4998-1-mike@fireburn.co.uk>
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

Userspace can only hand a driver the rectangles that actually changed
between two framebuffers if the plane advertises the FB_DAMAGE_CLIPS
property. Without it a compositor supplies nothing, and unchanged
commits are indistinguishable from missing damage information --
which forces a driver either to freeze or to re-send whole frames.

That matters most for drivers uploading their scanout over a slow link.
Wrap `drm_plane_enable_fb_damage_clips()` so a plane can attach
the property before registration, alongside the existing rotation
property helper.

The consumer is the vino DisplayLink driver, which encodes and sends
only the changed strips of each frame over USB.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/kernel/drm/kms/plane.rs | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index bc830503b142..62de8a1dad19 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -438,6 +438,27 @@ pub fn create_rotation_property(
             )
         })
     }
+
+    /// Attaches the `FB_DAMAGE_CLIPS` property to this plane.
+    ///
+    /// Userspace can then hand the driver the list of rectangles that actually changed between two
+    /// framebuffers, instead of leaving it to infer damage from a buffer swap. Drivers that upload
+    /// their scanout over a slow link -- USB display adapters especially -- need this to send only
+    /// the changed regions.
+    ///
+    /// Without the property attached, a compositor cannot supply clips at all: unchanged commits
+    /// arrive with an empty list, which is indistinguishable from "no damage information".
+    ///
+    /// The clips are read back through
+    /// [`RawPlaneState::damage_clips`](crate::drm::kms::plane::RawPlaneState::damage_clips).
+    ///
+    /// Call this during [`KmsDriver::create_objects`](crate::drm::kms::KmsDriver::create_objects),
+    /// before the device is registered.
+    pub fn enable_fb_damage_clips(&self) {
+        // SAFETY: `as_raw()` is a valid, not-yet-registered plane; attaching a property before
+        // registration is exactly what this helper is for.
+        unsafe { bindings::drm_plane_enable_fb_damage_clips(self.as_raw()) }
+    }
 }
 
 /// A trait implemented by any type that acts as a [`struct drm_plane`] interface.
