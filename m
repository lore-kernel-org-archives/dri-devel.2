Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA62C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 537C910E752;
	Wed, 26 Aug 2026 16:35:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="nbXuD1rX";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 253C310E752
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:35:47 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-499ac87c92bso9401725e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762145; x=1788366945;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2OUdL17iweLbkwDhh4IsnYuPIiYki9paBB+a21GlgG8=;
 b=nbXuD1rXjKvEN8IW/ZqugsPh2pZn2YG/aCTDSkSmtz8j4/hbyLzFu4ZxNTQGi0DrHN
 sKPk0/PiaaOQ0kV5LphnlTfe+ZjwCzuv1b8LoQHz5d6Kqv/FXqC/00sKp2azgulfbQOO
 MMM14BnPNaEh2KA+7kfHcsbZpyiF1IexvZRyD4qM8IDEYzwnZZxiNZZYQNjNelFX4FRo
 mN9ZKmONZ5WsDkN+M2dNbx7RkG3m9ioXwFMTlEvJu6YY6dwXT695ETVhYS0SMbAC0WO6
 IXYIoAWFXHEMV5j7xTV8W2ENC9p94OGGhwn7kJn1BCWioBw5JyAPqBK5bJW71NvWCJNz
 hrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762145; x=1788366945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2OUdL17iweLbkwDhh4IsnYuPIiYki9paBB+a21GlgG8=;
 b=LVehRJncqP8+rek6/BHw/ezRfoyhHNZFiziD2yR/DLqGUPqEUSVXhrtdEXm9ygLsHz
 9emoeBsNDE0bh033t2bc9MAI7nMiOEU2ll/8Fz0gl2McQ20cmzEIc108nJ29Kc4Tx8fo
 66KcGatvdBFmfzxj80wtoIQSzw+P4LQVhNs6tCyosDndigqgFkkgjBv2pAZjB84SLDzC
 ZusOa7k+X2gU0WYt/bBwWeA27F13MDSmQnm0Q5D0sWOjwU2dffVRJzjLqCIZl8hp1xNk
 5cKW4Otkp59oqUkqjxD5PNj98HkTDDUI/ecpydUDTRSuzWDEDb9TpyaBXU6sRsbhB+Rn
 uttw==
X-Gm-Message-State: AFuF++nh6J2Oi6bg//zD/domKDlFk18YaR0NPeOJnJXK2LAFmOs2NIN1
 i0tgLHFyEgVl33x/OJiQQrg0tHMVtlpATIuOTErRpOLeP9xnXGoGaBp4nnD2BFKESoDDpCH2HkI
 nNJPKp5Rf
X-Gm-Gg: AR+sD13qscpwOsL7Kwi8cX97HGXY4GN26qsaa97h9oED69gqGPsRXdVheFnQoUR83L0
 jUUZ0GWlt2nszW6XwE8jb0wFi8vO/bSK2qtVrTO6qP510wwpK2JiIQi5vcOeExvzOYSjLFGU/tG
 h98rTOGtCCmkmEOzvwJaIi1QOyJPmIpxwoR0VDfzpcDJAu5GrxUDjUknXcK7ieidakl3Zi8t+2v
 jfKyo+smxy5o4c5+b3OPcs7W07lnguOrpV3cT9Eovw8CRfl6BFuDZ2W3Oz959hMFRPo1qpFSblt
 Xu6zReskvsjMCvzEXpN6nJ3RTtF7UqFQE8f6vgA4ik5KVgc/ZDNj+qBb8H/A26Hant+zUmwp1rV
 CeOFXv9A27HSV+lqluBJjqN0h3PF1GWtXk0SDatexi85V1DZl2moG9QnXQZ7mJcLVcCBBBqf0Bh
 FiW9WIFqhWF3uGpW7iK2OyYjOfo56KNo8sKaCx+rtqTH1UsKh/khmIlNBW4zgxm9tQntkR9dAs5
 dQkWczSy5tMDvGVAZFNXTfWkQVuFLfzcdcgUzg4XzYjBkIU
X-Received: by 2002:a05:600c:3f0e:b0:495:4749:16a7 with SMTP id
 5b1f17b1804b1-499dc825cfamr95483725e9.14.1787762145530; 
 Wed, 26 Aug 2026 09:35:45 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:35:44 -0700 (PDT)
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
Subject: [PATCH v3 11/23] rust: drm: kms: expose checked plane geometry
Date: Wed, 26 Aug 2026 17:31:42 +0100
Message-ID: <20260826163359.4998-12-mike@fireburn.co.uk>
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

Expose the requested source rectangle and the visibility and clipped
rectangles produced by drm_atomic_helper_check_plane_state().

Keep 16.16 source coordinates explicit at the raw-state
boundary. Convert helper-clipped source coordinates to integer pixels
only after rejecting negative or fractional values, and return the
clipped destination in CRTC coordinates.

These generic accessors let Rust KMS drivers implement cursor
clipping and validate full-frame scanout without reaching into
generated bindings.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/kernel/drm/kms/plane.rs | 59 ++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index 3bff4091abb2..bc830503b142 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -758,6 +758,65 @@ fn crtc_h(&self) -> u32 {
         self.as_raw().crtc_h
     }
 
+    /// Return the requested source X coordinate in 16.16 fixed-point pixels.
+    fn source_x_16_16(&self) -> u32 {
+        self.as_raw().src_x
+    }
+
+    /// Return the requested source Y coordinate in 16.16 fixed-point pixels.
+    fn source_y_16_16(&self) -> u32 {
+        self.as_raw().src_y
+    }
+
+    /// Return the requested source width in 16.16 fixed-point pixels.
+    fn source_width_16_16(&self) -> u32 {
+        self.as_raw().src_w
+    }
+
+    /// Return the requested source height in 16.16 fixed-point pixels.
+    fn source_height_16_16(&self) -> u32 {
+        self.as_raw().src_h
+    }
+
+    /// Return whether [`Self::atomic_helper_check`] found any visible part of the plane.
+    fn visible(&self) -> bool {
+        self.as_raw().visible
+    }
+
+    /// Return the helper-clipped source rectangle in integer framebuffer pixels.
+    ///
+    /// This is valid after [`Self::atomic_helper_check`]. Fractional source coordinates are
+    /// rejected with [`EINVAL`].
+    fn visible_source(&self) -> Result<Option<Rect>> {
+        if !self.visible() {
+            return Ok(None);
+        }
+
+        let src = &self.as_raw().src;
+        if src.x1 < 0
+            || src.y1 < 0
+            || src.x2 < 0
+            || src.y2 < 0
+            || (src.x1 | src.y1 | src.x2 | src.y2) & 0xffff != 0
+        {
+            return Err(EINVAL);
+        }
+
+        Ok(Some(Rect {
+            x1: src.x1 >> 16,
+            y1: src.y1 >> 16,
+            x2: src.x2 >> 16,
+            y2: src.y2 >> 16,
+        }))
+    }
+
+    /// Return the helper-clipped destination rectangle in CRTC pixels.
+    ///
+    /// This is valid after [`Self::atomic_helper_check`].
+    fn visible_destination(&self) -> Option<Rect> {
+        self.visible().then(|| Rect::from_raw(&self.as_raw().dst))
+    }
+
     /// The plane's rotation/reflection (`DRM_MODE_ROTATE_*` | `DRM_MODE_REFLECT_*` bitmask), for a
     /// plane with a rotation property (see
     /// [`UnregisteredPlane::create_rotation_property`]). Defaults to `DRM_MODE_ROTATE_0`.
