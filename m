Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0B6C43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 784F810F5F0;
	Fri,  3 Jul 2026 03:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="r/gZ0rrg";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0413610F5F0
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:01:40 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-493be1b9564so291945e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047698; x=1783652498;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P/nbseqGkYcWLUDS4YgM1HcuWcHd/PeuOx3gHx4QCk0=;
 b=r/gZ0rrgpX23aRbnKpT5A/GHjVNM+AjtnZdKYLIscJr5wVJpjzKKhUnQQzkRObqsFV
 9lq88KbfvQw/2CEL+z+p9oDalZaAMqAgILRH/4QQTI46LnIE1rJ1hGyyqlLPJbsxrOg+
 Q+6BuM4ggjQ74xyyHzAJbD2MiB/q/mu/sK4tjX5nI4To3TAC4sO36Ih1ZwKWTt3tmZou
 pWN2tT66AAKbpAW5NunqKY7vOYH/rZxFAva0TbaIfA6hjytRkgxQDd1HRNPlTkotSfZc
 KByhPGux+PBWvzbmBl2tUxiySmApFMFgNhd/tpM6PREbmjxmJ2wxI1qWX6xtijxT1uy6
 8zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047698; x=1783652498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=P/nbseqGkYcWLUDS4YgM1HcuWcHd/PeuOx3gHx4QCk0=;
 b=qsgAOWhOfTUQeEuf5xW5f9t2qa9jCaH/LREAHyxpfQdFMqZjfsOorL/2Oki/nMUwpg
 TABdvrPzGQ2ESIFcwU3gWlZDgTHdbZDzOny5EdAeVf1dz4AOYurnZrJn4sWJiPpLqe1p
 ljnAh+Q6v0Rn635zw6mYqsswVwVVc4OsJ0C8Wgrm3PxwTf2UQHohgjhOmNljYpfa1Rey
 ipnJLDIAfmK9+hwHPskU56Ll7VnKO9U0DEZsExKE6sBO42zaA27AhaoZQ0rQX+hE9/6G
 69j4gWTnzf1QnJKQObj5OZ6T7eOaRaGOFgkXb5sxkLJomZeIMWYHACisXF1EHAybCrQq
 m0jQ==
X-Gm-Message-State: AOJu0Yz7S3yRhJDwD9K1d4wW4N0bZGoow4uBoKjl1PcPvSjX4ZnhPU9y
 a4YYOhOT+cvZrZvm4bIpesUc3HDNYW+aEekqJ90OX/JYmlk/mB/zhGT9JnDZowj8gg==
X-Gm-Gg: AfdE7cn/aYlP944XoNGTaL3QXIIjkWcd3Nf7D6QPCIyQb0lDznWde6H+dx1F3+V8e4V
 8IfumVtNV/uXYiBcEKiQHYQmWYGmQgZCi5wPiAKm9RU808eXBhGeytm8cX2k+Gpp/9iN4RNKVyz
 NPWUkozIEJ+1U2ENupzqP+dzGQ42QCyw1E6Mym/s18+Vi608ww3sPWqC1BHIwaw1GjZa3GkTRh8
 K9tSJDxiDu0qvPKkL1dt8ZEbLrS+HPlxZP0DsXRqzoB8Xpdx00xJ0PbXAfcJeEdVPkZUz6agBju
 nTfZpzqkTYc/ZM0Kb8H6JpqCisnhLArtva2if4HtWc7mLK/B0630SZ1wZp0LBZ4auZGgRgE+p/k
 goitARcHuSC/rdzXvfjE6e0pgFGdsfdZPXTpC/7aZ24Hg5oXtc1srMGqF5fcPaArqwk8dPf3N40
 zZmdPv/C+Q2UgzDIVl6+p5TdJcK6BkcOdw1A+syLwVNJmhDUFAmkNPNcwc
X-Received: by 2002:a05:600c:5391:b0:490:c032:ae92 with SMTP id
 5b1f17b1804b1-493c3df2b42mr101737415e9.33.1783047698330; 
 Thu, 02 Jul 2026 20:01:38 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbacbsm14466500f8f.4.2026.07.02.20.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:01:37 -0700 (PDT)
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
Subject: [RFC PATCH v2 03/18] rust: drm: kms: break the Driver* trait
 well-formedness cycle
Date: Fri,  3 Jul 2026 04:00:50 +0100
Message-ID: <20260703030123.2814-4-mike@fireburn.co.uk>
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

The ported mode-object trait web (KmsDriver / DriverConnector /
DriverConnectorState / VblankImpl, ...) is mutually recursive: a
Modesettable* impl for Crtc<T::Crtc> needs <T::Crtc::State>::Crtc:
DriverCrtc, which needs <T::Crtc::State::Crtc::State>::Crtc, and so on
-- an infinite projection regress the trait solver can't terminate on
unless the associated-state types are pinned to State<Assoc = Self>.

Pin them, add the where-clauses the *StateMutator Deref/DerefMut impls
now need once callers pass through the pinned types, and fix a
from_opaque copy-paste bug in CrtcStateMutator that was reading Plane's
fields instead of Crtc's.

This still doesn't build clean: pinning trades the projection regress
for a coinductive cycle in the from_opaque-on-state impls, which the
current (non-next-gen) trait solver exhausts memory on instead of
resolving. See the following commit.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-sonnet-5 [Claude-Code]
---
 rust/kernel/drm/kms.rs           | 28 +++++++++++++---------------
 rust/kernel/drm/kms/connector.rs | 27 ++++++++++++++++++++-------
 rust/kernel/drm/kms/crtc.rs      | 31 +++++++++++++++++++++----------
 rust/kernel/drm/kms/plane.rs     | 27 ++++++++++++++++++++-------
 rust/kernel/drm/kms/vblank.rs    |  5 +++--
 5 files changed, 77 insertions(+), 41 deletions(-)

diff --git a/rust/kernel/drm/kms.rs b/rust/kernel/drm/kms.rs
index a147276b3412..d07389fd510c 100644
--- a/rust/kernel/drm/kms.rs
+++ b/rust/kernel/drm/kms.rs
@@ -122,25 +122,23 @@ fn deref(&self) -> &Self::Target {
 /// [`PhantomData<Self>`]: PhantomData
 #[vtable]
 pub trait KmsDriver: Driver {
-    /// The driver's [`DriverConnector`](connector::DriverConnector) implementation.
-    ///
-    /// TODO: This will be unneeded once we support multiple `DriverConnector` implementations.
-    type Connector: connector::DriverConnector<Driver = Self>;
+    // The driver's mode-object implementations. Left *unbounded* to break a trait
+    // well-formedness cycle: the natural bound (`type Crtc: DriverCrtc<Driver = Self>`, etc.)
+    // makes every `T: KmsDriver` obligation pull in the mutually-recursive Driver* web, which
+    // the compiler cannot evaluate (it loops in obligation processing and exhausts memory). The
+    // `DriverConnector`/`DriverCrtc`/... bounds are required at the use sites as `where`-clauses
+    // instead (an assumption, not an eagerly WF-checked trait-definition obligation).
+    //
+    // TODO: unneeded once we support multiple `Driver*` implementations per driver.
 
+    /// The driver's [`DriverConnector`](connector::DriverConnector) implementation.
+    type Connector;
     /// The driver's [`DriverPlane`](plane::DriverPlane) implementation.
-    ///
-    /// TODO: This will be unneeded once we support multiple `DriverPlane` implementations.
-    type Plane: plane::DriverPlane<Driver = Self>;
-
+    type Plane;
     /// The driver's [`DriverCrtc`](crtc::DriverCrtc) implementation.
-    ///
-    /// TODO: This will be unneeded once we support multiple `DriverCrtc` implementations.
-    type Crtc: crtc::DriverCrtc<Driver = Self>;
-
+    type Crtc;
     /// The driver's [`DriverEncoder`](encoder::DriverEncoder) implementation.
-    ///
-    /// TODO: This will be unneeded once we support multiple `DriverEncoder` implementations.
-    type Encoder: encoder::DriverEncoder<Driver = Self>;
+    type Encoder;
 
     /// Return a [`ModeConfigInfo`] structure for this [`device::Device`].
     fn mode_config_info(dev: &Device<Self, Uninit>) -> Result<ModeConfigInfo>
diff --git a/rust/kernel/drm/kms/connector.rs b/rust/kernel/drm/kms/connector.rs
index 05ec64cf6fa2..aca7be50e583 100644
--- a/rust/kernel/drm/kms/connector.rs
+++ b/rust/kernel/drm/kms/connector.rs
@@ -139,7 +139,7 @@ pub trait DriverConnector: Send + Sync + Sized {
     /// The [`DriverConnectorState`] implementation for this [`DriverConnector`].
     ///
     /// See [`DriverConnectorState`] for more info.
-    type State: DriverConnectorState;
+    type State: DriverConnectorState<Connector = Self>;
 
     /// The constructor for creating a [`Connector`] using this [`DriverConnector`] implementation.
     ///
@@ -700,13 +700,17 @@ pub struct ConnectorState<T: DriverConnectorState> {
 /// [`struct drm_connector`]: srctree/include/drm_connector.h
 /// [`struct drm_connector_state`]: srctree/include/drm_connector.h
 pub trait DriverConnectorState: Clone + Default + Sized {
-    /// The parent [`DriverConnector`].
-    type Connector: DriverConnector;
+    /// The parent [`DriverConnector`]. Unbounded to break the trait WF cycle; the
+    /// `DriverConnector` bound is required at use sites instead.
+    type Connector;
 }
 
 impl<T: DriverConnectorState> Sealed for ConnectorState<T> {}
 
-impl<T: DriverConnectorState> AsRawConnectorState for ConnectorState<T> {
+impl<T: DriverConnectorState> AsRawConnectorState for ConnectorState<T>
+where
+    T::Connector: DriverConnector,
+{
     type Connector = Connector<T::Connector>;
 }
 
@@ -720,7 +724,10 @@ unsafe fn as_raw_mut(&mut self) -> &mut bindings::drm_connector_state {
     }
 }
 
-impl<T: DriverConnectorState> FromRawConnectorState for ConnectorState<T> {
+impl<T: DriverConnectorState> FromRawConnectorState for ConnectorState<T>
+where
+    T::Connector: DriverConnector,
+{
     unsafe fn from_raw<'a>(ptr: *const bindings::drm_connector_state) -> &'a Self {
         // Our data layout starts with `bindings::drm_connector_state`.
         let ptr: *const Self = ptr.cast();
@@ -859,7 +866,10 @@ pub(super) fn new<D: KmsDriver>(
     }
 }
 
-impl<'a, T: DriverConnectorState> Deref for ConnectorStateMutator<'a, ConnectorState<T>> {
+impl<'a, T: DriverConnectorState> Deref for ConnectorStateMutator<'a, ConnectorState<T>>
+where
+    T::Connector: DriverConnector,
+{
     type Target = T;
 
     fn deref(&self) -> &Self::Target {
@@ -867,7 +877,10 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl<'a, T: DriverConnectorState> DerefMut for ConnectorStateMutator<'a, ConnectorState<T>> {
+impl<'a, T: DriverConnectorState> DerefMut for ConnectorStateMutator<'a, ConnectorState<T>>
+where
+    T::Connector: DriverConnector,
+{
     fn deref_mut(&mut self) -> &mut Self::Target {
         &mut self.state.inner
     }
diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
index 0f579dc4ec75..4c6cb6bbdcb8 100644
--- a/rust/kernel/drm/kms/crtc.rs
+++ b/rust/kernel/drm/kms/crtc.rs
@@ -124,7 +124,7 @@ pub trait DriverCrtc: Send + Sync + Sized {
     /// The [`DriverCrtcState`] implementation for this [`DriverCrtc`].
     ///
     /// See [`DriverCrtcState`] for more info.
-    type State: DriverCrtcState;
+    type State: DriverCrtcState<Crtc = Self>;
 
     /// The driver's optional hardware vblank implementation
     ///
@@ -561,10 +561,9 @@ impl<T: DriverCrtcState> Sealed for CrtcState<T> {}
 /// [`struct drm_crtc`]: srctree/include/drm_crtc.h
 /// [`struct drm_crtc_state`]: srctree/include/drm_crtc.h
 pub trait DriverCrtcState: Clone + Default + Unpin {
-    /// The parent CRTC driver for this CRTC state
-    type Crtc: DriverCrtc<State = Self>
-    where
-        Self: Sized;
+    /// The parent CRTC driver for this CRTC state. Unbounded to break the trait WF cycle;
+    /// the `DriverCrtc` bound is required at use sites instead.
+    type Crtc;
 }
 
 /// The main interface for a [`struct drm_crtc_state`].
@@ -702,11 +701,17 @@ fn as_raw(&self) -> *mut bindings::drm_crtc_state {
     }
 }
 
-impl<T: DriverCrtcState> AsRawCrtcState for CrtcState<T> {
+impl<T: DriverCrtcState> AsRawCrtcState for CrtcState<T>
+where
+    T::Crtc: DriverCrtc,
+{
     type Crtc = Crtc<T::Crtc>;
 }
 
-impl<T: DriverCrtcState> FromRawCrtcState for CrtcState<T> {
+impl<T: DriverCrtcState> FromRawCrtcState for CrtcState<T>
+where
+    T::Crtc: DriverCrtc,
+{
     unsafe fn from_raw<'a>(ptr: *const bindings::drm_crtc_state) -> &'a Self {
         // SAFETY: Our data layout starts with `bindings::drm_crtc_state`
         unsafe { &*(ptr.cast()) }
@@ -800,7 +805,7 @@ fn <D, C>(CrtcStateMutator<'a, OpaqueCrtcState<D>>) -> Self
         where
             T: DriverCrtcState<Crtc = C>;
         use
-            T as DriverCrtc,
+            C as DriverCrtc,
             D as KmsDriver<Crtc = ...>
     }
 }
@@ -813,7 +818,10 @@ fn drop(&mut self) {
     }
 }
 
-impl<'a, T: DriverCrtcState> Deref for CrtcStateMutator<'a, CrtcState<T>> {
+impl<'a, T: DriverCrtcState> Deref for CrtcStateMutator<'a, CrtcState<T>>
+where
+    T::Crtc: DriverCrtc,
+{
     type Target = T;
 
     fn deref(&self) -> &Self::Target {
@@ -823,7 +831,10 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl<'a, T: DriverCrtcState> DerefMut for CrtcStateMutator<'a, CrtcState<T>> {
+impl<'a, T: DriverCrtcState> DerefMut for CrtcStateMutator<'a, CrtcState<T>>
+where
+    T::Crtc: DriverCrtc,
+{
     fn deref_mut(&mut self) -> &mut Self::Target {
         // SAFETY: Our interface ensures that `self.state.inner` follows rust's data-aliasing rules,
         // so this is safe
diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index 6f547adcfdc9..47e05fe6bee1 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -98,7 +98,7 @@ pub trait DriverPlane: Send + Sync + Sized {
     /// The [`DriverPlaneState`] implementation for this [`DriverPlane`].
     ///
     /// See [`DriverPlaneState`] for more info.
-    type State: DriverPlaneState;
+    type State: DriverPlaneState<Plane = Self>;
 
     /// The constructor for creating a [`Plane`] using this [`DriverPlane`] implementation.
     ///
@@ -689,13 +689,17 @@ pub struct PlaneState<T: DriverPlaneState> {
 /// [`struct drm_plane`]: srctree/include/drm_plane.h
 /// [`struct drm_plane_state`]: srctree/include/drm_plane.h
 pub trait DriverPlaneState: Clone + Default + Sized {
-    /// The type for this driver's drm_plane implementation
-    type Plane: DriverPlane;
+    /// The type for this driver's drm_plane implementation. Unbounded to break the trait WF
+    /// cycle; the `DriverPlane` bound is required at use sites instead.
+    type Plane;
 }
 
 impl<T: DriverPlaneState> Sealed for PlaneState<T> {}
 
-impl<T: DriverPlaneState> AsRawPlaneState for PlaneState<T> {
+impl<T: DriverPlaneState> AsRawPlaneState for PlaneState<T>
+where
+    T::Plane: DriverPlane,
+{
     type Plane = Plane<T::Plane>;
 }
 
@@ -709,7 +713,10 @@ unsafe fn as_raw_mut(&mut self) -> &mut bindings::drm_plane_state {
     }
 }
 
-impl<T: DriverPlaneState> FromRawPlaneState for PlaneState<T> {
+impl<T: DriverPlaneState> FromRawPlaneState for PlaneState<T>
+where
+    T::Plane: DriverPlane,
+{
     unsafe fn from_raw<'a>(ptr: *const bindings::drm_plane_state) -> &'a Self {
         // Our data layout starts with `bindings::drm_plane_state`.
         let ptr: *const Self = ptr.cast();
@@ -885,7 +892,10 @@ unsafe fn as_raw_mut(&mut self) -> &mut bindings::drm_plane_state {
 
 impl<'a, T: FromRawPlaneState> Sealed for PlaneStateMutator<'a, T> {}
 
-impl<'a, T: DriverPlaneState> Deref for PlaneStateMutator<'a, PlaneState<T>> {
+impl<'a, T: DriverPlaneState> Deref for PlaneStateMutator<'a, PlaneState<T>>
+where
+    T::Plane: DriverPlane,
+{
     type Target = T;
 
     fn deref(&self) -> &Self::Target {
@@ -893,7 +903,10 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl<'a, T: DriverPlaneState> DerefMut for PlaneStateMutator<'a, PlaneState<T>> {
+impl<'a, T: DriverPlaneState> DerefMut for PlaneStateMutator<'a, PlaneState<T>>
+where
+    T::Plane: DriverPlane,
+{
     fn deref_mut(&mut self) -> &mut Self::Target {
         &mut self.state.inner
     }
diff --git a/rust/kernel/drm/kms/vblank.rs b/rust/kernel/drm/kms/vblank.rs
index dc34e02e8ccb..534fd18f63b4 100644
--- a/rust/kernel/drm/kms/vblank.rs
+++ b/rust/kernel/drm/kms/vblank.rs
@@ -62,8 +62,9 @@ fn get_vblank_timestamp(
 /// Drivers interested in implementing vblank support should refer to [`VblankSupport`], drivers
 /// that don't have vblank support can use [`PhantomData`].
 pub trait VblankImpl {
-    /// The parent [`DriverCrtc`].
-    type Crtc: DriverCrtc<VblankImpl = Self>;
+    /// The parent [`DriverCrtc`]. Unbounded to break the trait WF cycle; the `DriverCrtc`
+    /// bound is required at use sites instead.
+    type Crtc;
 
     /// The generated [`VblankOps`].
     const VBLANK_OPS: VblankOps;
-- 
2.55.0

