Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCD8C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CE6810ED65;
	Wed, 26 Aug 2026 16:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="PjJWFLr1";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 306A310ED65
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:36:37 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-499b57cf2f3so528255e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762195; x=1788366995;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q/LkgDOv9ZSq7jkZTw2AZHwZhduIehY/kgCXnvUKoCU=;
 b=PjJWFLr1nqH106Nh44GN6jxv9IIjUahrzkRXSqlrgt7GOFVLo4vC2Ia8V185guB+zg
 eknSXdidr5R0yBVYA/u/G/862ncbErb2Z/l2+kzNJmPBUbQ9mToSXApNQJ7/l2yhoHnt
 YgIQVkIOcFAALcn4yxd0SN3V2cqVA2wAdfXTpLp8EJ5TsjCuvCeak12EbZu4ItDUsJef
 WE86JC6OQ+8P3SvfWa1YNWLdFkhLgAYebUub0brapcgsfq1+jIyT//klHMzUOgV9gnAo
 1VmCOcJ0NHT4USzPXhcB1G5cSXs4sThoVMmg/EOE/BWRpmEayvkMPVnGlmL3TwGqdBBa
 VumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762195; x=1788366995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q/LkgDOv9ZSq7jkZTw2AZHwZhduIehY/kgCXnvUKoCU=;
 b=VJIIdV2/ya0KRUyS5aXopvxprlcVTUjoLIPakc0b096elJTqc6JTWeVQaa1bgKJTyb
 L9JmWlbrp8d31lyJ58cZcXE8YyNg3AENyrP+w2gza9koFRMRBgw9UAL3NMwzVXlN5Epc
 QtL3ZRzqzA4XoaoBscHi+HpW9a+zVgG64Ip0Wbl/9pgblaJL2IZXPaNc0PvFTLajyRmN
 muoViGfshYs6EluUOFQbsSimFDRYOP+6zjeKEvl82WEn9fcgNIJUCxwvgphPvp2dn80S
 7A3E0U7oVBF8KjkZx/B/taDEpoSDiLroSmsPTxUriWZE6DvlvOTSHJTwKX3JxPqm7r4D
 EwrQ==
X-Gm-Message-State: AFuF++m5qf5m60khR5Uh3pqu1l+a8o+l9r+wrdR0vvx/C0ifoPOudlWh
 zVFjAFpJzFQF8IsgtqtZIoKqJtuRH3vqyUTMXmKxD+6WfxY6kyviVpGeX6innps1D4k1E1FhES0
 OxABdb01+
X-Gm-Gg: AR+sD10lnNwxGx7yEHyo7VJ7AfOrnuU7plDzsqdEuFZW7Apb4xJi3tTOrlHbVPXq8OD
 BegjXOaA2t3K4/4vXQEN2uPPfg6k/9J8SBwkvhELnUDGMvC8HfifPxPR2rYwzjWmqHJj6AvIY73
 JKj+Ygs/ei3nzaxJPwr/QGcDB3XyKKdESL8AOk6WK/3KGujqjub5NBfU7EzKwrDJ+Z11sYG8P1j
 yQjL3e+TPSQeqMPYIf12nJtzoPcyCeMeEmdHm8MHGvUr9aOtDVIlkJzynw6neGjivh+V2ohRUlC
 vieCCs70zSUYqTLyg8pBir9qHbSop1/DByz/pQww75I0ryI0QjvfWjuVaTK9x43/rXAe07igzkW
 q35LtUZYINv4a5/BbaPHo8hg3KE7b34Bc6GzRI6OD60tKZZr8UB0FziDOLdKhVlQqIxgq7x+jEk
 0ha8rH1NaV5gjqiqGS8dlkezCBptQtD0cNtcMb5eswP9sfjub5ay8yQswbzY9QViXxzQZ1HkVlz
 BsHSvYH41G2ceOSZk87E40o/ivnUcXvCoDS
X-Received: by 2002:a05:600c:6792:b0:49a:5b84:a1a6 with SMTP id
 5b1f17b1804b1-49b0dec57b6mr5628835e9.5.1787762195531; 
 Wed, 26 Aug 2026 09:36:35 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:36:34 -0700 (PDT)
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
Subject: [PATCH v3 20/23] rust: drm: kms: add synthesized CVT connector modes
Date: Wed, 26 Aug 2026 17:31:51 +0100
Message-ID: <20260826163359.4998-21-mike@fireburn.co.uk>
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

Expose a lock-scoped helper for adding a driver-synthesized CVT timing
to a connector probe result. This lets virtual and transport-backed
displays offer valid continuous-frequency modes without reaching into
DRM mode lists.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/kernel/drm/kms/connector.rs | 84 ++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/rust/kernel/drm/kms/connector.rs b/rust/kernel/drm/kms/connector.rs
index dd126469788f..952c8e02777b 100644
--- a/rust/kernel/drm/kms/connector.rs
+++ b/rust/kernel/drm/kms/connector.rs
@@ -495,6 +495,60 @@ pub fn attach_encoder<E>(&self, encoder: &UnregisteredEncoder<E>) -> Result
             bindings::drm_connector_attach_encoder(self.as_raw(), encoder.as_raw())
         })
     }
+
+    /// Attach the HDR output metadata property to this [`Connector`].
+    ///
+    /// This property carries a blob supplied by userspace. Drivers must still validate and apply
+    /// the metadata in their atomic commit path before claiming that HDR output is supported.
+    pub fn attach_hdr_output_metadata_property(&self) {
+        // SAFETY: `self` is an initialized connector owned by this DRM device. The helper only
+        // attaches the mode-config-owned standard property to its mode object.
+        unsafe {
+            bindings::drm_connector_attach_hdr_output_metadata_property(self.as_raw());
+        }
+    }
+
+    /// Create and attach the standard DP colorspace property to this [`Connector`].
+    ///
+    /// A zero mask asks DRM to expose every colorspace defined for DisplayPort. A driver must
+    /// still reject values its sink or transport cannot actually carry in its atomic check.
+    pub fn attach_colorspace_property(&self) -> Result {
+        to_result(unsafe { bindings::drm_mode_create_dp_colorspace_property(self.as_raw(), 0) })?;
+        // SAFETY: the successful create call above initialized `colorspace_property` for this
+        // connector; the C helper only attaches that property to this connector's mode object.
+        to_result(unsafe { bindings::drm_connector_attach_colorspace_property(self.as_raw()) })
+    }
+
+    /// Attach the standard `max bpc` range property to this [`Connector`].
+    ///
+    /// `min_bpc` and `max_bpc` are validated before conversion so callers cannot wrap an invalid
+    /// range through the C `int` API. DRM requires the connector to have an atomic state before
+    /// this helper is called; newly-created Rust connectors acquire that state here.
+    pub fn attach_max_bpc_property(&self, min_bpc: u32, max_bpc: u32) -> Result {
+        if min_bpc == 0 || min_bpc > max_bpc || max_bpc > i32::MAX as u32 {
+            return Err(EINVAL);
+        }
+
+        // `drm_connector_attach_max_bpc_property()` writes the initial bpc values into the
+        // connector state. `KmsDriver::create_objects()` runs before the mode-config-wide reset,
+        // so initialize our state through the driver's Rust reset callback when necessary.
+        let state = unsafe { (*self.as_raw()).state };
+        if state.is_null() {
+            // SAFETY: `self` is a newly initialized `Connector<T>` and this unregistered typestate
+            // prevents concurrent access. The callback creates the matching `ConnectorState<T>`.
+            unsafe { connector_reset_callback::<T::State>(self.as_raw()) };
+        }
+
+        // SAFETY: `self` is initialized and now owns a connector state. The validated bounds fit
+        // the C API's signed integer parameters, and the helper only installs a DRM core property.
+        to_result(unsafe {
+            bindings::drm_connector_attach_max_bpc_property(
+                self.as_raw(),
+                min_bpc as i32,
+                max_bpc as i32,
+            )
+        })
+    }
 }
 
 /// Common methods available on any type which implements [`AsRawConnector`].
@@ -723,6 +777,36 @@ pub fn set_preferred_mode(&self, (h_pref, w_pref): (u32, u32)) {
         unsafe { bindings::drm_set_preferred_mode(self.as_raw(), h_pref, w_pref) }
     }
 
+    /// Add a driver-synthesised CVT mode to this connector's probed mode list.
+    ///
+    /// For a display whose EDID declares continuous frequencies, a driver may legitimately offer a
+    /// timing the EDID does not itself enumerate. `reduced` selects CVT reduced blanking (CVT-RB),
+    /// which matters when the *pixel clock* rather than the pixel rate is the constrained
+    /// resource -- RB cuts the clock for the same active pixels.
+    ///
+    /// Returns `EINVAL` if the core could not build the timing.
+    pub fn add_cvt_mode(
+        &self,
+        hdisplay: i32,
+        vdisplay: i32,
+        vrefresh: i32,
+        reduced: bool,
+    ) -> Result {
+        let dev = self.drm_dev().as_raw();
+        // SAFETY: `dev` is this connector's live `drm_device`; `drm_cvt_mode` only computes a
+        // timing and allocates it, and we hold the mode-config lock via our type invariants.
+        let mode = unsafe {
+            bindings::drm_cvt_mode(dev, hdisplay, vdisplay, vrefresh, reduced, false, false)
+        };
+        if mode.is_null() {
+            return Err(EINVAL);
+        }
+        // SAFETY: `mode` was just allocated by `drm_cvt_mode` and ownership passes to the
+        // connector here; we hold the locks required to modify its mode list.
+        unsafe { bindings::drm_mode_probed_add(self.as_raw(), mode) };
+        Ok(())
+    }
+
     /// Parse an EDID, update the connector information, and add its advertised modes.
     ///
     /// Returns the number of modes added.
