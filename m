Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06190C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 454F810ED51;
	Wed, 26 Aug 2026 16:36:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="tv199sA5";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29F4010ED6C
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:36:25 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so10279175e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762183; x=1788366983;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vl+DiUajk5iNhGqiCsP7kWZwbRynvLhcntFNkKHXw/s=;
 b=tv199sA5ZDDWx79JPlGiP1pJaNuh/J5ECvTiupkuVWFzI3BQerBnaFPA46mOsVEt+m
 4tUGYPhal+01YU+gCiDU34ZuuADwplPZ7JaDROv3XqO086TIEiMcLCWfMZXWVvLw5n6a
 QCFzG1Il+IpB+9tjR/I9IstCqkB0be+9j42OpzFuA8sDif8M28Xi2jkENRV4cnAk5wvd
 IGjNYfByTw+XWxNpzh9A25Lja/2IVNSuRA6sHj+YOKQMNul/Ah5gcpUjIJiOlSYNURzj
 udkIh43msv4rz8UtLhTBXTHKnQ8attr+ajuFouYemBTPGIGFcQYloKecgHa3tHN1KKky
 cMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762183; x=1788366983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vl+DiUajk5iNhGqiCsP7kWZwbRynvLhcntFNkKHXw/s=;
 b=gZsCKQ9iqGGc3S9EaC0vmtQLh6vD2L+CTveGi3owjPg5vObYAhJMhpzuev6jReqrFU
 i8J+MHhtVtiBBr7HvbqmNPcYEhGipfSxqu5J9h0WCJjL+4yWsjE6EMJyqTTxASmGc9gR
 Dr5Ls58BqhzEqFmjbBxwCFdUx2RfYWAryz/fSpmD5ahqftuLZf+EKqDTWXmTdnjndJfD
 MpZsn3pUkutlgh5RgGNyy8prH8UTlCdmivn/BJwZTlcjl0R9dFzwK+jp3H40xGfhI2Lu
 pU2TJ/nn0e/i5Q+v4G6ADQj+4vagRmNReD9roogO52VjbAe2g6jSwnd17MwLw2aWqSy6
 HKPg==
X-Gm-Message-State: AFuF++ka95UHhwauLFHJcxRUdG8XsrkDB7TkMAaBDh70M8ohg7Q4PUQ6
 oVBKothkrCMewik4Xkh4cxsb8Qb75qz1nAnFr4d2phq5BR9TW0EfhIAD6dA4W+4jnkHvJAUUOjD
 pNx4FdUkK
X-Gm-Gg: AR+sD103v7i/oCmbd5RlRDXkK/V5q0lBv+JD+/zWlO3y+MUs5DGfOVqpf9R/IWrCYHR
 SwsWkb5K4wIB2TgqFjpos594obVLq2yo5iXfoGrySJRxUTaAO9WFUbuLb5Zju/bI+6BH8Zhg46+
 AMcE821P00hCfmFUKbaKGGgXqJKvSjwunYuko7utof5vkSgHCvvTC1ubRM1lGb8WqT2eOs+M3WP
 ATZ1YGvGmaq4v56Qi2QBf/iLXNriqggCH6C6Te8/qKhBRTMP+mOoX+wuDwZbJI7OecL1vXi7+1j
 cZICG4fAl67UJJ1npJNosvKHC2Jv0mFIg5jP8reJp0Niw/E/IiVHoUCv5UYT6M+vMNTsnp5VEtY
 Hmz1NMXzGcmQxhCteIkOSRGpd0rrJY3UhouFct3/ec/MUTwyiJ2VbzWXHrcEv+bFx6P485PZ+0p
 +GghkBLVfnQUqLkdR66my3ogzx4owThhsaTzWqG9Nl9zQIcergM+5L7RsGMDjS6hOz/pRi9IV+f
 aoaO/zMJQQR6rmskcRI+CbDq7Z6gnml4u9x
X-Received: by 2002:a05:600c:a086:b0:499:b000:b828 with SMTP id
 5b1f17b1804b1-499dc6e9a9dmr93091925e9.4.1787762183517; 
 Wed, 26 Aug 2026 09:36:23 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:36:21 -0700 (PDT)
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
Subject: [PATCH v3 18/23] rust: drm: expose mode flags and CTA VIC matching
Date: Wed, 26 Aug 2026 17:31:49 +0100
Message-ID: <20260826163359.4998-19-mike@fireburn.co.uk>
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

Let Rust DRM drivers construct modes with signal flags, inspect those
flags, and use the DRM EDID helper to identify the matching CTA-861
Video Identification Code. This keeps drivers from duplicating the
canonical HDMI mode table.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/kernel/drm/kms/modes.rs | 73 ++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/rust/kernel/drm/kms/modes.rs b/rust/kernel/drm/kms/modes.rs
index b48a02edfc13..584f20456c07 100644
--- a/rust/kernel/drm/kms/modes.rs
+++ b/rust/kernel/drm/kms/modes.rs
@@ -11,6 +11,60 @@
     types::Opaque,
 };
 
+/// Flags describing signal polarity and scan format for a display mode.
+///
+/// These correspond to the `DRM_MODE_FLAG_*` values accepted by the DRM mode helpers.
+#[derive(Clone, Copy, Default, PartialEq, Eq)]
+pub struct ModeFlags(u32);
+
+impl ModeFlags {
+    /// Horizontal sync is active high.
+    pub const PHSYNC: Self = Self(bindings::DRM_MODE_FLAG_PHSYNC);
+    /// Horizontal sync is active low.
+    pub const NHSYNC: Self = Self(bindings::DRM_MODE_FLAG_NHSYNC);
+    /// Vertical sync is active high.
+    pub const PVSYNC: Self = Self(bindings::DRM_MODE_FLAG_PVSYNC);
+    /// Vertical sync is active low.
+    pub const NVSYNC: Self = Self(bindings::DRM_MODE_FLAG_NVSYNC);
+    /// The mode is interlaced.
+    pub const INTERLACE: Self = Self(bindings::DRM_MODE_FLAG_INTERLACE);
+    /// The mode uses doublescan.
+    pub const DBLSCAN: Self = Self(bindings::DRM_MODE_FLAG_DBLSCAN);
+    /// The mode uses composite sync.
+    pub const CSYNC: Self = Self(bindings::DRM_MODE_FLAG_CSYNC);
+    /// Composite sync is active high.
+    pub const PCSYNC: Self = Self(bindings::DRM_MODE_FLAG_PCSYNC);
+    /// Composite sync is active low.
+    pub const NCSYNC: Self = Self(bindings::DRM_MODE_FLAG_NCSYNC);
+    /// The mode carries a horizontal skew value.
+    pub const HSKEW: Self = Self(bindings::DRM_MODE_FLAG_HSKEW);
+    /// The mode is double-clocked.
+    pub const DBLCLK: Self = Self(bindings::DRM_MODE_FLAG_DBLCLK);
+    /// The mode uses a half-rate clock.
+    pub const CLKDIV2: Self = Self(bindings::DRM_MODE_FLAG_CLKDIV2);
+
+    /// Return whether all flags in `other` are set.
+    pub fn contains(self, other: Self) -> bool {
+        self & other == other
+    }
+}
+
+impl core::ops::BitOr for ModeFlags {
+    type Output = Self;
+
+    fn bitor(self, rhs: Self) -> Self::Output {
+        Self(self.0 | rhs.0)
+    }
+}
+
+impl core::ops::BitAnd for ModeFlags {
+    type Output = Self;
+
+    fn bitand(self, rhs: Self) -> Self::Output {
+        Self(self.0 & rhs.0)
+    }
+}
+
 /// The essential timing fields of a display mode.
 #[derive(Clone, Copy)]
 pub struct ModeTimings {
@@ -32,6 +86,8 @@ pub struct ModeTimings {
     pub vsync_end: u16,
     /// Total vertical lines including blanking.
     pub vtotal: u16,
+    /// Signal polarity and scan-format flags.
+    pub flags: ModeFlags,
 }
 
 /// DRM kernel-internal display mode structure.
@@ -84,6 +140,7 @@ pub fn from_timings(t: ModeTimings) -> Result<Self> {
         mode.vsync_start = t.vsync_start;
         mode.vsync_end = t.vsync_end;
         mode.vtotal = t.vtotal;
+        mode.flags = t.flags.0;
 
         Ok(Self {
             inner: Opaque::new(mode),
@@ -202,10 +259,26 @@ pub fn clock(&self) -> i32 {
         unsafe { (*self.as_raw()).clock }
     }
 
+    /// Return the mode's signal-polarity and scan-format flags.
+    #[inline]
+    pub fn flags(&self) -> ModeFlags {
+        // SAFETY: Reading this field is safe via the type invariants.
+        ModeFlags(unsafe { (*self.as_raw()).flags })
+    }
+
     /// Return the refresh rate in Hz as computed by DRM.
     #[inline]
     pub fn vrefresh(&self) -> i32 {
         // SAFETY: `drm_mode_vrefresh` only reads this valid display mode.
         unsafe { bindings::drm_mode_vrefresh(self.as_raw()) }
     }
+
+    /// Return the CTA-861 Video Identification Code matching this mode.
+    ///
+    /// A return value of zero means the mode is not one of the CTA-861 modes known to DRM.
+    #[inline]
+    pub fn cea_vic(&self) -> u8 {
+        // SAFETY: `drm_match_cea_mode` only reads this valid display mode.
+        unsafe { bindings::drm_match_cea_mode(self.as_raw()) }
+    }
 }
