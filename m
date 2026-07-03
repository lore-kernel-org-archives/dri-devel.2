Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB7DC43327
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:02:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F37B410F609;
	Fri,  3 Jul 2026 03:02:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="MYf+TNgk";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CD6F10F609
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:02:13 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4631679f204so721667f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047731; x=1783652531;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TbX8MznRE/lSK8zDxNF2GQ6yML1Vz7QFki+Q6IYGOU=;
 b=MYf+TNgk2ePYnumJCI1gLpAhj8HZ6gbort/G655clRccX35YVV6cwteJyu9S3NqgBW
 FEyhA6ueBYIRkjOwcOFVeiIwkVpI+Ok0NuNk1I7Uszx0X4Nw87s/50qn5WBdlu/s0IJk
 Cr/Hevqg/XpBZR5P+dQZNAxvNLOcDijmWj7dP9b6uTQrQccxZYM78k8c4GLoiZd2Hd5X
 BonCSS5zuSudH7fagkGXhhA3WD+/xT82PvXphxwi73trLNwURaT06+Px/DWopSFlUZEz
 YG8iMzDJLTGzSYy/94TcjAF1XcxoOgKCflasr6D1BIBo3+pihHUmj/EHqDGJ12RdkBDo
 SnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047731; x=1783652531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4TbX8MznRE/lSK8zDxNF2GQ6yML1Vz7QFki+Q6IYGOU=;
 b=jNXyW59PP1ZaJwcgV2QNp3Ezi8FBX0VWor7c7SN8SRmzvi8H9jirb3hszdhLB6SFQg
 r2YD2n/rgASQrVJz1pocx3VDzMpYya/KFFxk48JM/rFj+sotRjnAzPY++er22ZOzm49L
 STIQyEoyY47aymiP0eBLLsuSK9hyMy5C4Tk1yA9AHMgdJbSBtilf0eyPFIMCztci8auh
 Kr9FipQG6YELQm6jarWgA36KOzTYbx7M79KyjEgkcso77vzDhv2j9OK/OLF3LrIr5K1T
 7hqmtl6MsqzA/FS+KS3sqeFGVJXM08F6GLTWrJbN9ZLWzO9VxwPUpHcJ0qg/KrVBOiU8
 QVNQ==
X-Gm-Message-State: AOJu0YzQBlFTtNXIpgR5QNNhIdwXZ95eOgwrGB05U0GZJXpyWNNzkqqO
 tt09Wq8ZKXyAhxEHTtvJ3/RRfyucNKNL7h60Q89E7ykttzwcn5eMREIxLr//kT30Aw==
X-Gm-Gg: AfdE7ckR0UA0jKT1BJ252fVi+MS/mGcV/AOUchJKvVldw6/mbMGg0PnhGiczJnMTrCo
 RhPDIgmGeWMGxDgEp/zU1ZnVEp6ZXR4eJ3bs9hM4hpZuFaUDdw7ABktZGVfI4oOPPdggJSkn0gy
 FRlc/j6w8ngw5Zw5nQiHaLZq8ruskotAuyJdpDmvKOmh5d6vmpHSE6JfQq+vKF9cAh36SYin2kS
 jPoOAyzQGG88ZweLQwrRcRNi2sGkhWFVbM3CP4y+xjMA0I/37dZFbDkPLAouN6Lqp1rAc9wXyDp
 e6zYbsOwUlN9rU20yDiKzrOVnZuUNiokFC99K7FsKg9akPud3KvAhB6D/3vHXsU/7wCqcuL56j4
 RsmXTs+EVAcYKaDq7HtFiw/LPNane1rB8rXshVmEZgxrS4Ba3TSKjCh9Jfyr2Vei4sHLpfu/n5N
 9S9tcn1NVC6IeM0nqgI3gvzi6+VyCrCTn/+QQXG/X9rb94Eo9d54xabrJH
X-Received: by 2002:a05:6000:41fe:b0:46f:8561:fe60 with SMTP id
 ffacd0b85a97d-4793685fe58mr3081792f8f.17.1783047731472; 
 Thu, 02 Jul 2026 20:02:11 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14466500f8f.4.2026.07.02.20.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:02:09 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: rust-for-linux@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>
Subject: [RFC PATCH v2 16/18] rust: drm: add CRTC gamma LUT and plane rotation
 property bindings
Date: Fri,  3 Jul 2026 04:01:03 +0100
Message-ID: <20260703030123.2814-17-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703030123.2814-1-mike@fireburn.co.uk>
References: <20260617150232.2210-1-mike@fireburn.co.uk>
 <20260703030123.2814-1-mike@fireburn.co.uk>
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

Two more mode-object properties a real driver reaches for, and the last
the DisplayLink vino driver needs to match its pre-safe-KMS feature set:

  - CRTC gamma: UnregisteredCrtc::enable_gamma()
    (drm_crtc_enable_color_mgmt, creating a GAMMA_LUT property) and
    RawCrtcState::gamma_lut() to read the set ramp back as a
    &[drm_color_lut].

  - Plane rotation: UnregisteredPlane::create_rotation_property()
    (drm_plane_create_rotation_property) and RawPlaneState::rotation() /
    crtc_x()/crtc_y()/hotspot_x()/hotspot_y() to read the plane's
    placement and orientation.

drm_plane_create_rotation_property lives in <drm/drm_blend.h>, so add
that to bindings_helper.h.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/drm/kms/crtc.rs     | 33 +++++++++++++++++++++++++++++++++
 rust/kernel/drm/kms/plane.rs    | 29 +++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index e5cfda610781..7d04abec1215 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -39,6 +39,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_blend.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder.h>
 #include <drm/drm_framebuffer.h>
diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
index fbe113676e2f..b5128ae1ca95 100644
--- a/rust/kernel/drm/kms/crtc.rs
+++ b/rust/kernel/drm/kms/crtc.rs
@@ -356,6 +356,17 @@ pub fn new<'a, 'b: 'a, PrimaryData, CursorData>(
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
@@ -686,6 +697,28 @@ fn mode(&self) -> &DisplayMode {
         // interface can ensure this access is serialized.
         unsafe { DisplayMode::as_ref(&(*self.as_raw()).mode) }
     }
+
+    /// Returns the CRTC's gamma LUT for this state as an array of [`drm_color_lut`] entries, or
+    /// [`None`] if no gamma LUT is programmed. Requires gamma to have been enabled on the CRTC
+    /// (see [`UnregisteredCrtc::enable_gamma`]).
+    ///
+    /// [`drm_color_lut`]: bindings::drm_color_lut
+    fn gamma_lut(&self) -> Option<&[bindings::drm_color_lut]> {
+        // SAFETY: `as_raw()` is a valid `drm_crtc_state`.
+        let blob = unsafe { (*self.as_raw()).gamma_lut };
+        if blob.is_null() {
+            return None;
+        }
+        // SAFETY: a non-null gamma_lut blob is valid for the state's lifetime.
+        let (data, length) = unsafe { ((*blob).data, (*blob).length) };
+        let n = length / core::mem::size_of::<bindings::drm_color_lut>();
+        if data.is_null() || n == 0 {
+            return None;
+        }
+        // SAFETY: the blob's `data` holds `n` contiguous `drm_color_lut` entries (the blob length
+        // is a multiple of the entry size), valid for the state's lifetime.
+        Some(unsafe { core::slice::from_raw_parts(data.cast::<bindings::drm_color_lut>(), n) })
+    }
 }
 impl<T: AsRawCrtcState> RawCrtcState for T {}
 
diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index fcaa8ba550fe..ead875316829 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -328,6 +328,28 @@ pub fn new<'a, 'b: 'a>(
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
+        default_rotation: u32,
+        supported_rotations: u32,
+    ) -> Result {
+        // SAFETY: `as_raw()` is a valid, not-yet-registered plane.
+        to_result(unsafe {
+            bindings::drm_plane_create_rotation_property(
+                self.as_raw(),
+                default_rotation,
+                supported_rotations,
+            )
+        })
+    }
 }
 
 /// A trait implemented by any type that acts as a [`struct drm_plane`] interface.
@@ -625,6 +647,13 @@ fn hotspot_y(&self) -> i32 {
         self.as_raw().hotspot_y
     }
 
+    /// The plane's rotation/reflection (`DRM_MODE_ROTATE_*` | `DRM_MODE_REFLECT_*` bitmask), for a
+    /// plane with a rotation property (see
+    /// [`UnregisteredPlane::create_rotation_property`]). Defaults to `DRM_MODE_ROTATE_0`.
+    fn rotation(&self) -> u32 {
+        self.as_raw().rotation
+    }
+
     /// Return the current [`OpaqueCrtc`] assigned to this plane, if there is one.
     fn crtc<'a, 'b: 'a, D>(&'a self) -> Option<&'b OpaqueCrtc<D>>
     where
-- 
2.55.0

