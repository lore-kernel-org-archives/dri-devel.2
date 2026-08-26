Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A93DC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4D1810E31A;
	Wed, 26 Aug 2026 16:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="oWcUhnPh";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C2D10E31A
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:35:23 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so11422625e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762121; x=1788366921;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9SXEytlmX0vpXu3DnyTVijLx/cmaB8yZkZdcl8MvS/s=;
 b=oWcUhnPhWIieK/7RP9mFi45RwKLK0Dl1tdf7UmsHuN4PEEPW7BlYJ+tUZ1A8sIY6Xg
 ukBeyM7o23Q1RnVuqZOeDlbh7npXKvRRQXgi9liNABht88eiUNGDBk9lANqBxORtw4fe
 U8rSsWeBtTKLCebNOevlbuaHj4/AnxiXKs5p4baWXz3VUGN6KVRRkCzfDX/2nq8iMy/x
 6Y2yT73H4/8rAfNbc6NcR8gJuXQbpF9ri88WKNkwcnwsyOA297SjIzGEM+iE9qTJaLJ2
 zdXz29QQ1KrpzK18LpfkGamZGxeodc9EZxctgvTFAhLSRxhbWQeWMsulhR87sf87K2a0
 RocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762121; x=1788366921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9SXEytlmX0vpXu3DnyTVijLx/cmaB8yZkZdcl8MvS/s=;
 b=sc1M7S79wLDb/ArjDwpTFX/HMwJv+OOLnVUX3Rcis8bbZJ342WI4A4v4huRxTPHR+C
 KtwoUc7O7XtkEkPNBRjfrOwAiHMJYWIQPTeibjQyZGrNKqFEZiOcPjxLEuO4d3Tqy5Bd
 Gw2vnsawT1jWmNgnLDKc3vVpjBnJyJdIIP8cm4sMwZXrsOV48JYrnRRu8lHGRoMHHLmU
 aTa0KahxNYe9xovMx5IAuQF1lNeMMoQ9HtQmjk4a7HM6viKofCtW7h4LNL+N8DLBa0Ur
 S+FuDhe58LJ4r8+06rDe4i+nh9AsMW9kg3MD2zP1bIXYF/0uharj/+qNBSUu12LmxOr4
 P4Xw==
X-Gm-Message-State: AFuF++nLHR/9Y4DSIHZdqSfVZPdQJZBj5P2+ITW6j68H4kGWeZ/KQN/g
 9SfbQy5nXD10873QQgr2Zp1p3kiqUBvchPA4GdhEsu67+TgQfjjFQ8tExDbJKyKyGBmBxUC0Hbh
 q+l9AQLv/
X-Gm-Gg: AR+sD13Y5ewXLuQGNCYly0gZYCJA/u02tWRsIMfzyqEMtCdGpniGetCjXFk36ITemAV
 xRG3L4VpMMqD3P2yiURxnL5iQywCEXa8PuntKKpnC5LJtkBTaWCXF7mTeaMDXsYZnhV2mj3gjDV
 WKmm6B1MX0wzIB0lqGmtyiCxXwVsO7peN1FmNeWsKw5zQy0Ill2NZdcV0XCrouI87fQ1S4RxJFt
 yGV2i3Dz3+tT7LPSi6eSP2f+0+C9qM2AKrafMoWMx4PL/wAWLUiDsLR3N1/+KQbr5uasZ2HRdZO
 AUlfXWZNRF9q2L29b/QWI1LLTn0ova7OVb7blCrZKGit8YCoYSlzBbKGG9nrIhIjqRZzCCjsU4O
 utjCCJUx4wOSYeqN8Izq1Vdpno5AzWAbxW30+30gVswTFwmiDRqmW2dMGr7RNzMfZBGioUNN6pQ
 I4xHKdxItPvpfhK+hh0EILa22hUxVy0dTB+gzLIm0LME14Wcm/wk4ZiwyA02bBYsHgbFYr1UNM7
 /I/ts+EceXTNtyr0Vx939/KVA7DSjTQcIQx
X-Received: by 2002:a05:600c:4585:b0:499:db6c:6abd with SMTP id
 5b1f17b1804b1-499dc6f3200mr70550645e9.2.1787762121399; 
 Wed, 26 Aug 2026 09:35:21 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:35:20 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lyude Paul <lyude@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Asahi Lina <lina+kernel@asahilina.net>, Burak Emir <bqe@google.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/23] rust: drm: kms: add typed color and rotation
 properties
Date: Wed, 26 Aug 2026 17:31:38 +0100
Message-ID: <20260826163359.4998-8-mike@fireburn.co.uk>
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

Add typed KMS property support for CRTC gamma lookup tables and
plane rotation.

ColorLut exposes validated drm_color_lut entries without generated
bindings. Rotation represents only combinations accepted by the DRM
rotation property, while the plane state accessors expose placement
and cursor-hotspot coordinates needed by software and transport
scanout drivers.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/drm/kms/crtc.rs     | 53 ++++++++++++++++++
 rust/kernel/drm/kms/plane.rs    | 95 +++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ae3017539767..38ad80fae0ed 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -37,6 +37,7 @@
 #include <drm/display/drm_hdcp.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_blend.h>
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
index a3217f8c55e8..a7024d8921ca 100644
--- a/rust/kernel/drm/kms/crtc.rs
+++ b/rust/kernel/drm/kms/crtc.rs
@@ -25,6 +25,27 @@
 };
 use macros::vtable;
 
+/// One entry in a DRM gamma or degamma lookup table.
+#[repr(transparent)]
+pub struct ColorLut(bindings::drm_color_lut);
+
+impl ColorLut {
+    /// Red channel value.
+    pub fn red(&self) -> u16 {
+        self.0.red
+    }
+
+    /// Green channel value.
+    pub fn green(&self) -> u16 {
+        self.0.green
+    }
+
+    /// Blue channel value.
+    pub fn blue(&self) -> u16 {
+        self.0.blue
+    }
+}
+
 /// The main trait for implementing the [`struct drm_crtc`] API for [`Crtc`].
 ///
 /// Any KMS driver should have at least one implementation of this type, which allows them to create
@@ -357,6 +378,17 @@ pub fn new<'a, PrimaryData, CursorData>(
         // SAFETY: We just allocated the crtc above, so this pointer must be valid
         Ok(unsafe { &*this })
     }
+
+    /// Enable colour management on this CRTC, creating a `GAMMA_LUT` property of `gamma_size`
+    /// entries that userspace can program (no degamma LUT, no CTM). The set LUT is then readable
+    /// from the CRTC state via [`RawCrtcState::gamma_lut`].
+    ///
+    /// Call this during [`KmsDriver::probe`](crate::drm::kms::KmsDriver::probe), before the device
+    /// is registered.
+    pub fn enable_gamma(&self, gamma_size: u32) {
+        // SAFETY: `as_raw()` is a valid, not-yet-registered CRTC.
+        unsafe { bindings::drm_crtc_enable_color_mgmt(self.as_raw(), 0, false, gamma_size) };
+    }
 }
 
 // SAFETY: We inherit all relevant invariants of `Crtc`
@@ -686,6 +718,27 @@ fn mode(&self) -> &DisplayMode {
         // atomic-state API serializes access while the mode can be changed.
         unsafe { DisplayMode::as_ref(core::ptr::addr_of!((*self.as_raw()).mode)) }
     }
+
+    /// Returns the CRTC's gamma LUT for this state as an array of [`ColorLut`] entries, or
+    /// [`None`] if no gamma LUT is programmed. Requires gamma to have been enabled on the CRTC
+    /// (see [`UnregisteredCrtc::enable_gamma`]).
+    ///
+    fn gamma_lut(&self) -> Option<&[ColorLut]> {
+        // SAFETY: `as_raw()` is a valid `drm_crtc_state`.
+        let blob = unsafe { (*self.as_raw()).gamma_lut };
+        if blob.is_null() {
+            return None;
+        }
+        // SAFETY: a non-null gamma_lut blob is valid for the state's lifetime.
+        let (data, length) = unsafe { ((*blob).data, (*blob).length) };
+        let n = length / core::mem::size_of::<ColorLut>();
+        if data.is_null() || n == 0 {
+            return None;
+        }
+        // SAFETY: `ColorLut` is transparent over `drm_color_lut`; the blob holds `n` contiguous
+        // entries valid for the state's lifetime.
+        Some(unsafe { core::slice::from_raw_parts(data.cast::<ColorLut>(), n) })
+    }
 }
 impl<T: AsRawCrtcState> RawCrtcState for T {}
 
diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index 3a95c45b6728..8e3f711b0767 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -25,6 +25,72 @@
     ptr::{null, null_mut, NonNull},
 };
 
+/// Plane rotation and reflection properties.
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+pub struct Rotation(u32);
+
+impl Rotation {
+    /// No rotation.
+    pub const ROTATE_0: Self = Self(bindings::DRM_MODE_ROTATE_0);
+    /// Rotate clockwise by 90 degrees.
+    pub const ROTATE_90: Self = Self(bindings::DRM_MODE_ROTATE_90);
+    /// Rotate clockwise by 180 degrees.
+    pub const ROTATE_180: Self = Self(bindings::DRM_MODE_ROTATE_180);
+    /// Rotate clockwise by 270 degrees.
+    pub const ROTATE_270: Self = Self(bindings::DRM_MODE_ROTATE_270);
+    /// Reflect across the X axis after rotation.
+    pub const REFLECT_X: Self = Self(bindings::DRM_MODE_REFLECT_X);
+    /// Reflect across the Y axis after rotation.
+    pub const REFLECT_Y: Self = Self(bindings::DRM_MODE_REFLECT_Y);
+
+    /// Return whether every bit in `other` is set.
+    pub const fn contains(self, other: Self) -> bool {
+        self.0 & other.0 == other.0
+    }
+
+    /// Return the selected rotation without reflection bits.
+    pub const fn angle(self) -> Self {
+        Self(self.0 & bindings::DRM_MODE_ROTATE_MASK)
+    }
+
+    fn bits(self) -> u32 {
+        self.0
+    }
+}
+
+impl BitOr for Rotation {
+    type Output = Self;
+
+    fn bitor(self, rhs: Self) -> Self::Output {
+        Self(self.0 | rhs.0)
+    }
+}
+
+/// Supported plane pixel-blend modes.
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+pub struct BlendModes(u32);
+
+impl BlendModes {
+    /// Source pixels are premultiplied by alpha.
+    pub const PREMULTIPLIED: Self = Self(1 << bindings::DRM_MODE_BLEND_PREMULTI);
+    /// Source pixels provide straight alpha coverage.
+    pub const COVERAGE: Self = Self(1 << bindings::DRM_MODE_BLEND_COVERAGE);
+    /// Ignore per-pixel alpha.
+    pub const PIXEL_NONE: Self = Self(1 << bindings::DRM_MODE_BLEND_PIXEL_NONE);
+
+    fn bits(self) -> u32 {
+        self.0
+    }
+}
+
+impl BitOr for BlendModes {
+    type Output = Self;
+
+    fn bitor(self, rhs: Self) -> Self::Output {
+        Self(self.0 | rhs.0)
+    }
+}
+
 /// The main trait for implementing the [`struct drm_plane`] API for [`Plane`].
 ///
 /// Any KMS driver should have at least one implementation of this type, which allows them to create
@@ -350,6 +416,28 @@ pub fn new<'a>(
         // SAFETY: We just allocated the plane above, so this pointer must be valid
         Ok(unsafe { &*this })
     }
+
+    /// Attach a rotation property to this plane, advertising `supported_rotations` (a bitmask of
+    /// `DRM_MODE_ROTATE_*` | `DRM_MODE_REFLECT_*`) with initial value `default_rotation`. The
+    /// selected value is then readable from the plane state via
+    /// [`RawPlaneState::rotation`](crate::drm::kms::plane::RawPlaneState::rotation).
+    ///
+    /// Call this during [`KmsDriver::probe`](crate::drm::kms::KmsDriver::probe), before the device
+    /// is registered.
+    pub fn create_rotation_property(
+        &self,
+        default_rotation: Rotation,
+        supported_rotations: Rotation,
+    ) -> Result {
+        // SAFETY: `as_raw()` is a valid, not-yet-registered plane.
+        to_result(unsafe {
+            bindings::drm_plane_create_rotation_property(
+                self.as_raw(),
+                default_rotation.bits(),
+                supported_rotations.bits(),
+            )
+        })
+    }
 }
 
 /// A trait implemented by any type that acts as a [`struct drm_plane`] interface.
@@ -627,6 +715,13 @@ fn crtc_h(&self) -> u32 {
         self.as_raw().crtc_h
     }
 
+    /// The plane's rotation/reflection (`DRM_MODE_ROTATE_*` | `DRM_MODE_REFLECT_*` bitmask), for a
+    /// plane with a rotation property (see
+    /// [`UnregisteredPlane::create_rotation_property`]). Defaults to `DRM_MODE_ROTATE_0`.
+    fn rotation(&self) -> Rotation {
+        Rotation(self.as_raw().rotation)
+    }
+
     /// Return the current [`OpaqueCrtc`] assigned to this plane, if there is one.
     ///
     /// The returned CRTC reference cannot outlive the plane-state borrow:
