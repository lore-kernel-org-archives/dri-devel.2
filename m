Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190B4C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E8E10ED6E;
	Wed, 26 Aug 2026 16:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="NmxI3sdK";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3891B10ED60
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:36:31 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so9411975e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762190; x=1788366990;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r2OHbwXA2OvxO/KGmpi5z3jM0ajQdXHlh6ANlHWfPkU=;
 b=NmxI3sdKNg1oE48QLdezXYBTb/LLmASsuLe/VlQEiNpe+LU74eK4GO4VEX7uoAJRxz
 pXrsPe1/1EfKv6f/sgLKvEtvZRF0KlXzOI6EfSgYN0MVWilH++jHGtnA0ssCOAcVTTxm
 Qx1PJVOqzeDUCoySMr7N3u0RH/+MEmfZC1b32SO+0Ne5SkDjCjuhCuFzaMnTT6TxbA19
 qlWZa/cQH/YnimI1izIL/qWRLNXRpPlv/ce1ga4VdbtJrj6fm0wr5Nk/TSlXelSk5c8D
 9D/3sBNcjayAMwESVneW47EiXi4s+xkdQ0rNeTSBfxSF7MNHDrM46QtFZK24MNb6aL0R
 rYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762190; x=1788366990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=r2OHbwXA2OvxO/KGmpi5z3jM0ajQdXHlh6ANlHWfPkU=;
 b=anCZ9P/91j64/saWrZ4Haw9cV1P4WL1C66U6Rm1Ipnda8z7KXCqDKhS2Vpl9c1EXbr
 YXht3yqYhKRIBYR/h1ahZb7v9SrEY8C2niQ1lXhGpOmUJU65MXnUPVRbUyb9ei1P7q6s
 /je78HM19fW2MO8KAUKO1CfV4i5QBPzjDyxql3PaW8yFaNKA3tPoKkx5a55J+4QKIlSb
 p4mGh89f98aoQnWx2mkYSb8M+rMl5thR7gB9Obigq03HV2wV85YpW9dvJOYid6ikc1b6
 sNbrbFwO+fcOgx4M8sWCpJmSqZ6KJ2IJtFFNFsChwdBkS9w1VQwNx7zvw725YNKR0ahI
 xKbA==
X-Gm-Message-State: AFuF++n7AQoc76H45wclO7GAiFvHbZgH0q7LCLOnufaaAFfhWn/6ZUkx
 O6FHstTEpImPo96ARK7e26t3fSSLakmH10fzKgzYtp20PA3/1iZvBqZio42WodR2mcavrjO/rof
 5uzHCnazx
X-Gm-Gg: AR+sD12KmowuCQAQmhzcu6vIhZVo1+m7tWImO7LQQYlW/yDZG6BUbQGEvaW6sfJ7AU9
 ThxQSRezcudme6xq9FRKtMkamohO52KpUBMf6D+tWjwY0dEgfxTyLzizo2LmkarB8y7z+mHUsMQ
 YfUaMjwEeP8cRWwBHsECDmP8jykS99yDdP/oxnt/zajv+gK4S0qyBb0+V+CCeJVW4QUnXw0YrMn
 /OdyWOi7UXWv1xhNx3WBn3v18R8yWDtBpsfoX7BtvrleKEMBBqvN+07NlUSRe/l/1GlRUI/V2hQ
 69WAlW5vxwvKd43tCkp/aPmikGiOpDy/ZGbxnD82jt2BW1dGQROdpUTy35E+2Y67o6uEVNvVDj5
 lO0Uivmh0XiPJKIdx+6DPt9SPnjvH5Ocl8CJnWuN6dCw5elbYF6as083Yv6XW7/HGhqGdssI57T
 dvYl4/TRMI5xRiyIkh6D3Ct6jleW0vZc8YaynbHCfvy4fQ7xrnV5YjWkvnrPhUUdfdEitKM0pfH
 rEuu8kGajD73/9OzE8iK9UMqYMGmEmLMCdssc+G0GjaO7Q=
X-Received: by 2002:a05:600c:19c6:b0:499:900c:9c69 with SMTP id
 5b1f17b1804b1-499dc7252fcmr78430185e9.9.1787762189623; 
 Wed, 26 Aug 2026 09:36:29 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:36:27 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
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
Subject: [PATCH v3 19/23] rust: drm: expose CRTC mode changes
Date: Wed, 26 Aug 2026 17:31:50 +0100
Message-ID: <20260826163359.4998-20-mike@fireburn.co.uk>
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

Allow Rust DRM drivers to distinguish a modeset or enable transition
from an ordinary atomic page flip. This avoids repeating mode-specific
validation on the page-flip hot path.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/kernel/drm/kms/crtc.rs | 139 +++++++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
index 892f04f04e22..9e888c4e2f68 100644
--- a/rust/kernel/drm/kms/crtc.rs
+++ b/rust/kernel/drm/kms/crtc.rs
@@ -31,6 +31,17 @@
 pub struct ColorLut(bindings::drm_color_lut);
 
 impl ColorLut {
+    /// Build an entry. Mainly useful for tests and for drivers synthesising a ramp.
+    #[inline]
+    pub const fn new(red: u16, green: u16, blue: u16) -> Self {
+        Self(bindings::drm_color_lut {
+            red,
+            green,
+            blue,
+            reserved: 0,
+        })
+    }
+
     /// Red channel value.
     pub fn red(&self) -> u16 {
         self.0.red
@@ -47,6 +58,65 @@ pub fn blue(&self) -> u16 {
     }
 }
 
+/// A colour transformation matrix, as programmed through the CRTC's `CTM` property.
+///
+/// The matrix is applied to the pixel values that the degamma LUT produced, before the gamma LUT:
+///
+/// ```text
+/// out   matrix    in
+/// |R|   |0 1 2|   |R|
+/// |G| = |3 4 5| x |G|
+/// |B|   |6 7 8|   |B|
+/// ```
+#[repr(transparent)]
+pub struct ColorCtm(bindings::drm_color_ctm);
+
+impl ColorCtm {
+    /// Build a matrix from raw S31.32 **sign-magnitude** entries. Mainly useful for tests.
+    #[inline]
+    pub const fn from_raw(matrix: [u64; 9]) -> Self {
+        Self(bindings::drm_color_ctm { matrix })
+    }
+
+    /// The raw matrix, in the UAPI's S31.32 **sign-magnitude** encoding.
+    ///
+    /// Prefer [`Self::coefficient`], which decodes an entry into an ordinary signed value.
+    #[inline]
+    pub fn raw(&self) -> &[u64; 9] {
+        &self.0.matrix
+    }
+
+    /// Return matrix entry `i` as a two's-complement S31.32 fixed-point value, or [`None`] if `i`
+    /// is out of range.
+    ///
+    /// The UAPI encodes these in **sign-magnitude, not two's complement** (bit 63 is the sign and
+    /// the remaining 63 bits are the magnitude), so reading the `u64` as an `i64` silently turns
+    /// every negative coefficient into a huge positive one. Decoding here means no driver has to
+    /// remember that.
+    #[inline]
+    pub fn coefficient(&self, i: usize) -> Option<i64> {
+        let raw = *self.0.matrix.get(i)?;
+        // The magnitude is capped so it always fits a positive i64.
+        let magnitude = (raw & !(1u64 << 63)) as i64;
+        Some(if raw & (1u64 << 63) != 0 {
+            -magnitude
+        } else {
+            magnitude
+        })
+    }
+
+    /// Return all nine coefficients decoded by [`Self::coefficient`].
+    #[inline]
+    pub fn coefficients(&self) -> [i64; 9] {
+        let mut out = [0i64; 9];
+        for (i, o) in out.iter_mut().enumerate() {
+            // The index is in range by construction, so the fallback is unreachable.
+            *o = self.coefficient(i).unwrap_or(0);
+        }
+        out
+    }
+}
+
 /// The main trait for implementing the [`struct drm_crtc`] API for [`Crtc`].
 ///
 /// Any KMS driver should have at least one implementation of this type, which allows them to create
@@ -440,8 +510,28 @@ pub fn new<'a, PrimaryData, CursorData>(
     /// Call this during [`KmsDriver::probe`](crate::drm::kms::KmsDriver::probe), before the device
     /// is registered.
     pub fn enable_gamma(&self, gamma_size: u32) {
+        self.enable_color_mgmt(0, false, gamma_size)
+    }
+
+    /// Enable colour management on this CRTC, creating the `DEGAMMA_LUT`, `CTM` and `GAMMA_LUT`
+    /// properties that userspace can program.
+    ///
+    /// A size of zero suppresses the corresponding LUT property, and `has_ctm` selects whether the
+    /// `CTM` property is created. The programmed values are then readable from the CRTC state via
+    /// [`RawCrtcState::degamma_lut`], [`RawCrtcState::ctm`] and [`RawCrtcState::gamma_lut`].
+    ///
+    /// A driver with no colour hardware can still advertise these and apply them in software while
+    /// it has the pixels; compositors that colour-correct through the CRTC properties (rather than
+    /// by rewriting the framebuffer) otherwise have nowhere to put the correction on such an
+    /// output.
+    ///
+    /// Call this during [`KmsDriver::probe`](crate::drm::kms::KmsDriver::probe), before the device
+    /// is registered.
+    pub fn enable_color_mgmt(&self, degamma_size: u32, has_ctm: bool, gamma_size: u32) {
         // SAFETY: `as_raw()` is a valid, not-yet-registered CRTC.
-        unsafe { bindings::drm_crtc_enable_color_mgmt(self.as_raw(), 0, false, gamma_size) };
+        unsafe {
+            bindings::drm_crtc_enable_color_mgmt(self.as_raw(), degamma_size, has_ctm, gamma_size)
+        };
     }
 }
 
@@ -766,6 +856,12 @@ fn active(&self) -> bool {
         unsafe { (*self.as_raw()).active }
     }
 
+    /// Returns whether the mode or enable state changed in this atomic state.
+    fn mode_changed(&self) -> bool {
+        // SAFETY: The atomic-state API serializes access to this state, including its bitfields.
+        unsafe { (*self.as_raw()).mode_changed() }
+    }
+
     /// Return the display mode programmed into this CRTC state.
     fn mode(&self) -> &DisplayMode {
         // SAFETY: `mode` is embedded in the CRTC state and therefore has the same lifetime. The
@@ -793,6 +889,47 @@ fn gamma_lut(&self) -> Option<&[ColorLut]> {
         // entries valid for the state's lifetime.
         Some(unsafe { core::slice::from_raw_parts(data.cast::<ColorLut>(), n) })
     }
+
+    /// Returns the CRTC's degamma LUT for this state as an array of [`ColorLut`] entries, or
+    /// [`None`] if none is programmed. Requires a non-zero `degamma_size` to have been passed to
+    /// [`UnregisteredCrtc::enable_color_mgmt`].
+    fn degamma_lut(&self) -> Option<&[ColorLut]> {
+        // SAFETY: `as_raw()` is a valid `drm_crtc_state`.
+        let blob = unsafe { (*self.as_raw()).degamma_lut };
+        if blob.is_null() {
+            return None;
+        }
+        // SAFETY: a non-null degamma_lut blob is valid for the state's lifetime.
+        let (data, length) = unsafe { ((*blob).data, (*blob).length) };
+        let n = length / core::mem::size_of::<ColorLut>();
+        if data.is_null() || n == 0 {
+            return None;
+        }
+        // SAFETY: `ColorLut` is transparent over `drm_color_lut`; the blob holds `n` contiguous
+        // entries valid for the state's lifetime.
+        Some(unsafe { core::slice::from_raw_parts(data.cast::<ColorLut>(), n) })
+    }
+
+    /// Returns the CRTC's colour transformation matrix for this state, or [`None`] if none is
+    /// programmed. Requires `has_ctm` to have been passed to
+    /// [`UnregisteredCrtc::enable_color_mgmt`].
+    fn ctm(&self) -> Option<&ColorCtm> {
+        // SAFETY: `as_raw()` is a valid `drm_crtc_state`.
+        let blob = unsafe { (*self.as_raw()).ctm };
+        if blob.is_null() {
+            return None;
+        }
+        // SAFETY: a non-null ctm blob is valid for the state's lifetime.
+        let (data, length) = unsafe { ((*blob).data, (*blob).length) };
+        // DRM validates the blob length when the property is set, but this is the boundary where
+        // a short blob would become an out-of-bounds read of nine u64s.
+        if data.is_null() || length < core::mem::size_of::<ColorCtm>() {
+            return None;
+        }
+        // SAFETY: `ColorCtm` is transparent over `drm_color_ctm`, and the blob is at least that
+        // long and valid for the state's lifetime.
+        Some(unsafe { &*data.cast::<ColorCtm>() })
+    }
 }
 impl<T: AsRawCrtcState> RawCrtcState for T {}
 
