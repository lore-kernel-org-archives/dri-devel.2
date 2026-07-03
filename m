Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCE9C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7152810F60A;
	Fri,  3 Jul 2026 03:02:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="KCQKVlP6";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9095110F60A
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:02:15 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-476a130c138so111064f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047734; x=1783652534;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=676W53NrP+v1JtRit87SUFwRygfrhSqyRXaV/N96IbY=;
 b=KCQKVlP6ZLMoT+4ljOQYzvaxL1CCt7dhgeAuCXwctqcKYTHAzuVbO5YZiYZefvz9IU
 N/PxHyeSSk/H0XavUAYXoP1WOppSgaLvpv0M1++BCD+LlCfx0aJLj2ppqa2mDsZvyeHp
 YpOeoHbpU5Op6T9esWSP7KK11ygserMw1U3Q1L+0sHGn8W5JJ/FHFBasCInXiE8WdwPZ
 TXgQqjQq1uzMCVibsxu3886+qX3qfkk4UUpCrsLlgm/sCH3fX9Lek/y8YjkclOkfWyAX
 1VL79CRYBbtnaScYA8woRUP3JgvssZe+4I8axAAGtznScz3N7boJ61z8I39C3LWZ2Npz
 Uy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047734; x=1783652534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=676W53NrP+v1JtRit87SUFwRygfrhSqyRXaV/N96IbY=;
 b=GSy3fVTb39wJTxnU0cxaXeDOfdsn5LVF7whvuLCBhUNF111zbDJLBdKnZpgVjLeYVH
 78BUx4xqiRt1IcAAmWo2whBX7nGNt5HTdR4zeecjL7B5qu1ScbOYEsa4dJ6DASJ/duje
 KCP9NGT2EGAk08bsazPHnUQqY17CSN0cIaIDuV4mG/+hClxxSg1ySSKCFgraaYjCXHtD
 fRBjIa37WgvzBvj7BYgorHYOhaL8vnJu+qvIKKX885v6eE4ng06eusjPxamSaQ5rqXM4
 75QzeFf5+bk/NbiaOmRgm+zpqkSQSkAV/eIr0uhIyMAXkNuZzsONGhKAqCGraKs0emrF
 tA2A==
X-Gm-Message-State: AOJu0YwMJ3V4MIQdtMbJjbu/Md0wiHzSDeMv097NjgMkzetTFLb0a3wW
 b2MnUu9ZddGmj+S3hUigaT+jaSNzZ0ry+Yl0wXnPYTVviswhpXU7cVX3UFdbijPNorX8WD1fWCC
 4g715LIgl
X-Gm-Gg: AfdE7cnn+iDity9giCw8E6FZK6QKBdqD/3WSZQeMoo2qFn38JNq0DxJm1qe8E4/2Crd
 S4zPnWshCCmHVVPZ33gOe9SqvyX/RiNoGy0zxJCGQwiPyrpuYBfAByem9cpZqT85gP47zgSURRl
 +yMM3wiwXmp1y8o7dJTz8bCozY5WDzBHfje227CypaRADue12LoYOh0JPNVtByKJBFUvc48Csex
 M3U+YzY0v+baHGehyI3ePHClE7r7EylndhfVE2+2SseMiyC1p2++SCuchZvB5uvZXTEXiS0Y5Xq
 Mst43HeJ7o/xITVxYxhuYaSFwIKbUSAmGMe8HqXD4eTaWW0oH8njs6Ax3pvRfneMvC8TVoqy+f0
 c2M8eYoklTqmRFdDDxP1C56Dl5tjhWPibepy+wYefk7EgKMu2ug3q7pD2gAoYOziSqTAlxhXTIF
 26t6uSBRtWZwPJB27hLR2FgiSGos+0ADWNZJPOg8ijrLCVZStyJukQQGrq
X-Received: by 2002:a5d:5588:0:b0:475:f100:35f5 with SMTP id
 ffacd0b85a97d-477b5c415a8mr9292156f8f.50.1783047733914; 
 Thu, 02 Jul 2026 20:02:13 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14466500f8f.4.2026.07.02.20.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:02:13 -0700 (PDT)
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
Subject: [RFC PATCH v2 17/18] rust: drm: kms: add connector detect() and
 mode_valid() hooks
Date: Fri,  3 Jul 2026 04:01:04 +0100
Message-ID: <20260703030123.2814-18-mike@fireburn.co.uk>
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

The safe connector layer only exposed get_modes(), so a driver couldn't
report hotplug state or prune modes it can't drive. Add two optional
DriverConnector hooks, gated the same way as the plane/CRTC optionals
(registered in the vtable only when the driver overrides them):

  - detect(&Connector, force) -> Status, wired to
    drm_connector_funcs.detect, returning a new Status enum
    (Connected/Disconnected/Unknown mapping to enum drm_connector_status).

  - mode_valid(&Connector, &DisplayMode) -> ModeStatus, wired to
    drm_connector_helper_funcs.mode_valid, returning a new ModeStatus enum
    (Ok/Bad/ClockHigh/ClockLow, a common subset of enum drm_mode_status).

Both leave DRM's default behaviour (always connected, all modes valid)
unchanged for connectors that don't implement them.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 rust/kernel/drm/kms/connector.rs | 98 +++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/kms/connector.rs b/rust/kernel/drm/kms/connector.rs
index 591153de7ab4..a66243db8868 100644
--- a/rust/kernel/drm/kms/connector.rs
+++ b/rust/kernel/drm/kms/connector.rs
@@ -5,7 +5,8 @@
 //! C header: [`include/drm/drm_connector.h`](srctree/include/drm/drm_connector.h)
 
 use super::{
-    atomic::*, encoder::*, KmsDriver, ModeConfigGuard, ModeObject, ModeObjectVtable, Sealed
+    atomic::*, encoder::*, modes::DisplayMode, KmsDriver, ModeConfigGuard, ModeObject,
+    ModeObjectVtable, Sealed,
 };
 use crate::{
     alloc::KBox,
@@ -72,6 +73,43 @@ pub enum Type {
     USB         as Usb
 }
 
+/// The connection status of a [`Connector`], as returned by [`DriverConnector::detect`].
+///
+/// This is identical to [`enum drm_connector_status`].
+///
+/// [`enum drm_connector_status`]: srctree/include/drm/drm_connector.h
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+#[repr(u32)]
+pub enum Status {
+    /// The connector is connected to a display and a mode list can be retrieved.
+    Connected = bindings::drm_connector_status_connector_status_connected,
+    /// The connector has no display attached.
+    Disconnected = bindings::drm_connector_status_connector_status_disconnected,
+    /// The connection state could not be determined (treated as connected for probing).
+    Unknown = bindings::drm_connector_status_connector_status_unknown,
+}
+
+/// The result of validating a display mode against a [`Connector`], as returned by
+/// [`DriverConnector::mode_valid`].
+///
+/// This mirrors a small, commonly-used subset of [`enum drm_mode_status`]; use [`ModeStatus::Bad`]
+/// for a generic rejection, or the clock-specific variants when a mode is out of the driver's
+/// pixel-clock range.
+///
+/// [`enum drm_mode_status`]: srctree/include/drm/drm_modes.h
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+#[repr(i32)]
+pub enum ModeStatus {
+    /// The mode is usable.
+    Ok = bindings::drm_mode_status_MODE_OK,
+    /// The mode is rejected for an unspecified reason.
+    Bad = bindings::drm_mode_status_MODE_BAD,
+    /// The mode's pixel clock is above what the driver can drive.
+    ClockHigh = bindings::drm_mode_status_MODE_CLOCK_HIGH,
+    /// The mode's pixel clock is below what the driver can drive.
+    ClockLow = bindings::drm_mode_status_MODE_CLOCK_LOW,
+}
+
 /// The main trait for implementing the [`struct drm_connector`] API for [`Connector`].
 ///
 /// Any KMS driver should have at least one implementation of this type, which allows them to create
@@ -105,14 +143,22 @@ pub trait DriverConnector: Send + Sync + Sized {
             atomic_destroy_state: Some(atomic_destroy_state_callback::<Self::State>),
             destroy: Some(connector_destroy_callback::<Self>),
             force: None,
-            detect: None,
+            detect: if Self::HAS_DETECT {
+                Some(detect_callback::<Self>)
+            } else {
+                None
+            },
             fill_modes: Some(bindings::drm_helper_probe_single_connector_modes),
             debugfs_init: None,
             oob_hotplug_event: None,
             atomic_duplicate_state: Some(atomic_duplicate_state_callback::<Self::State>),
         },
         helper_funcs: bindings::drm_connector_helper_funcs {
-            mode_valid: None,
+            mode_valid: if Self::HAS_MODE_VALID {
+                Some(mode_valid_callback::<Self>)
+            } else {
+                None
+            },
             atomic_check: None,
             get_modes: Some(get_modes_callback::<Self>),
             detect_ctx: None,
@@ -151,6 +197,28 @@ fn get_modes<'a>(
         connector: ConnectorGuard<'a, Self>,
         guard: &ModeConfigGuard<'a, Self::Driver>,
     ) -> i32;
+
+    /// The optional [`drm_connector_funcs.detect`] hook for this connector.
+    ///
+    /// Drivers may implement this to report whether a display is currently attached. If not
+    /// implemented, the connector is always considered connected (DRM's default with no `detect`
+    /// hook). `force` is set when userspace explicitly requested a forced probe.
+    ///
+    /// [`drm_connector_funcs.detect`]: srctree/include/drm/drm_connector.h
+    fn detect(_connector: &Connector<Self>, _force: bool) -> Status {
+        build_error::build_error("This should not be reachable")
+    }
+
+    /// The optional [`drm_connector_helper_funcs.mode_valid`] hook for this connector.
+    ///
+    /// Drivers may implement this to reject modes they cannot drive (for example, a mode whose
+    /// pixel clock exceeds the hardware's budget). Returning anything other than [`ModeStatus::Ok`]
+    /// prunes the mode from the probed list. If not implemented, every mode is accepted.
+    ///
+    /// [`drm_connector_helper_funcs.mode_valid`]: srctree/include/drm/drm_modeset_helper_vtables.h
+    fn mode_valid(_connector: &Connector<Self>, _mode: &DisplayMode) -> ModeStatus {
+        build_error::build_error("This should not be reachable")
+    }
 }
 
 /// The generated C vtable for a [`DriverConnector`].
@@ -464,6 +532,30 @@ impl<T: AsRawConnector> RawConnector for T {}
     T::get_modes(connector.guard(&guard), &guard)
 }
 
+unsafe extern "C" fn detect_callback<T: DriverConnector>(
+    connector: *mut bindings::drm_connector,
+    force: bool,
+) -> bindings::drm_connector_status {
+    // SAFETY: This is safe via `DriverConnector`s type invariants.
+    let connector = unsafe { Connector::<T>::from_raw(connector) };
+
+    T::detect(connector, force) as bindings::drm_connector_status
+}
+
+unsafe extern "C" fn mode_valid_callback<T: DriverConnector>(
+    connector: *mut bindings::drm_connector,
+    mode: *const bindings::drm_display_mode,
+) -> bindings::drm_mode_status {
+    // SAFETY: This is safe via `DriverConnector`s type invariants.
+    let connector = unsafe { Connector::<T>::from_raw(connector) };
+
+    // SAFETY: DRM guarantees `mode` points to a valid `drm_display_mode` for the duration of this
+    // callback, and only passes us shared access to it.
+    let mode = unsafe { DisplayMode::as_ref(mode) };
+
+    T::mode_valid(connector, mode) as bindings::drm_mode_status
+}
+
 /// A [`struct drm_connector`] without a known [`DriverConnector`] implementation.
 ///
 /// This is mainly for situations where our bindings can't infer the [`DriverConnector`]
-- 
2.55.0

