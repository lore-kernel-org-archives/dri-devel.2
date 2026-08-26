Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FEEC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77BAD10E31F;
	Wed, 26 Aug 2026 16:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="QXULX/Hw";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6984510E31C
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:35:28 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso9796285e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762127; x=1788366927;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eGf5rLY+VM/V7tx/TKkCWPRYXUV8BgBEPyz9uNJF8bI=;
 b=QXULX/Hw8p3Z3ItgYyveE3u6i09Iq2QfAqp7Wvyjh348slR22Kpc1pJhMEPNXxPBh6
 6LQVh4RANZb6HA5MXn6uOXre50U1Tl7lKRIsM5WfpsIupOWdD/klc4Acmo9k6zqyNOKM
 ZhSfWcvhH9q+UTzpTktLmmMuX8dJA7chhh5XY2miG+PeYf5d/zbvdRg//8F/c6tg02Nh
 pbfAxg7D417WIRD6WfuxwsSTO85E8hoQTa2+L8W5rsHDTrvzOLBZTz7IHOtAq1MeDfDf
 OStjG4p4d0fHAFP+ek6ne89AAGMeNSoY/3FZfXwrvAtuzaNxCsVOzeyd8hkyy5tD/y//
 TClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762127; x=1788366927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eGf5rLY+VM/V7tx/TKkCWPRYXUV8BgBEPyz9uNJF8bI=;
 b=o3qfigx0qTdrvJdLcMM1g4R8ER+RkjxzC8LvXMvtotatfeEXnyexXpUyBR42sFKzgm
 WzXHEOOVsAA5WrlxDgfI0z+CsAgIHZD62pgX/z5gjVEyBGj9oVsYO04JgGjpkeurdAUS
 Kq7rgBB4y8S9D+9LBwo99c/o+MBkCZ0XF7jq4xkt+tbkJOFcvEDxcsUkxPzK6RX5JROu
 5IqYAgqH3mQU41ypUeZ0MaAmP5eZBtqPY7KfYOoolcKrRNdXluQJs4TAH/xoxJ++HW15
 /5gGHgsn4Z4Syrt79tnMJm1M8Psmu6flLH9DLAVxGVMntI8YggggRVgHrn8bPMWUY4kj
 HVaQ==
X-Gm-Message-State: AFuF++ljLEqk4XGseAmHBE67KUgrbQEKfIs/5e52CS8JbisJDohL7yA8
 kPgJcWyFxY4qCmNxZXzWsJmWfRVY6Qxnff4SQE5fkkGDvY5OK5e/NNBNPzYPFQ3L4jd7C7220fg
 7xrKm32MJ
X-Gm-Gg: AR+sD11UPrn7VSQKLh/+ldPNnsnE4vIsDe4rPAF6ojTL8AP9bAuJz8AcWl0pcYrWkiF
 EMCb3nSv5DAm1S/06Mf3UrKspX01eaTGVhfi4Z5j9buMhbNswqMAq1q2RPHXIlhu8gogOt2PKAc
 0nhsutb3mdjggm1quya3fIkQ8NTIjVBWHnNkp/4/Se3fUwZ2Rd8+Kklmag7ZkFWoe+deXnPrLsM
 spI9T6yzUwe5qz5ogUBuUsds8D3oA/ZbEN7WKL9zZih/J/zEG2rqI2c+mSSlDT33wMo9CDLrDtH
 e6HyZqM3AhjKzK1vnDkRh2/EknNLGH3u1RZCdHMY6LVwwsHtRvg0xHJghM3lAKy1/ZpJzKX66Wi
 0FA8MuEk85SRz1+f+PqVb0AxMkLjUYQeWCRymuPG1ujmbNfDi5IWlriz4pAsZCHmcEtBSF4o0mF
 GQsWa/RIlvKbICKDtIVwpL5cN/tsXnDRL88LpgWFOP6S/VLS88/t6Xo4gKf0Qne87DpkDNjGwzO
 AyB1ZjHuSjoFTZTGa20D9oXhlToIX/G+2dk
X-Received: by 2002:a05:600c:a086:b0:499:b000:b828 with SMTP id
 5b1f17b1804b1-499dc6e9a9dmr93015675e9.4.1787762126720; 
 Wed, 26 Aug 2026 09:35:26 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:35:25 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
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
Subject: [PATCH v3 8/23] rust: drm: kms: add connector detect() and
 mode_valid() hooks
Date: Wed, 26 Aug 2026 17:31:39 +0100
Message-ID: <20260826163359.4998-9-mike@fireburn.co.uk>
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

Add optional connector detect() and mode_valid() callbacks to the
safe KMS API.

Map connector status and common mode-validation results through typed
enums. Connectors which do not implement the callbacks retain the
DRM defaults of connected and mode-valid.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/kernel/drm/kms/connector.rs | 141 ++++++++++++++++++++++++++++++-
 1 file changed, 138 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/kms/connector.rs b/rust/kernel/drm/kms/connector.rs
index 793a7bb5bfef..dd126469788f 100644
--- a/rust/kernel/drm/kms/connector.rs
+++ b/rust/kernel/drm/kms/connector.rs
@@ -5,7 +5,8 @@
 //! C header: [`include/drm/drm_connector.h`](srctree/include/drm/drm_connector.h)
 
 use super::{
-    atomic::*, encoder::*, KmsDriver, ModeConfigGuard, ModeObject, ModeObjectVtable, Sealed,
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
@@ -106,7 +144,11 @@ pub trait DriverConnector: Send + Sync + Sized {
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
@@ -114,7 +156,11 @@ pub trait DriverConnector: Send + Sync + Sized {
             color_format: None,
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
@@ -153,6 +199,31 @@ fn get_modes<'a>(
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
+    fn mode_valid(
+        _connector: ConnectorModeValidation<'_, Self>,
+        _mode: &DisplayMode,
+    ) -> ModeStatus {
+        build_error::build_error("This should not be reachable")
+    }
 }
 
 /// The generated C vtable for a [`DriverConnector`].
@@ -477,6 +548,32 @@ impl<T: AsRawConnector> RawConnector for T {}
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
+    // DRM invokes the connector helper while the mode list is stable. Keep that guarantee in a
+    // capability type so drivers can safely compare this mode with the other probed modes.
+    T::mode_valid(ConnectorModeValidation(connector), mode) as bindings::drm_mode_status
+}
+
 /// A [`struct drm_connector`] without a known [`DriverConnector`] implementation.
 ///
 /// This is mainly for situations where our bindings can't infer the [`DriverConnector`]
@@ -572,6 +669,44 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
+/// A connector being validated while its mode list is stable.
+///
+/// This is only constructed by the DRM connector-helper callback. It permits read-only iteration
+/// over the connector's modes without exposing list pointers or extending a mode reference beyond
+/// the callback.
+#[derive(Copy, Clone)]
+pub struct ConnectorModeValidation<'a, T: DriverConnector>(&'a Connector<T>);
+
+impl<T: DriverConnector> Deref for ConnectorModeValidation<'_, T> {
+    type Target = Connector<T>;
+
+    fn deref(&self) -> &Self::Target {
+        self.0
+    }
+}
+
+impl<T: DriverConnector> ConnectorModeValidation<'_, T> {
+    /// Return whether any mode currently on this connector satisfies `predicate`.
+    pub fn any_mode(&self, mut predicate: impl FnMut(&DisplayMode) -> bool) -> bool {
+        let raw = self.as_raw();
+        // SAFETY: DRM only constructs this capability while `connector->modes` is stable. Each
+        // list entry is an initialized `drm_display_mode`, and the shared reference is confined to
+        // this callback invocation.
+        unsafe {
+            let head: *mut bindings::list_head = &raw mut (*raw).modes;
+            let mut node = (*head).next;
+            while node != head {
+                let mode = crate::container_of!(node, bindings::drm_display_mode, head);
+                if predicate(DisplayMode::as_ref(mode)) {
+                    return true;
+                }
+                node = (*node).next;
+            }
+        }
+        false
+    }
+}
+
 impl<'a, T: DriverConnector> ConnectorGuard<'a, T> {
     /// Add modes for a [`ConnectorGuard`] without an EDID.
     ///
