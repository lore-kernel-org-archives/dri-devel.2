Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECD8C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0852510ED68;
	Wed, 26 Aug 2026 16:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="q3kIx52o";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42E8710ED68
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:36:53 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-499cb997b8fso7004085e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762212; x=1788367012;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DCczfjf9T7Ydp41TvxvDhWF+Y5rWcZbW/UfbMTxim7Q=;
 b=q3kIx52oWbqEJP9smYiQEV3szOjs6epcxJotfiWsQHrB18ApVNtlQLtPAJcPt+Y7L8
 5Sw1m7tk9UnkFD7OGfpvomJbm5R1K9ZyFFqIUVaLsgPcJ8sk/b7C3irxRpT8Hv7JCwXH
 +1YDMD76GJubUDO8THb2KvN+gT52VX/Pr3N7X7L2IpsDgLcUyqGRyJWu5NvHt4UusOhU
 bpLazv/bgPgxk/51YihjfJbUImiYDsgBbDDAc9qlwOomMS15dn/cttA713F+gf6+F+VA
 IrfkBl1f5AeFadVvTCzJF9GN9j/8HCPuXhYujiqhVmjzo4Qdn94J97D7mHLIjb7qAniY
 dysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762212; x=1788367012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DCczfjf9T7Ydp41TvxvDhWF+Y5rWcZbW/UfbMTxim7Q=;
 b=CBgvXiVb7GBlyg/LMEKPYzjH1yVnwZ5f1U6go8IydVnToEtWVWdU0jyKRVO8DmCetv
 5+K9Jnc58AVd7ESycejG7lDssUMSNOofA1JAdcT4Dyg8VTTnpSQpN9kpBAMI+Vu0bW7x
 sVNJt6Pg0slpUOaNeXjJLZRVSSGRXZvGR0ztT3HnRt66rHmBpC3nv3Rz/1xatICPbp8T
 Ga7JkcMFbV/GYNwgUWOiYhssW1NAcwkkxq6NVUw3Qah3f/H/B786oiiZPrWJBCD92G/t
 5/3yV1GIZ2YT4LvaHqCzwKSjNwVmXH+sUc7Zg4BFrieoPquvxyRYzb3hyyYKBk10NlVA
 y0jQ==
X-Gm-Message-State: AFuF++ns4TA8So6xlaP0uKc2wVRCRWgmrVpQgt6xzu9ZSMY/gcMK2W4u
 Mj5fjOY7BLdpM+yFeyaFK1Jtp+GuEojS4geJxuHohQZwqqu4CZorIkUx4hiLTLtT/KSWBbl/7uB
 geXZsuQC8
X-Gm-Gg: AR+sD112KWiWxuiqyuSB9QPec+deiUFULRWRYabF/A93QtNK8xRl/etEm2R0w0KB07J
 QkZVYzs99dwEjs+VSeeh4YV+Im0CfcPfHr83uYNww7kP6AhxJGH5gfFq6gGppqnBBra1VmJKbZE
 c2eT9AwM8IzTRnmBYFSxAz6VENLLMrmWIwtujuxh7/Vb7dfiy4oaD3l5fNaMakiwrkKXSj4y/GV
 7uDW6/tebpTfEGUS2EjckClJBrOtqsSToRk0bQtpIL48KCRorMPMvmQAYFKZKLPvjTbULbxyfQe
 fZX9a9F5ZFTTxI6wH5XROqWVEon43Hvcr1Sg/EvD0IXSssl7hHMNLu+tlqyzt/vThb/KUaKKuPW
 GcPQLNUhCLzOlYyx/xe55h8FiLVvSxKLU4F1TWkf8KG2w+f5CH3tKzi7OvOR4wn+0h7sTc6E7Uh
 ooPL21K8s7NOtXTj5ZOeQiT1EON1xeNmhZU0YIpT22q75jJZReoi4j0X1oZvH/cKP03tWgcti66
 8qJ3bF+kMe+ZDjRVtUfrfExPMTrygauzCMBWw==
X-Received: by 2002:a05:600c:4692:b0:499:da8b:1476 with SMTP id
 5b1f17b1804b1-499dc8306f2mr73366935e9.14.1787762211579; 
 Wed, 26 Aug 2026 09:36:51 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:36:46 -0700 (PDT)
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
Subject: [PATCH v3 21/23] rust: drm: kms: read a connector's colorimetry and
 HDR metadata
Date: Wed, 26 Aug 2026 17:31:52 +0100
Message-ID: <20260826163359.4998-22-mike@fireburn.co.uk>
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

A driver that carries a transfer function to its sink needs the connector
state's colorimetry and HDR_OUTPUT_METADATA, and needs to reach the
connector state routed to a CRTC from the CRTC's own atomic callback.

Add ConnectorState::hdr_output_eotf() and
AtomicState::new_connector_state_for_crtc().

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/kernel/drm/kms/atomic.rs    | 104 +++++++++++++++++++++++++++++++
 rust/kernel/drm/kms/connector.rs |  77 +++++++++++++++++++++++
 rust/kernel/drm/kms/crtc.rs      |  13 ++++
 3 files changed, 194 insertions(+)

diff --git a/rust/kernel/drm/kms/atomic.rs b/rust/kernel/drm/kms/atomic.rs
index 18dc136940f3..f9f91edc89c3 100644
--- a/rust/kernel/drm/kms/atomic.rs
+++ b/rust/kernel/drm/kms/atomic.rs
@@ -96,6 +96,88 @@ pub fn get_old_connector_state<C>(&self, connector: &C) -> Option<&C::State>
                 .map(|p| C::State::from_raw(p))
         }
     }
+
+    /// Return the new state of the first connector routed to `crtc` in this [`AtomicState`], if
+    /// any.
+    ///
+    /// This is the Rust spelling of walking `for_each_new_connector_in_state()` looking for
+    /// `conn_state->crtc == crtc`, which is how a CRTC callback reaches the connector properties
+    /// that describe the signal it is about to drive -- colorimetry, HDR metadata, `max bpc`.
+    /// Those live on the connector state, but the driver decisions they feed are frequently made
+    /// where only the CRTC is in hand.
+    ///
+    /// The state is returned opaquely because the caller is looking across mode objects and has
+    /// no way to name the connector's driver-private state type. A CRTC that clones to several
+    /// connectors gets the first; a driver that cares about the difference should walk the
+    /// connectors itself.
+    pub fn new_connector_state_for_crtc<C>(&self, crtc: &C) -> Option<&OpaqueConnectorState<T>>
+    where
+        C: ModesettableCrtc + ModeObject<Driver = T>,
+    {
+        let crtc_raw = crtc.as_raw();
+        // SAFETY: `state` is initialized via our type invariants, and `connectors` /
+        // `num_connector` are invariant for as long as we hold a reference to it.
+        let (connectors, num) = unsafe {
+            let raw = self.as_raw();
+            ((*raw).connectors, (*raw).num_connector)
+        };
+        if connectors.is_null() || num <= 0 {
+            return None;
+        }
+        for i in 0..num as usize {
+            // SAFETY: `connectors` points to `num_connector` initialized entries.
+            let new_state = unsafe { (*connectors.add(i)).new_state };
+            if new_state.is_null() {
+                continue;
+            }
+            // SAFETY: a non-null `new_state` is a valid `drm_connector_state` for the lifetime of
+            // the atomic state.
+            if unsafe { (*new_state).crtc } != crtc_raw {
+                continue;
+            }
+            // SAFETY: as above, and the returned reference borrows from `self`, so it cannot
+            // outlive the atomic state that owns the connector state.
+            return Some(unsafe { OpaqueConnectorState::<T>::from_raw(new_state) });
+        }
+        None
+    }
+
+    /// Return the old state of the first connector routed to `crtc` in this [`AtomicState`], if
+    /// any.
+    ///
+    /// The counterpart to [`Self::new_connector_state_for_crtc`], for a driver comparing the two
+    /// to decide whether a connector property it consumes has changed.
+    pub fn old_connector_state_for_crtc<C>(&self, crtc: &C) -> Option<&OpaqueConnectorState<T>>
+    where
+        C: ModesettableCrtc + ModeObject<Driver = T>,
+    {
+        let crtc_raw = crtc.as_raw();
+        // SAFETY: `state` is initialized via our type invariants, and `connectors` /
+        // `num_connector` are invariant for as long as we hold a reference to it.
+        let (connectors, num) = unsafe {
+            let raw = self.as_raw();
+            ((*raw).connectors, (*raw).num_connector)
+        };
+        if connectors.is_null() || num <= 0 {
+            return None;
+        }
+        for i in 0..num as usize {
+            // SAFETY: `connectors` points to `num_connector` initialized entries.
+            let old_state = unsafe { (*connectors.add(i)).old_state };
+            if old_state.is_null() {
+                continue;
+            }
+            // SAFETY: a non-null `old_state` is a valid `drm_connector_state` for the lifetime of
+            // the atomic state.
+            if unsafe { (*old_state).crtc } != crtc_raw {
+                continue;
+            }
+            // SAFETY: as above, and the returned reference borrows from `self`, so it cannot
+            // outlive the atomic state that owns the connector state.
+            return Some(unsafe { OpaqueConnectorState::<T>::from_raw(old_state) });
+        }
+        None
+    }
 }
 
 // SAFETY: DRM atomic state objects are always reference counted and the get/put functions satisfy
@@ -188,6 +270,28 @@ pub fn get_old_connector_state<C>(&self, connector: &C) -> Option<&C::State>
         self.state.get_old_connector_state(connector)
     }
 
+    /// Return the new state of the first connector routed to `crtc`, if any.
+    ///
+    /// See [`AtomicState::new_connector_state_for_crtc`]. This borrows the connector state rather
+    /// than taking a mutator out for it, so it does not participate in the mutator bookkeeping and
+    /// cannot conflict with [`Self::get_new_connector_state`].
+    pub fn new_connector_state_for_crtc<C>(&self, crtc: &C) -> Option<&OpaqueConnectorState<T>>
+    where
+        C: ModesettableCrtc + ModeObject<Driver = T>,
+    {
+        self.state.new_connector_state_for_crtc(crtc)
+    }
+
+    /// Return the old state of the first connector routed to `crtc`, if any.
+    ///
+    /// See [`AtomicState::old_connector_state_for_crtc`].
+    pub fn old_connector_state_for_crtc<C>(&self, crtc: &C) -> Option<&OpaqueConnectorState<T>>
+    where
+        C: ModesettableCrtc + ModeObject<Driver = T>,
+    {
+        self.state.old_connector_state_for_crtc(crtc)
+    }
+
     /// Retrieve the last committed atomic state for `plane` if `plane` has already been added to
     /// the atomic state being composed.
     ///
diff --git a/rust/kernel/drm/kms/connector.rs b/rust/kernel/drm/kms/connector.rs
index 952c8e02777b..231857cc1f20 100644
--- a/rust/kernel/drm/kms/connector.rs
+++ b/rust/kernel/drm/kms/connector.rs
@@ -922,7 +922,84 @@ fn connector(&self) -> &Self::Connector {
         // `self.state.connector` points to a valid instance of a `Connector<T>`
         unsafe { Self::Connector::from_raw((*self.as_raw()).connector) }
     }
+
+    /// The colorimetry userspace has requested through the `Colorspace` property, as a
+    /// [`enum drm_colorspace`] value.
+    ///
+    /// Meaningful only on a connector that
+    /// [`UnregisteredConnector::attach_colorspace_property`] was called for; everything else
+    /// leaves it at `DRM_MODE_COLORIMETRY_DEFAULT`.
+    ///
+    /// [`enum drm_colorspace`]: srctree/include/drm/drm_connector.h
+    fn colorspace(&self) -> u32 {
+        self.as_raw().colorspace
+    }
+
+    /// The electro-optical transfer function from the `HDR_OUTPUT_METADATA` blob, or [`None`] if
+    /// userspace has not set one.
+    ///
+    /// This is deliberately just the curve: the rest of the infoframe is mastering-display
+    /// metadata for the sink, and a driver that only needs to know *which curve the pixels are
+    /// encoded in* should not have to reason about the union's other members or their versioning.
+    ///
+    /// [`struct hdr_output_metadata`]: srctree/include/uapi/drm/drm_mode.h
+    fn hdr_output_eotf(&self) -> Option<Eotf> {
+        let blob = self.as_raw().hdr_output_metadata;
+        if blob.is_null() {
+            return None;
+        }
+        // SAFETY: a non-null `hdr_output_metadata` blob is valid for the state's lifetime.
+        let (data, length) = unsafe { ((*blob).data, (*blob).length) };
+        // DRM validates the blob length when the property is set, but this is the boundary where
+        // a short blob would become an out-of-bounds read.
+        if data.is_null() || length < core::mem::size_of::<bindings::hdr_output_metadata>() {
+            return None;
+        }
+        // SAFETY: the blob is at least a whole `hdr_output_metadata` and lives as long as the
+        // state. `eotf` is the first byte of the only union member DRM defines.
+        let eotf = unsafe {
+            (*data.cast::<bindings::hdr_output_metadata>())
+                .__bindgen_anon_1
+                .hdmi_metadata_type1
+                .eotf
+        };
+        Some(Eotf::from_raw(eotf))
+    }
+}
+/// An electro-optical transfer function named by a `HDR_OUTPUT_METADATA` blob.
+///
+/// Mirrors the `HDMI_EOTF_*` values in [`enum hdmi_eotf`]. A driver matches on this rather than
+/// comparing against the raw constants, so the one place that has to agree with the C enum is
+/// [`Eotf::from_raw`].
+///
+/// [`enum hdmi_eotf`]: srctree/include/linux/hdmi.h
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+pub enum Eotf {
+    /// Ordinary SDR gamma.
+    TraditionalGammaSdr,
+    /// The traditional HDR gamma curve.
+    TraditionalGammaHdr,
+    /// SMPTE ST 2084, i.e. PQ. What a compositor sets to drive an output in HDR10.
+    SmpteSt2084,
+    /// BT.2100 hybrid log-gamma.
+    Bt2100Hlg,
+    /// A value this kernel does not name, carried through rather than discarded.
+    Other(u8),
 }
+
+impl Eotf {
+    /// Classify the raw `eotf` byte from an infoframe.
+    fn from_raw(eotf: u8) -> Self {
+        match u32::from(eotf) {
+            bindings::hdmi_eotf_HDMI_EOTF_TRADITIONAL_GAMMA_SDR => Self::TraditionalGammaSdr,
+            bindings::hdmi_eotf_HDMI_EOTF_TRADITIONAL_GAMMA_HDR => Self::TraditionalGammaHdr,
+            bindings::hdmi_eotf_HDMI_EOTF_SMPTE_ST2084 => Self::SmpteSt2084,
+            bindings::hdmi_eotf_HDMI_EOTF_BT_2100_HLG => Self::Bt2100Hlg,
+            _ => Self::Other(eotf),
+        }
+    }
+}
+
 impl<T: AsRawConnectorState> RawConnectorState for T {}
 
 /// The main interface for a [`struct drm_connector_state`].
diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
index 9e888c4e2f68..ec01ae0430f7 100644
--- a/rust/kernel/drm/kms/crtc.rs
+++ b/rust/kernel/drm/kms/crtc.rs
@@ -1047,6 +1047,19 @@ pub(super) fn new<D: KmsDriver>(
     }
 }
 
+impl<'a, T: FromRawCrtcState> CrtcStateMutator<'a, T> {
+    /// Require a full mode set for this CRTC.
+    ///
+    /// Called from [`DriverCrtc::atomic_check`] when something the core does not track has changed
+    /// in a way the hardware can only adopt by being reprogrammed, such as a connector property
+    /// that forms part of the signal description the driver sends to its device.
+    pub fn set_mode_changed(&mut self, changed: bool) {
+        // SAFETY: `as_raw()` is a valid `drm_crtc_state`, and holding this mutator is proof that
+        // no other reference to it exists.
+        unsafe { (*self.as_raw()).set_mode_changed(changed) };
+    }
+}
+
 impl<'a, T: DriverCrtcState> CrtcStateMutator<'a, CrtcState<T>> {
     super::impl_from_opaque_mode_obj! {
         fn <D, C>(CrtcStateMutator<'a, OpaqueCrtcState<D>>) -> Self
