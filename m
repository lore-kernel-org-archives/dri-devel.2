Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B6CC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F86D10ED70;
	Wed, 26 Aug 2026 16:37:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="O/qInibV";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6264910ED70
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:36:59 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-482dd6ee390so1130074f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762217; x=1788367017;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OkRk1iaOzdwQPEjbMkHe3YM7CcoWsAQlRLu4eqxZlx0=;
 b=O/qInibVAvPXCM9Veygv3wF6tflS/POK0RtH/ZmTcXC/jOAdVt/XiUVRtw1bj45iS5
 /2jF8wfrvRE5B5P5jFwBdnL36iHHK6Fp/CeT+nyiSzJjfGDAgZ912TpS113uudJ+PJeb
 YrfbkFo5RNhMTm20Vo2x5cj6RzBE/c0ZEcxI/1E7hheHiSoOCz+aLRzCsG4cJDWD0ShK
 i6J9GnLn/IdvW9XY0DxCxEJsuGPoOAqqCWU0dMhVyZfNnzejb2GCOQlrznxeBPdtCUrM
 EEC3P3DVGxpKDVTVnNJFQXW7JqG69NdgQoCpOSSa934XD6CY9H1ctx+fXbej3JRt8gW9
 pvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762217; x=1788367017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OkRk1iaOzdwQPEjbMkHe3YM7CcoWsAQlRLu4eqxZlx0=;
 b=JFLX200cGf+s3w6PItVzVBT7iBoeXRgkYFvy5+irhsSgbeWX0uJ/2irGWgMHXYyxpX
 o3+O341f09L143leHdosUYbkDnZaolMs0tEcRxUCrnvHRk+A0jxkgbBUlKmdieYneGVc
 Fee/lMsnsL2LwgvKTbaFjZY2VBw+UMDjwK66MG5MexKUM+RzAnxSYLld7zn8yTABW0gj
 w1zpjYUZSzspxbGbjeknV6qINWTwlBBG346VfbunI9l4/RuH3jk36apcVhB8+tGl1t/1
 ryQ/gAdGaAAftuGYUxwj+roy3vxUv4E9s9F+gAWU/7vJjrboR+cQwruIxOurpliQCQd3
 QNvQ==
X-Gm-Message-State: AFuF++k7i+EsTbt1VMp28bYa7H34YPNxRXHitKT1dHlYQuzFmQVD3etY
 0Jj3hy0382SyZE0G7gmKauy6J+3spXIX6F0eAQ1nvqn0BEB5lri5QL75MHIxrZvNMJEGMJn64Y+
 mCJF3GK46
X-Gm-Gg: AR+sD12M4eXsxEiIbUoPmP/qYcSQR+USBPIdE9dJLqdPa3IapxXUuyfGHOn3LOBt9wy
 uZNpWBfwmagogdBZNdpGkHEbv86/D/v08aAVXdI4xzdWUQzwN98vG1earYqg1+cO2CMO+iTSiL5
 XPBhRWbqZU5PQiEUPw464Q4ggRtkqIGg0VS/E4JlQTianl3SsSygZuFtx8S3TNjo5g/E/mCIq9I
 1hXphCgs21HNPxtvckCo5M8NXyePRqVRH2ktT5Jtx1WgA4Uc3yNpavqdd58OlgOqdWXul+eJMBd
 VbfzDVQhjzG+vk1x+hiELGbVw2PQaPQCL5Q50A2wRojyumBXHBFDVfJ4EvIKsFhlbjAXyVq9qQs
 SHc2GcW6LqbO6cLd+/ScZ4pK7WQonvtQFTe5FuaK89WLQxAr/+poqRJa4TTmGnbDlt5TUp3nRv4
 jTwie/KySGdZj2aK/cZj6DGkkN418JLvizju+VLTNLT4xE2FVZX+LY54Up/pkD4L+JgvkkJl+d9
 0SZdwvyUDpyI9xB76IAw3poIL2fzziGh94+u+M99RbcIdY=
X-Received: by 2002:a05:600c:811a:b0:499:db9b:f253 with SMTP id
 5b1f17b1804b1-499dc6ec214mr84001985e9.3.1787762217462; 
 Wed, 26 Aug 2026 09:36:57 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:36:55 -0700 (PDT)
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
Subject: [PATCH v3 22/23] rust: drm: kms: walk the CRTCs an atomic commit
 carries
Date: Wed, 26 Aug 2026 17:31:53 +0100
Message-ID: <20260826163359.4998-23-mike@fireburn.co.uk>
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

A driver enforcing a constraint its CRTCs share -- a bandwidth budget,
a clock source, a fixed pool of scanout engines -- has to weigh what
every head will be once the commit lands, and a per-CRTC callback can
only reach its own new state. Reaching the others through committed
state answers a different question: it prices each sibling at what it
is leaving rather than what it is taking, so two heads that both rise
in one commit each find the other still low, pass individually, and
break the shared limit together.

Add the walk over the CRTCs an atomic state carries, the Rust spelling
of for_each_new_crtc_in_state(), on both the state and its mutator.
The CRTC is handed over alongside its new state because the
driver-private data that names what a CRTC drives hangs off the CRTC,
not off the state.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/kernel/drm/kms/atomic.rs | 52 +++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/rust/kernel/drm/kms/atomic.rs b/rust/kernel/drm/kms/atomic.rs
index f9f91edc89c3..24daeaeca075 100644
--- a/rust/kernel/drm/kms/atomic.rs
+++ b/rust/kernel/drm/kms/atomic.rs
@@ -142,6 +142,48 @@ pub fn new_connector_state_for_crtc<C>(&self, crtc: &C) -> Option<&OpaqueConnect
         None
     }
 
+    /// Invoke `f` for every CRTC this [`AtomicState`] carries a new state for, passing the CRTC
+    /// and that state.
+    ///
+    /// This is the Rust spelling of walking `for_each_new_crtc_in_state()`.
+    ///
+    /// A driver enforcing a constraint its heads share -- a bandwidth budget, a clock source, a
+    /// fixed pool of scanout engines -- has to weigh what every head will be once the commit
+    /// lands. A per-CRTC callback that consults committed state instead sees each sibling at its
+    /// old value, so two heads that both rise in one commit each find the other still low, pass
+    /// individually, and break the shared limit together.
+    pub fn for_each_new_crtc_state<F>(&self, mut f: F)
+    where
+        F: FnMut(&Crtc<T::Crtc>, &OpaqueCrtcState<T>),
+    {
+        // SAFETY: `state` is initialized via our type invariants, and `crtcs` together with the
+        // device's `num_crtc` are invariant for as long as we hold a reference to it.
+        let (crtcs, num) = unsafe {
+            let raw = self.as_raw();
+            ((*raw).crtcs, (*(*raw).dev).mode_config.num_crtc)
+        };
+        if crtcs.is_null() || num <= 0 {
+            return;
+        }
+        for i in 0..num as usize {
+            // SAFETY: `crtcs` points to `num_crtc` initialized entries.
+            let (ptr, new_state) = unsafe { ((*crtcs.add(i)).ptr, (*crtcs.add(i)).new_state) };
+            if ptr.is_null() || new_state.is_null() {
+                continue;
+            }
+            // SAFETY: every CRTC of a `KmsDriver` device is a `Crtc<T::Crtc>`, and a non-null
+            // `new_state` is a valid `drm_crtc_state`. Both borrow from `self`, so neither can
+            // outlive the atomic state owning them.
+            let (crtc, state) = unsafe {
+                (
+                    Crtc::<T::Crtc>::from_raw(ptr),
+                    OpaqueCrtcState::<T>::from_raw(new_state),
+                )
+            };
+            f(crtc, state);
+        }
+    }
+
     /// Return the old state of the first connector routed to `crtc` in this [`AtomicState`], if
     /// any.
     ///
@@ -282,6 +324,16 @@ pub fn new_connector_state_for_crtc<C>(&self, crtc: &C) -> Option<&OpaqueConnect
         self.state.new_connector_state_for_crtc(crtc)
     }
 
+    /// Invoke `f` for every CRTC this state carries a new state for.
+    ///
+    /// See [`AtomicState::for_each_new_crtc_state`].
+    pub fn for_each_new_crtc_state<F>(&self, f: F)
+    where
+        F: FnMut(&Crtc<T::Crtc>, &OpaqueCrtcState<T>),
+    {
+        self.state.for_each_new_crtc_state(f)
+    }
+
     /// Return the old state of the first connector routed to `crtc`, if any.
     ///
     /// See [`AtomicState::old_connector_state_for_crtc`].
