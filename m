Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C6BC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:36:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B767810ED64;
	Wed, 26 Aug 2026 16:36:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="Q15+B4Sb";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C293010ED51
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:36:20 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-499ae1c6471so5948265e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762179; x=1788366979;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=suzR7ASY40M8VgE4lgqLDHANl8DdGYCBb6jwppDWyAA=;
 b=Q15+B4SbOPxMrFSukJjfSoHtG6ZJc4KqDEC6Y6NXqbJDs9lvOQ7qY+1JSu2S4b+ZDe
 86FhavqplMkdfj5iWAiFV6d6g/5Eqljan0waRASaxegnSWSrJl1nKysFewJ4ivN/DSnZ
 bMtTE5R4CFCp4BwN9cs83bVF9+KkU1vWMLvRd7x9WUflvtzSuOjcO0OGSG8bKJ0J9QE5
 qEoAKfWaOScE3sv9KKML2fwFBK1o+rY6Ium44NB4bRhVOlz33pkMz8xAZCBwyuhRbT7T
 puBTksnOMV3JZYJIe9Zs0iEjgs4/kT8J+6ewviOi6nSSP+hVtWrLLSd7oswRgWyzRwhR
 AzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762179; x=1788366979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=suzR7ASY40M8VgE4lgqLDHANl8DdGYCBb6jwppDWyAA=;
 b=nWiA1J6EkoP23G9nSEXtrehiwGIKkMN5Js+SzMAcKF5J8BJkrZqLmmsWQ1Npc3Hrrk
 HpS+Kro9vnXE400BE3E2om2vvXdEWbsl7XxDJd/sawBEoKWzdtPfDTV55SoAsjmPceLP
 wzgG/icOUB3UVbnponCr0HPcoPtsnUuZP/EjmcC7A3Aj9weuJ26xk2m4WiH3zKbu7cI+
 3VtCvZ4oHqXXPjwfB7TCmX6NAsAMFTKYPugrKUCscns3ogtlu00VcZ/JUnLWB7jyIQEQ
 PG3N8XI0HQa7uzVLg3dxR1LAeV7Z4OKtvwTfERgTTTGiAew5FuecgsiDnnK1lcVxWpCP
 cVKA==
X-Gm-Message-State: AFuF++l0yWGIG8Mb0AdMPvkcnlGb7eUmrA7NX/2wp3OoNGpkv22Wdemx
 54OtOpHlRMEva9Y85JFJ9JAlvIuGxz6W5RQis+sgxBfFH4qmRzOGJ7HzFkZ7utBF9gz7U6wCCKr
 ufk7QRZc0
X-Gm-Gg: AR+sD12xfNkwvpYmtQf9z+4cCq+Lo/PQHT87vlWrMRnvqIttAWP7zbQH0dGl9rcY+uO
 dMN7+M93H+6HC0W7Snyo6pweNdW8wjYlfh35Ncfg8+61zAovahk98G5ffEzTZlICid6koZQjU0C
 bw/nMZqcUhcn0Hl4wscBhI278E3zX9D8BNZQIFfUvdOC5nNsrFYnd4tHlJ2X9Cj/Sh99qhXe3EP
 /nN62ybzmwnQQJOqp7uVgGvsIVrPfaMTw2cUVU28WueSg2DM9e+YPBAokwxxL/WiHHaTWKuL7kk
 AKgMIeF5SJQ11U273h4uRJHTwRMXiO9qbcaunmn4L6gXLcGcdk1yG7YJKX9x/nK7ZPZh3K/hOeE
 pbWGYyOKpCT2/qWRrZmkmw50K7tviS1NaDsdfz42oFjAC++3BQLQOPUEaLJxelmMSW0rM7TcLMa
 zkgktez+tz0Kqk+EXuKbTX9AF+0zDl+0cDKsn0dae4XVoVaKiYnoC5trIDXLyufR3tNmzk6/pVp
 +dnOFbeyJ4fMaPf9e81oc0kD8AyPEmmAOC75YZWz6nwnN4=
X-Received: by 2002:a05:600c:c8f:b0:499:cd34:f7c with SMTP id
 5b1f17b1804b1-499dc6f68b5mr69481545e9.5.1787762178738; 
 Wed, 26 Aug 2026 09:36:18 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:36:17 -0700 (PDT)
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
Subject: [PATCH v3 17/23] rust: drm: add an owned display mode constructor
Date: Wed, 26 Aug 2026 17:31:48 +0100
Message-ID: <20260826163359.4998-18-mike@fireburn.co.uk>
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

Add a safe constructor for standalone display modes used by drivers
and tests.

Accept the essential timing fields and reject invalid active, sync,
and total ordering before exposing the owned mode.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/kernel/drm/kms/modes.rs | 62 +++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/drm/kms/modes.rs b/rust/kernel/drm/kms/modes.rs
index cc3c486eecf1..b48a02edfc13 100644
--- a/rust/kernel/drm/kms/modes.rs
+++ b/rust/kernel/drm/kms/modes.rs
@@ -6,7 +6,33 @@
 
 use bindings;
 
-use crate::types::Opaque;
+use crate::{
+    error::{code::EINVAL, Result},
+    types::Opaque,
+};
+
+/// The essential timing fields of a display mode.
+#[derive(Clone, Copy)]
+pub struct ModeTimings {
+    /// Pixel clock in kHz.
+    pub clock_khz: i32,
+    /// Horizontal active pixels.
+    pub hdisplay: u16,
+    /// Start of the horizontal sync pulse.
+    pub hsync_start: u16,
+    /// End of the horizontal sync pulse.
+    pub hsync_end: u16,
+    /// Total horizontal pixels including blanking.
+    pub htotal: u16,
+    /// Vertical active lines.
+    pub vdisplay: u16,
+    /// Start of the vertical sync pulse.
+    pub vsync_start: u16,
+    /// End of the vertical sync pulse.
+    pub vsync_end: u16,
+    /// Total vertical lines including blanking.
+    pub vtotal: u16,
+}
 
 /// DRM kernel-internal display mode structure.
 ///
@@ -30,6 +56,40 @@ unsafe impl Send for DisplayMode {}
 unsafe impl Sync for DisplayMode {}
 
 impl DisplayMode {
+    /// Creates a standalone display mode from validated timings.
+    ///
+    /// This is useful when a driver needs an owned mode for validation or tests rather than a
+    /// reference to a mode owned by the DRM core.
+    pub fn from_timings(t: ModeTimings) -> Result<Self> {
+        if t.clock_khz <= 0
+            || t.hdisplay == 0
+            || t.hdisplay > t.hsync_start
+            || t.hsync_start > t.hsync_end
+            || t.hsync_end > t.htotal
+            || t.vdisplay == 0
+            || t.vdisplay > t.vsync_start
+            || t.vsync_start > t.vsync_end
+            || t.vsync_end > t.vtotal
+        {
+            return Err(EINVAL);
+        }
+
+        let mut mode = bindings::drm_display_mode::default();
+        mode.clock = t.clock_khz;
+        mode.hdisplay = t.hdisplay;
+        mode.hsync_start = t.hsync_start;
+        mode.hsync_end = t.hsync_end;
+        mode.htotal = t.htotal;
+        mode.vdisplay = t.vdisplay;
+        mode.vsync_start = t.vsync_start;
+        mode.vsync_end = t.vsync_end;
+        mode.vtotal = t.vtotal;
+
+        Ok(Self {
+            inner: Opaque::new(mode),
+        })
+    }
+
     /// Convert a raw pointer to a `struct drm_display_mode` into an immutable [`DisplayMode`] ref.
     ///
     /// # SAFETY
