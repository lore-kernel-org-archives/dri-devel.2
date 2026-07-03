Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F287C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:01:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8A6610F5FF;
	Fri,  3 Jul 2026 03:01:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="MkvJdldK";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F38310F5FD
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:01:50 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493c83474ddso414545e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047709; x=1783652509;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9gvG7drN2QAfRGCCu8odT8w4W0DWwcbaOn1tC3EwTHo=;
 b=MkvJdldK6db2P0dbtMEnUKT2P22U6KBpg+nP04l8/cDM26Oa2ZYDQU0/VYPJcUf2qC
 +ZRIhUzTNIMsGtH5bwjuOamm3NjGN32zLihSSX4qLfk4mJoA1IVoq/ZdWmzz+44JyX9m
 BsXIl7cOHB0NASFxTbA3RoNtCHNGHZqcsbp9rZJE7lx/Pa4z1Fxp3T6CEJy2M+wdT6Fu
 j6LYeOVSM4P8C9xLVAEFLBuTFe88Gh2XKGBdQOxaFc86QvuPCUV1obn8VO3g0y1fIYvv
 /S2AagPNjxxFy8C3CDzO7PdwKi8hj8SU5k0ZO3nWarWr2Q0Ap/psS67kpD90qLk6VNJF
 SqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047709; x=1783652509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9gvG7drN2QAfRGCCu8odT8w4W0DWwcbaOn1tC3EwTHo=;
 b=pCfMJgOE2hW9+Ob8Jy3gZ4BSqMDaMMUPmV/VHzB1+tXQKD/HUXWXEhuUSK+sL6mDUe
 MBv8A0IKdtDEmsITbx2LJZWUbUA9rw+vY6/nB0crBTVDSlEhJqNy1v8U498YMx6kD5B+
 LP4DB8yGGNmlD+j2DbGRTFVPo5WXHtuMEvPfFB23BLugVYWNDnPtY5677fTfp7HylYLc
 bgjeJ6W3bIrVB5p62SVJgi4GnIKzRAqZin8m1L9URRxfKs4kPmN9o3HDrfTiFlbXWi7K
 o/6zBYJhQe5bH1WdAJYeaQ0L+SNepA3894QSbo58Gl/y+JHu2HAT7OPsxFRcEf+cO7Yu
 50Bw==
X-Gm-Message-State: AOJu0YzX95FIJ9Li6MDME0T0K/8mK/W5FSRC+bWs2KL73ZhrUGfVmWMd
 Jkn0eTimu2i8yBEjAPAQ9+Gze9daARwpKrViVlZXm0ly8uEjwaXACKfz4F5xGYrxow==
X-Gm-Gg: AfdE7cmIjShG+WxyETmuj6rZWiEtYSoWWdBszseT5OpB619/Yu1H3La5GeRHwwg7H5f
 FGX0wljDzqg/J5/Noxuc2CWw/ectdSPAXdMBy0YDCHZq55Q45BKN1WLJQkHKd4cIT+d17MNTUN8
 biikH95okqGS7XSvY3Z6To8chRSaMoX5prV0XuKiEov2hDfjQRF9XKsGm/yYVpB9LlT+g+hpiVl
 MqJ7DhTxGuiAxH29kECnobuOzFyojQTLihmouiRkQzRv0peLLPolQE1+LsTzbOfCZJ+0KtESSPA
 85KHESfznUvTSvBdiCg3k2fT2E3t55kZcC1FnsZxVnaWc3rWa2iAHhQRQ22L5U9Isq2vBjbf50F
 5DNaHWALg+ahQGIcZ1yz007PJ15g6VA3w0obKrAsmVNC7HuzPthoLVJTfN3WsHUvhA8t/JjXGML
 viiLVO91goVg9hqQBSJVK5GMkagKqhsSAgL5HXA5BuZImi9RfPY+QX5Tjw
X-Received: by 2002:a05:600c:34c8:b0:493:c2e3:b2c1 with SMTP id
 5b1f17b1804b1-493c3df75ebmr115041365e9.33.1783047708439; 
 Thu, 02 Jul 2026 20:01:48 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14466500f8f.4.2026.07.02.20.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:01:47 -0700 (PDT)
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
Subject: [RFC PATCH v2 07/18] rust: drm: kms: add safe accessors for common
 state and connector modes
Date: Fri,  3 Jul 2026 04:00:54 +0100
Message-ID: <20260703030123.2814-8-mike@fireburn.co.uk>
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

Add safe wrappers for the handful of raw drm_kms fields and helpers a
real KMS driver reaches for, so drivers need no raw escape hatch:

  - drm::Device::hotplug_event() wraps drm_kms_helper_hotplug_event().
  - RawCrtcState::mode() returns the state's programmed DisplayMode.
  - DisplayMode gains hdisplay()/hsync_start()/hsync_end()/htotal()/
    vdisplay()/vsync_start()/vsync_end()/vtotal()/clock()/vrefresh().
  - RawPlaneState::crtc_w()/crtc_h() return the destination rectangle.
  - ConnectorGuard::add_edid_modes() parses an EDID blob, updates the
    connector and adds its modes (the safe counterpart to the existing
    add_modes_noedid()).

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-sonnet-5 [Claude-Code]
---
 rust/kernel/drm/kms.rs           | 12 ++++++
 rust/kernel/drm/kms/connector.rs | 20 +++++++++
 rust/kernel/drm/kms/crtc.rs      | 13 +++++-
 rust/kernel/drm/kms/modes.rs     | 70 ++++++++++++++++++++++++++++++++
 rust/kernel/drm/kms/plane.rs     | 10 +++++
 5 files changed, 123 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/drm/kms.rs b/rust/kernel/drm/kms.rs
index 7c7e1d59c892..7207466094e7 100644
--- a/rust/kernel/drm/kms.rs
+++ b/rust/kernel/drm/kms.rs
@@ -114,6 +114,18 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
+impl<T: KmsDriver, C: DeviceContext> Device<T, C> {
+    /// Send a hotplug uevent to userspace, prompting it to re-probe connector state.
+    ///
+    /// A thin safe wrapper over `drm_kms_helper_hotplug_event()`, for drivers that detect a
+    /// connection change out of band (for example a dock delivering an EDID after bring-up).
+    pub fn hotplug_event(&self) {
+        // SAFETY: `self.as_raw()` is our live `drm_device`; a KMS driver has the KMS helper
+        // state this call requires.
+        unsafe { bindings::drm_kms_helper_hotplug_event(self.as_raw()) };
+    }
+}
+
 /// A trait which must be implemented by drivers that wish to support KMS
 ///
 /// It should be implemented for the same type that implements [`Driver`]. Drivers which don't
diff --git a/rust/kernel/drm/kms/connector.rs b/rust/kernel/drm/kms/connector.rs
index 1c7c7b586340..591153de7ab4 100644
--- a/rust/kernel/drm/kms/connector.rs
+++ b/rust/kernel/drm/kms/connector.rs
@@ -574,6 +574,26 @@ pub fn set_preferred_mode(&self, (h_pref, w_pref): (u32, u32)) {
         // SAFETY: We hold the locks required to call this via our type invariants.
         unsafe { bindings::drm_set_preferred_mode(self.as_raw(), h_pref, w_pref) }
     }
+
+    /// Parse a raw EDID blob, update the connector's display information from it, and add the
+    /// modes it advertises to the connector's mode list.
+    ///
+    /// Returns how many modes were added (0 if the blob is rejected).
+    pub fn add_edid_modes(&self, edid: &[u8]) -> i32 {
+        // SAFETY: `edid` is a valid byte buffer of `edid.len()` bytes; `drm_edid_alloc` copies it.
+        let drm_edid = unsafe { bindings::drm_edid_alloc(edid.as_ptr().cast(), edid.len()) };
+        if drm_edid.is_null() {
+            return 0;
+        }
+        // SAFETY: We hold the locks required via our type invariants; `drm_edid` was just
+        // allocated above.
+        unsafe { bindings::drm_edid_connector_update(self.as_raw(), drm_edid) };
+        // SAFETY: Same invariants; adds the EDID-derived modes and returns the count.
+        let n = unsafe { bindings::drm_edid_connector_add_modes(self.as_raw()) };
+        // SAFETY: `drm_edid` was allocated by `drm_edid_alloc` above and is no longer needed.
+        unsafe { bindings::drm_edid_free(drm_edid) };
+        n
+    }
 }
 
 /// A trait implemented by any type which can produce a reference to a
diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
index 9b43501bfb58..fbe113676e2f 100644
--- a/rust/kernel/drm/kms/crtc.rs
+++ b/rust/kernel/drm/kms/crtc.rs
@@ -5,8 +5,8 @@
 //! C header: [`include/drm/drm_crtc.h`](srctree/include/drm/drm_crtc.h)
 
 use super::{
-    atomic::*, plane::*, vblank::*, KmsDriver, ModeObject, ModeObjectVtable, StaticModeObject,
-    NewKmsDevice, Probing, Sealed,
+    atomic::*, modes::DisplayMode, plane::*, vblank::*, KmsDriver, ModeObject, ModeObjectVtable,
+    StaticModeObject, NewKmsDevice, Probing, Sealed,
 };
 use crate::{
     alloc::KBox,
@@ -643,6 +643,7 @@ pub trait AsRawCrtcState: private::AsRawCrtcState {
 pub(crate) mod private {
     use super::*;
 
+    /// The raw-pointer half of [`AsRawCrtcState`](super::AsRawCrtcState).
     #[allow(unreachable_pub)]
     pub trait AsRawCrtcState {
         /// Return a raw pointer to the DRM CRTC state
@@ -677,6 +678,14 @@ fn active(&self) -> bool {
         // this access is serialized
         unsafe { (*self.as_raw()).active }
     }
+
+    /// Returns the display mode programmed into this CRTC state.
+    fn mode(&self) -> &DisplayMode {
+        // SAFETY: `mode` is embedded in `drm_crtc_state`, so it shares the state's lifetime, and
+        // is only mutated from the atomic check context - invariant beyond that point, so our
+        // interface can ensure this access is serialized.
+        unsafe { DisplayMode::as_ref(&(*self.as_raw()).mode) }
+    }
 }
 impl<T: AsRawCrtcState> RawCrtcState for T {}
 
diff --git a/rust/kernel/drm/kms/modes.rs b/rust/kernel/drm/kms/modes.rs
index 88ea27729212..16024855c32f 100644
--- a/rust/kernel/drm/kms/modes.rs
+++ b/rust/kernel/drm/kms/modes.rs
@@ -78,4 +78,74 @@ pub fn crtc_vtotal(&self) -> u16 {
         // SAFETY: Reading these fields is safe via our type invariants
         unsafe { (*self.as_raw()).crtc_vtotal }
     }
+
+    /// Horizontal active pixels (`hdisplay`).
+    #[inline]
+    pub fn hdisplay(&self) -> u16 {
+        // SAFETY: Reading these fields is safe via our type invariants
+        unsafe { (*self.as_raw()).hdisplay }
+    }
+
+    /// Horizontal sync pulse start (`hsync_start`).
+    #[inline]
+    pub fn hsync_start(&self) -> u16 {
+        // SAFETY: Reading these fields is safe via our type invariants
+        unsafe { (*self.as_raw()).hsync_start }
+    }
+
+    /// Horizontal sync pulse end (`hsync_end`).
+    #[inline]
+    pub fn hsync_end(&self) -> u16 {
+        // SAFETY: Reading these fields is safe via our type invariants
+        unsafe { (*self.as_raw()).hsync_end }
+    }
+
+    /// Horizontal total pixels including blanking (`htotal`).
+    #[inline]
+    pub fn htotal(&self) -> u16 {
+        // SAFETY: Reading these fields is safe via our type invariants
+        unsafe { (*self.as_raw()).htotal }
+    }
+
+    /// Vertical active scanlines (`vdisplay`).
+    #[inline]
+    pub fn vdisplay(&self) -> u16 {
+        // SAFETY: Reading these fields is safe via our type invariants
+        unsafe { (*self.as_raw()).vdisplay }
+    }
+
+    /// Vertical sync pulse start (`vsync_start`).
+    #[inline]
+    pub fn vsync_start(&self) -> u16 {
+        // SAFETY: Reading these fields is safe via our type invariants
+        unsafe { (*self.as_raw()).vsync_start }
+    }
+
+    /// Vertical sync pulse end (`vsync_end`).
+    #[inline]
+    pub fn vsync_end(&self) -> u16 {
+        // SAFETY: Reading these fields is safe via our type invariants
+        unsafe { (*self.as_raw()).vsync_end }
+    }
+
+    /// Vertical total scanlines including blanking (`vtotal`).
+    #[inline]
+    pub fn vtotal(&self) -> u16 {
+        // SAFETY: Reading these fields is safe via our type invariants
+        unsafe { (*self.as_raw()).vtotal }
+    }
+
+    /// Pixel clock for this display mode in kHz (`clock`).
+    #[inline]
+    pub fn clock(&self) -> i32 {
+        // SAFETY: Reading these fields is safe via our type invariants
+        unsafe { (*self.as_raw()).clock }
+    }
+
+    /// The refresh rate of this mode in Hz, as computed by `drm_mode_vrefresh()`.
+    #[inline]
+    pub fn vrefresh(&self) -> i32 {
+        // SAFETY: `drm_mode_vrefresh` only reads the mode, which is valid via our invariants.
+        unsafe { bindings::drm_mode_vrefresh(self.as_raw()) }
+    }
 }
diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index 375f79bd3ceb..3863dfe1b84c 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -595,6 +595,16 @@ fn plane(&self) -> &Self::Plane {
         unsafe { Self::Plane::from_raw(self.as_raw().plane) }
     }
 
+    /// The width of this plane's destination rectangle within the CRTC, in pixels (`crtc_w`).
+    fn crtc_w(&self) -> u32 {
+        self.as_raw().crtc_w
+    }
+
+    /// The height of this plane's destination rectangle within the CRTC, in pixels (`crtc_h`).
+    fn crtc_h(&self) -> u32 {
+        self.as_raw().crtc_h
+    }
+
     /// Return the current [`OpaqueCrtc`] assigned to this plane, if there is one.
     fn crtc<'a, 'b: 'a, D>(&'a self) -> Option<&'b OpaqueCrtc<D>>
     where
-- 
2.55.0

