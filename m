Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EB9C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FE2089209;
	Wed, 26 Aug 2026 16:35:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="WmVjnRHH";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 627C089209
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:35:57 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-499b2981a7bso10774035e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762156; x=1788366956;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/APfKcEeEW79JrpN5r3Qjg5PHNTQvqkRfD0//AqN/6w=;
 b=WmVjnRHHQFXuSfsn38ukNDvCrnuIQcOQb9YKRsnyGnP2sdnq5juBm+hFCZPYjRU1qI
 Sar705Et3/zQyOHJ0DmZbHGDMncYEenPhH3/c+LVMQHMmc7l1g6cHj5Z5HEOQNO/KJun
 2mrA+HAPwVKHEoSwRXztvN7S9RzvIRwqYhYscXw261USvaYHaNRf6NtLLj2G0ZTXgSV5
 WKXuMSii1sjLzqQhe6uJt333KuvHOlXwELxvXhPNMU+gbTIIQAzTNGr0VRsVgh3UXr9I
 lY8xSxM1oXn7kxkH/cMKXnNwQmjZBXz244nm9wWj00m7j8SLildWscT0jCTIOS2lbFpO
 wXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762156; x=1788366956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/APfKcEeEW79JrpN5r3Qjg5PHNTQvqkRfD0//AqN/6w=;
 b=gvTSByGspxqrLzlZT3WlIUEAlrWlLyv4Z8dKlSJX+zEkE/ThPwzaaASNANX2VGUVIX
 OZv2TpacCs6i0UMuvFFaoyZTw6/A2jmDnO66Fh0F9GDmz2S76avdl65ll+SdZlv5DMPj
 1zkBqv0fePIm+99Q4uqJJ4Occ/hmrzl8fgN32fK07M7Lzce+lnrXc2808xpbXlvvDz+U
 BpWGV4yAN/8QVLZBy3CupHd7p0rsgbj86/JQuwz96A1+oWdh2Z2lT/dgcCkiV1nYIjDF
 pMdxETzWqYpHnWeyrMNooT1oN4AOVs8qtErtsCsC2dLpRKZzLQmXsJ0M0madno7jDqy1
 f0Eg==
X-Gm-Message-State: AFuF++lDBiylykuqhyH4cY6XgFRD50Ij+0NlsyuYpu8dZBi/+fYp+q7N
 ZtaicTJLCzgAgsUdixFcQRbVM6d6Ebfd8GqeR9NewP6HHSvFUNwm2Bopka6F5PEpKCQjs6CLxoL
 JorfHG9NF
X-Gm-Gg: AR+sD125jggnxACV/wDHafMIWQjujBxip5xfsebkXY97KsNVetTTg0cNk3DGG/LO1H6
 psearXyDGooG70UFTO4MB4sepSy+UMuozwlUMLIgmAOV6tzPNX+mLI9OqzvYu5TZD6k09DCPgbv
 Dam4FYzkGRludicmY6oNVMX5nXKLXxn9SRQY4+AuxRlQb9ZHFV4qKY2pSzW6fVLmrwBP1B+hxx/
 UBcprq/VrHSlZjGBMewfLvnAFnVKaVL6U33+QWR00qWAIQLDIsUFJcY4YmusYPCcjnUDsXv9ggH
 GJYurev8WIGSWsIJjShw2cTp1LghxHW/DJ5K6WflEj7rNLfP6YREWZM/9vmjiVHm0JuL+NToYUC
 nGiKfGI/QQ0r5toalRtQIIfiqLTkd0z7WIiqrjOiejqeIN0hsIbKiwx6abD/fPXIYxCOOPKdun2
 ZZIPsO9JH7YwePLTEXvQHxaMz1Fn/Ep35ETFOYrcHphpHj3K2lHsjJwP0yelhnIxvg9Svj2QXVf
 sJK9Hq745BoWj7MSdjoC/5trrxPTgpkXGTZ
X-Received: by 2002:a05:600c:a418:b0:495:52a5:8829 with SMTP id
 5b1f17b1804b1-499dc82073fmr78367735e9.11.1787762155817; 
 Wed, 26 Aug 2026 09:35:55 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:35:53 -0700 (PDT)
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
Subject: [PATCH v3 12/23] rust: drm: kms: add owned CRTC and vblank references
Date: Wed, 26 Aug 2026 17:31:43 +0100
Message-ID: <20260826163359.4998-13-mike@fireburn.co.uk>
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

`&Crtc<T>` is only valid for the callback DRM handed it to, and
`VblankRef` borrows one. That does not fit two common shapes:

  - a driver that enables vblanks in `atomic_enable` and releases
  them in
    `atomic_disable` holds the reference across two callbacks,
    so it has to `mem::forget` the guard and hand-balance a raw
    `drm_crtc_vblank_put`;

  - a driver with a software vblank clock must reach its CRTC from
  a timer
    callback, so it stashes a raw `drm_crtc` pointer and calls
    `drm_crtc_handle_vblank` on it.

Both are safe in principle -- mode objects live until their DRM device
is freed -- but neither can be expressed, so drivers reintroduce raw
pointers that the safe KMS API exists to remove.

Add `CrtcRef`, an owned handle holding an `ARef` to the DRM device,
which keeps the CRTC alive and hands back a `&Crtc<T>` from any context,
and `OwnedVblankRef`, a vblank reference built on it and obtained by
converting a `VblankRef` with `into_owned()`. The vblank reference
is still released exactly once, on drop.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/kernel/drm/kms/crtc.rs   | 54 +++++++++++++++++++++++++++++++++++
 rust/kernel/drm/kms/vblank.rs | 47 ++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
index a7024d8921ca..892f04f04e22 100644
--- a/rust/kernel/drm/kms/crtc.rs
+++ b/rust/kernel/drm/kms/crtc.rs
@@ -14,6 +14,7 @@
     drm::device::Device,
     error::{from_result, to_result},
     prelude::*,
+    sync::aref::ARef,
     types::{NotThreadSafe, Opaque},
 };
 use core::{
@@ -304,6 +305,59 @@ pub(crate) fn get_vblank_ptr(&self) -> *mut bindings::drm_vblank_crtc {
     pub(crate) const fn has_vblank() -> bool {
         T::OPS.funcs.enable_vblank.is_some()
     }
+
+    /// Returns an owned handle to this [`Crtc`].
+    ///
+    /// A `&Crtc<T>` is only valid for the callback that produced it. Drivers that must reach a
+    /// CRTC from a context DRM did not hand one to -- a timer callback driving a software vblank
+    /// clock, for instance -- can keep a [`CrtcRef`] instead of stashing a raw pointer.
+    pub fn to_owned_ref(&self) -> CrtcRef<T> {
+        CrtcRef {
+            dev: self.drm_dev().into(),
+            crtc: NonNull::from(self),
+        }
+    }
+}
+
+/// An owned handle to a [`Crtc`].
+///
+/// Mode objects are owned by their DRM device and live until it is freed, so holding an [`ARef`] to
+/// that device is enough to keep the CRTC valid. [`crtc`](CrtcRef::crtc) then hands back a usable
+/// reference from any context.
+///
+/// [`ARef`]: crate::sync::aref::ARef
+pub struct CrtcRef<T: DriverCrtc> {
+    /// Keeps the DRM device -- and with it every mode object it owns, including `crtc` -- alive.
+    dev: ARef<Device<T::Driver>>,
+    crtc: NonNull<Crtc<T>>,
+}
+
+// SAFETY: This is an owning handle to device state, not to anything thread-local, and the
+// `ARef` it holds is itself `Send`.
+unsafe impl<T: DriverCrtc> Send for CrtcRef<T> {}
+
+// SAFETY: The only shared access offered is `crtc()`, which yields the same `&Crtc<T>` that is
+// already freely shareable between threads.
+unsafe impl<T: DriverCrtc> Sync for CrtcRef<T> {}
+
+impl<T: DriverCrtc> CrtcRef<T> {
+    /// The [`Crtc`] this handle refers to.
+    pub fn crtc(&self) -> &Crtc<T> {
+        // SAFETY: `self.dev` holds a reference to the DRM device that owns this CRTC, and mode
+        // objects live until their device is freed, so the pointer is still valid.
+        unsafe { self.crtc.as_ref() }
+    }
+
+    /// The DRM device that owns the [`Crtc`].
+    pub fn drm_dev(&self) -> &Device<T::Driver> {
+        &self.dev
+    }
+}
+
+impl<T: DriverCrtc> Clone for CrtcRef<T> {
+    fn clone(&self) -> Self {
+        self.crtc().to_owned_ref()
+    }
 }
 
 /// A [`Crtc`] that has not yet been registered with userspace.
diff --git a/rust/kernel/drm/kms/vblank.rs b/rust/kernel/drm/kms/vblank.rs
index a725a46110d8..672968c1d3cb 100644
--- a/rust/kernel/drm/kms/vblank.rs
+++ b/rust/kernel/drm/kms/vblank.rs
@@ -359,6 +359,53 @@ fn new(crtc: &'a Crtc<T>) -> Result<Self> {
 
         Ok(Self(crtc))
     }
+
+    /// Converts this reference into an [`OwnedVblankRef`], which is not tied to the borrow of the
+    /// [`Crtc`] it came from.
+    pub fn into_owned(self) -> OwnedVblankRef<T> {
+        let crtc = self.0;
+
+        // The new owner takes over the reference this guard was holding.
+        mem::forget(self);
+
+        OwnedVblankRef(crtc.to_owned_ref())
+    }
+}
+
+/// A vblank reference that owns a reference to its DRM device.
+///
+/// [`VblankRef`] borrows the [`Crtc`] it was taken from, so it cannot outlive the callback that
+/// created it. A driver whose vblank interval spans several callbacks -- typically one that enables
+/// vblanks in [`atomic_enable`] and releases them in [`atomic_disable`], or that drives a software
+/// vblank clock from a timer -- needs a reference it can store instead.
+///
+/// It wraps a [`CrtcRef`], which keeps the DRM device -- and so the CRTC -- alive, so [`crtc`]
+/// hands back a usable reference for as long as this object exists. Dropping it releases the
+/// vblank reference exactly once.
+///
+/// [`atomic_enable`]: DriverCrtc::atomic_enable
+/// [`atomic_disable`]: DriverCrtc::atomic_disable
+/// [`crtc`]: OwnedVblankRef::crtc
+pub struct OwnedVblankRef<T: VblankDriverCrtc>(CrtcRef<T>);
+
+impl<T: VblankDriverCrtc> OwnedVblankRef<T> {
+    /// The [`Crtc`] whose vblanks this reference is keeping enabled.
+    pub fn crtc(&self) -> &Crtc<T> {
+        self.0.crtc()
+    }
+
+    /// The DRM device that owns the [`Crtc`].
+    pub fn drm_dev(&self) -> &Device<T::Driver> {
+        self.0.drm_dev()
+    }
+}
+
+impl<T: VblankDriverCrtc> Drop for OwnedVblankRef<T> {
+    fn drop(&mut self) {
+        // SAFETY: `crtc()` returns a valid, initialized `drm_crtc`, and this type holds exactly
+        // one vblank reference -- taken by `VblankRef::new()` and transferred by `into_owned()`.
+        unsafe { bindings::drm_crtc_vblank_put(self.crtc().as_raw()) };
+    }
 }
 
 /// The base wrapper for [`drm_vblank_crtc`].
