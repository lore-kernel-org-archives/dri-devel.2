Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9D7C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:35:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B9D410E31C;
	Wed, 26 Aug 2026 16:35:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="zmRs+ICP";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 913CC10E319
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:35:34 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso6388815e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762133; x=1788366933;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j5InOYNyXFRZKVSePul+WGyV/aEo1lwukf/GCH3cW8s=;
 b=zmRs+ICPOToutfg/CutYUcev1TneNLYL0y5hgXDM941unGrC0DHej6XfylOHg/Gshk
 PPLAOereydvofDldHj1tYWSSaknUMG+I/5zieDhyYqcwkSoyCJ8Bn0Zfy2GQVYlw/s6p
 gp8yniLnuKfI+lbZc54ycwNNV3gC1x6IcumH3Af/oUwc67zMpIOaUwx5UyEbj72fYdXT
 hDxFoMB+8eYGea/gZ3/rOeC0BvQCtBib/g+aDQjIwcur+PjUkj308XxHnM9UGT6nHIKm
 qby4dA4Y0DXr4Iuen7nDrkpdSzPhEsX8a2vBr+SqTTsBXVc9+I4ojk7mgQirahr0NOLu
 dM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762133; x=1788366933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j5InOYNyXFRZKVSePul+WGyV/aEo1lwukf/GCH3cW8s=;
 b=FHLALY1TkGRxfxHFeLvWkmKy4KWUsxT5Ri9dWmFQdyH/Y9xX5sR0FvFP1b/NZA8qxl
 glUPDtzJ6ZlvOv0cpAqbiAp1S+g9bVWNJ5xfInVEWsfu8XSLtDyaQWwEVAtqoAKJBGBj
 M22nSV8mLyx1VolK96l6nH1jrflK12CyQZzRUVcikvU7xjmzgU75eIwR32/nYYXYLBR3
 23puZYBVSmZiqBb7vGMPoOTRjx36tiGVIdfTAe6OyM43vbYCfE9AySSlzBUDcEwPCvAM
 7OoiNe9cMfit9sO3qIG0nlJJlNy4uzS4NhXc3GuZWK08CZoa6o1plw2xF4g7M6/WFDBv
 CLlg==
X-Gm-Message-State: AFuF++m7nhTUTpx4Jv0SSQuCE6mHbtWxUxLp+LBdYUotbo7HWqlxr/nk
 3VUQdKS5duMQ15OhcwFdNYeP8ph5YfLGuIGQb7jpOPwt00ETK+HPEMUhYXUDQKSv4rNTOCyJ3Fc
 ycD96NKEi
X-Gm-Gg: AR+sD12S3PmmDJRywcrt82snvepVhxo6ZahALLA+tLeJsaUvlLgGSThgY8ECVXHF/yZ
 GLb3k9hPYciMaUle7GDbw02NR7xJ1fvGut4OpD+Rx6x+iPI1XWtldBM5m8yEEYlfaOGqFrKdE+y
 azV6hecd2Qgj2I5v8ybCR3qF9HpdKnWm7J2TZFxYwhFQ24XV10HcIHRGoixqND1/lbSPtXjsSo3
 aREJArxEUgzpuyRPH4za7GmibfQe2w6NlroQBC8qR4RuRdrVS2bNFkz+2Zt3JI6Ysr5Yc3vEHgA
 f7p6nFaC3BRf/YEUEpuebvQJfamPkKqrPrOtNqVe6fNJ5QgyIkxxQvOVcn9+1EAjxK1sE0FV77q
 LHgdsRjJYAEyMeuPhOK8OXoLr4aGe4Ejuz2P1waQZ9ThRhsz1AVGSuqwhADG2H2woLY5tlJpS2c
 5q62b3YEhWv1GoXUgklY8buqgG1OFc2+PzvksCzHaGjiGbSmdxeK0WmzD78sA2RSlhTZ/yJAWzg
 wEqMCkJoNqgP4w397F+/WhyEUVEEHS5cUZS
X-Received: by 2002:a05:600c:4585:b0:498:952:e276 with SMTP id
 5b1f17b1804b1-499dc6f7ec9mr70086385e9.8.1787762132870; 
 Wed, 26 Aug 2026 09:35:32 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:35:31 -0700 (PDT)
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
 Lyude Paul <lyude@redhat.com>, Asahi Lina <lina+kernel@asahilina.net>,
 Matthew Maurer <mmaurer@google.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 9/23] rust: drm: kms: add plane damage-clip accessors
Date: Wed, 26 Aug 2026 17:31:40 +0100
Message-ID: <20260826163359.4998-10-mike@fireburn.co.uk>
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

Add safe access to the FB_DAMAGE_CLIPS rectangles intersected with
the visible source area.

damage_merged() returns the bounding rectangle produced by
drm_atomic_helper_damage_merged(). for_each_damage_clip() wraps
the DRM damage iterator for drivers that can process the individual
rectangles without repainting their bounding box.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/drm/kms/plane.rs    | 105 ++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 38ad80fae0ed..c4abdd887699 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -41,6 +41,7 @@
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_damage_helper.h>
 #include <drm/drm_device.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index 8e3f711b0767..3bff4091abb2 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -693,6 +693,49 @@ pub trait FromRawPlaneState: AsRawPlaneState {
     unsafe fn from_raw_mut<'a>(ptr: *mut bindings::drm_plane_state) -> &'a mut Self;
 }
 
+/// A rectangle in a plane's source (pixel) space, as produced by
+/// [`RawPlaneState::damage_merged`].
+///
+/// The box is inclusive on the top-left and exclusive on the bottom-right (`[x1, x2)` by
+/// `[y1, y2)`), matching [`struct drm_rect`].
+///
+/// [`struct drm_rect`]: srctree/include/drm/drm_rect.h
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+pub struct Rect {
+    /// Left edge, inclusive.
+    pub x1: i32,
+    /// Top edge, inclusive.
+    pub y1: i32,
+    /// Right edge, exclusive.
+    pub x2: i32,
+    /// Bottom edge, exclusive.
+    pub y2: i32,
+}
+
+impl Rect {
+    #[inline]
+    fn from_raw(r: &bindings::drm_rect) -> Self {
+        Self {
+            x1: r.x1,
+            y1: r.y1,
+            x2: r.x2,
+            y2: r.y2,
+        }
+    }
+
+    /// The width of the rectangle in pixels.
+    #[inline]
+    pub fn width(&self) -> i32 {
+        self.x2 - self.x1
+    }
+
+    /// The height of the rectangle in pixels.
+    #[inline]
+    pub fn height(&self) -> i32 {
+        self.y2 - self.y1
+    }
+}
+
 /// Common methods available on any type which implements [`AsRawPlane`].
 ///
 /// This is implemented internally by DRM, and provides many of the basic methods for working with
@@ -774,6 +817,68 @@ fn atomic_helper_check<S, D>(
         })
     }
 
+    /// Merge all frame-damage clips on this (new) plane state -- relative to `old` -- into a
+    /// single bounding rectangle, intersected with the plane's visible source area.
+    ///
+    /// Returns [`None`] when the plane is not visible or there is nothing to update. If the client
+    /// supplied no explicit damage clips, the full plane rectangle is returned, so a driver can
+    /// always treat [`Some`] as "repaint this rectangle" and fall back to a full-frame update.
+    /// Coordinates are integer pixels in the plane's source space.
+    ///
+    /// [`drm_atomic_helper_damage_merged`]: srctree/include/drm/drm_damage_helper.h
+    fn damage_merged(&self, old: &impl AsRawPlaneState) -> Option<Rect> {
+        let mut rect = bindings::drm_rect {
+            x1: 0,
+            y1: 0,
+            x2: 0,
+            y2: 0,
+        };
+
+        // SAFETY:
+        // - `old` and `self` are valid initialized `drm_plane_state`s via their type invariants.
+        // - `drm_atomic_helper_damage_merged` only reads the two states (to gather the damage
+        //   clips and the source rectangle) and writes the merged result into `rect`; it does not
+        //   mutate the plane state, so deriving a `*mut` from our shared reference is sound.
+        let visible = unsafe {
+            bindings::drm_atomic_helper_damage_merged(
+                core::ptr::from_ref(old.as_raw()),
+                core::ptr::from_ref(self.as_raw()).cast_mut(),
+                &mut rect,
+            )
+        };
+
+        visible.then(|| Rect::from_raw(&rect))
+    }
+
+    /// Invoke `f` once per frame-damage clip on this (new) plane state relative to `old`, each
+    /// intersected with the plane's visible source area -- i.e. the individual rectangles that
+    /// [`Self::damage_merged`] collapses into one. If the client supplied no explicit damage clips,
+    /// `f` is called once with the full plane rectangle. Coordinates are integer pixels in the
+    /// plane's source space.
+    ///
+    /// This lets a driver forward each changed region separately (e.g. to a remote display) instead
+    /// of the bounding box of them all.
+    ///
+    /// [`drm_atomic_helper_damage_iter`]: srctree/include/drm/drm_damage_helper.h
+    fn for_each_damage_clip(&self, old: &impl AsRawPlaneState, mut f: impl FnMut(Rect)) {
+        let mut iter = bindings::drm_atomic_helper_damage_iter::default();
+        let mut clip = bindings::drm_rect::default();
+        // SAFETY:
+        // - `old` and `self` are valid initialized `drm_plane_state`s via their type invariants.
+        // - `drm_atomic_helper_damage_iter_init` only reads the two states to set up `iter`, and
+        //   `_next` only reads `iter` and writes `clip`; neither escapes a pointer.
+        unsafe {
+            bindings::drm_atomic_helper_damage_iter_init(
+                &mut iter,
+                core::ptr::from_ref(old.as_raw()),
+                core::ptr::from_ref(self.as_raw()),
+            );
+            while bindings::drm_atomic_helper_damage_iter_next(&mut iter, &mut clip) {
+                f(Rect::from_raw(&clip));
+            }
+        }
+    }
+
     /// Return the framebuffer currently set for this plane state
     #[inline]
     fn framebuffer<D>(&self) -> Option<&Framebuffer<D>>
