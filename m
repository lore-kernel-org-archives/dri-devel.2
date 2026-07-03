Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A70DC43327
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85F8210F60B;
	Fri,  3 Jul 2026 03:02:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="wefv+nuz";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 156BC10F60B
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:02:17 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493c52cde9eso560785e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047735; x=1783652535;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qmuYxCXQJW79g/7IjZ0oN+EYDyNRyHCs4/1RFHrUzwg=;
 b=wefv+nuzINovWJeBrZnMrYalOxtp0j0I2anFalu5g5eT/3md1u7H1TlqpXNKm8Be8O
 yJmmi4Q0LadxhHucbJX8bwSKvay5kGJQE4PEeU63e2bYpfmmlkgoibCBHxULvAZU8poU
 7HYo2mbvRf4s1kqo4ytT7HwfEWUspjhFNYJM3C648IA7Cpw03XA5X0Ug9Ekrsuhe4elh
 xRs+W563EjFxDtZGAH38P//HPgh8SouPOp2Zk2dJofJ1/FX376Xscw+RSAP4WbF8sNzX
 oAgXH117lTPrx4EkZADxQ5dkzJvzk1MmowbyU8e6TqVGKxSiH62yd8/XAzBBjlIDrhHR
 bXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047735; x=1783652535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qmuYxCXQJW79g/7IjZ0oN+EYDyNRyHCs4/1RFHrUzwg=;
 b=Acso75rcYrie80oJEyM4lAJtv3ld044SpLLypSKUwEQWE+Xlq1HfvtWAUq/EW93eGV
 pzxrkf64CZS6aXNHbGPzklAqwZ2UM4YXU4STwj9NR5gf6BhJXow6t8CxdvQcuDNpUXlg
 rPRXuQFw1WCBDTapp9TdH23MRU8O3QH/ZEKJV9tmAS2LZ0MzBXP7sQxP9rH0nsxjEIzG
 bNT/i+IQHTXmtdk1WJCKZQjCuTlDHC7Hn8ybWh9TkyZc2fTV/2S7Ru7nn3JNtQrLnBYb
 C6uxmPqfqq2n0kMQJdv7CjJtdqFigOwDo21Z93/17wZuHgmLSv51ZzcnuxPYPU0abRsB
 2Ytw==
X-Gm-Message-State: AOJu0YxECEMnS6dx3NV6EKtUhAJk6cUuV6cx6yIEi1PMysRLMyc7LmEW
 olS9oXG0i3nw60JkO30iRh4xml1Mrp30DpnwEWOwRnfJ1Od343IEzBbHx7P/M5Dj5A==
X-Gm-Gg: AfdE7cmYwij4lYPo4gOA5GLgiVpCZM22pPSl1lfIPQxpoJK4hnOme23zxAlfncNugi/
 BLQEFMZnf2KTBNiWBfr0wVd7Dir078KNzutvNF3Sp4mlrXc9zrshYLFVMdcW/nQ1sl1LRFQGtIk
 1Eo00L4KsQvTuR/oUNeFW9ePGIUAbBtLeKEy+vQDXG8UTyCLIxXYcy0/TfgCRY2831xozZkNMLa
 o4L0OULqXn5GzK5cAbgKlhfuHFCvK6eRPi4+OEG83kiQeTwiia7ihitlTlwC1avxzeiRzxCjdqb
 ZE+zZKOItuS0iyFMc/SCFA3qE2x5tMqljKa/qX4RnTBORmukjaWi/HioTyBs++rCosHrk9UcYcQ
 Ty7qiag5w8Manf+/GKaTxEJBBRnn6DH8Y2OAORb7wGuqHQIXpPKXA8UmEYwTJyvGT/1Oc6ZP7kC
 fhX0mtaqiGqhSOOj5GASvCUSzFF54ogIPzoTQ9mTd2Uvj4mEfcNAhKyXon
X-Received: by 2002:a05:600c:a404:b0:493:b783:ad59 with SMTP id
 5b1f17b1804b1-493c2b374c7mr103666075e9.14.1783047735339; 
 Thu, 02 Jul 2026 20:02:15 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14466500f8f.4.2026.07.02.20.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:02:14 -0700 (PDT)
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
Subject: [RFC PATCH v2 18/18] rust: drm: kms: add plane damage-clip accessors
Date: Fri,  3 Jul 2026 04:01:05 +0100
Message-ID: <20260703030123.2814-19-mike@fireburn.co.uk>
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

A driver whose "scanout" is an expensive encode-and-send (like a USB
display) wants to repaint only the region a client marked dirty rather
than the whole framebuffer every flip. Add two RawPlaneState accessors
over the client's FB_DAMAGE_CLIPS (relative to the old plane state), both
intersected with the visible source area:

  - damage_merged(), wrapping drm_atomic_helper_damage_merged(): merges the
    clips into one rectangle and returns it as a new Rect type (with
    width()/height() helpers). None means nothing to repaint; if the client
    supplied no clips, the full plane rectangle is returned, so a driver can
    always treat Some as "repaint this box".

  - for_each_damage_clip(), driving drm_atomic_helper_damage_iter: invokes a
    closure once per individual clip (the rectangles damage_merged() collapses
    into one), so a driver that forwards each changed region separately -- e.g.
    over USB -- can repaint just those rectangles instead of their bounding box.

drm_atomic_helper_damage_{merged,iter_*} live in <drm/drm_damage_helper.h>,
so add that to bindings_helper.h.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/drm/kms/plane.rs    | 105 ++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 7d04abec1215..b8675642c1a8 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -39,6 +39,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_damage_helper.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder.h>
diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index ead875316829..4ae11cec88a4 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -605,6 +605,49 @@ pub trait FromRawPlaneState: AsRawPlaneState {
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
@@ -691,6 +734,68 @@ fn atomic_helper_check<S, D>(
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
-- 
2.55.0

