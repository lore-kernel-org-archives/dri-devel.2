Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E319BC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2002510E2F2;
	Wed, 26 Aug 2026 16:34:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="oC/GXKz2";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A00D10E2F2
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:34:41 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so9723785e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762079; x=1788366879;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZC7WCQ5+0/9fPzRSyKMQ9auLD0V4hXZXAOJafRw4jYQ=;
 b=oC/GXKz21iipJjaygqjmUqcwKQKt7whcAY1IZqobqMJOwigXnnaufVQ/kHj8TmqrIG
 xQBxrhdMU1opgvJ3FwpVc8XNC8s2WjVaAEc3bOgsKkheuh1TY0mm5vIXbGNgrOKNzswf
 i8nlRL4fT/b21uqLuO77shDpM1vCcwtuF86KoyS+8Cl9f8ZZV5cC6Sw0Ogbd1lIFyC9X
 LNO+n0o+lNxVT3/f78yvO2zgkJueBBwy6oENqARpNrj4K8z/43GaX1Icc6iMEWtWGu+t
 AncspJJfCu7+0CGD0b+H884tUz6L5B96HNXMGM0oHzJs5QFDDYKmCC/LMIk1nDc/kk3x
 PsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762079; x=1788366879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZC7WCQ5+0/9fPzRSyKMQ9auLD0V4hXZXAOJafRw4jYQ=;
 b=POFFZ2exA2oQjFpgjq+h6fMjR12b4NvRVcddRgx3BKNerRDD/zgk3VJP9UOCY3v17n
 mhqsXHO9y6+IWFcEj/DWXZjGXt/61371a9AR6L/Qn9+LHu7hcaorkYhtJdLJ1O0Wdxvl
 0fnTBrpqvO+VKwKjAW1x3qE+srTVCfPgaprQbuT2OztaltfzDFooaaYRnZyut7BtFwS9
 IfI5tRzG6vz0hKLPqzDySzBgjsOgrFZAnzIv6vcscTqmEn89m/mw4sQS2Ocq092HqH8C
 cyteDHcGz/2+bmU7M88G1lR5LzFhXG/F4pOdWrPCQR409/d8IvxP6POt3m2cu9Zlc6nh
 AM4A==
X-Gm-Message-State: AFuF++luzk59LHMxw6ZqWcYfOBxJNewZ+4qh88JRPKWrRjNUb31hAqpn
 rxVnNWXP9OF54US0popnjVBTukj7KoEu4tJs5gZFIVW2sUAoBLCNf0K9KRJc+SUwCctdhlHhRDe
 ZLNer2wMQ
X-Gm-Gg: AR+sD13j8+y+76M0uuIfCmwzIy+R1hyNyL4hidWs6SCSGXDcHJGXGwQrSTbHhvGVWPR
 rR2csxLOG+FoNV/b1ceTwdngmDa8kSOGUqjHPdonbyTOLy9nJ9RzdAEl2Nx2xojBe10XgWQ42yd
 wDFfmi7y4kVthQaseQRDCwl48PnH8tlsa8pI2S/Jo34nGSGZl5GRaSKt+5+ThL2uV3KJKtFGv4K
 MwZdM9+1q0t7bX3OrixgdyZueLsuWpbPmuhhJPqowovYsA/YordukOfyAw+6ITeOEp1hoKj+Ipu
 z0gsYflIassKJfAUkZOMJvja6WwqIuzwZcT0yvfvyTrTgAfEsNl1k/eWeQuTTXcdbUT4uRUkdOE
 YFV9zq4UkfK3SDgeijOUdFyPWjWxEONzME3KuN0ImE6SI+9pRUrnbLER5s5G/w1wkdoE8sp88cu
 JIQcKErxrGz7rZzwzXvp67REeWzRgKkyARoL+rIicTlFcwD9h+5x3VpuTf4LT78Hm+VIo27hUh4
 QN5L2YVRmJKKJ163QVSeE+QCv8h2GRCgBT5
X-Received: by 2002:a05:600c:19c6:b0:499:900c:9c69 with SMTP id
 5b1f17b1804b1-499dc7252fcmr78303615e9.9.1787762079446; 
 Wed, 26 Aug 2026 09:34:39 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:34:38 -0700 (PDT)
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
Subject: [PATCH v3 2/23] rust: drm: kms: tie mode-object references to their
 owners
Date: Wed, 26 Aug 2026 17:31:33 +0100
Message-ID: <20260826163359.4998-3-mike@fireburn.co.uk>
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

The plane and encoder constructors accepted a caller-selected output
lifetime longer than the unregistered KMS device borrow.
RawPlaneState::crtc() had the same issue relative to the state borrow.
This allowed safe callers to manufacture dangling references.

Return references with the input/owner lifetime instead. Remove the
unused second lifetime from the CRTC constructor at the same time.

Fixes: 4b14e6e6259b ("rust: drm/kms: Add drm_plane bindings")
Fixes: c07f528ca38e ("rust: drm/kms: Add drm_encoder bindings")
Fixes: 8ba1abe0de4b ("rust: drm/kms: Add RawPlaneState::crtc()")

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/kernel/drm/kms/crtc.rs    |  2 +-
 rust/kernel/drm/kms/encoder.rs | 24 +++++++++++++++++--
 rust/kernel/drm/kms/plane.rs   | 42 +++++++++++++++++++++++++++++++---
 3 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/drm/kms/crtc.rs b/rust/kernel/drm/kms/crtc.rs
index b1c68838205e..683d9ee4ec25 100644
--- a/rust/kernel/drm/kms/crtc.rs
+++ b/rust/kernel/drm/kms/crtc.rs
@@ -302,7 +302,7 @@ impl<T: DriverCrtc> UnregisteredCrtc<T> {
     /// construct new [`UnregisteredCrtc`] objects.
     ///
     /// [`KmsDriver::create_objects`]: kernel::drm::kms::KmsDriver::create_objects
-    pub fn new<'a, 'b: 'a, PrimaryData, CursorData>(
+    pub fn new<'a, PrimaryData, CursorData>(
         dev: &'a UnregisteredKmsDevice<'a, T::Driver>,
         primary: &'a UnregisteredPlane<PrimaryData>,
         cursor: Option<&'a UnregisteredPlane<CursorData>>,
diff --git a/rust/kernel/drm/kms/encoder.rs b/rust/kernel/drm/kms/encoder.rs
index aa6f9fbaa5f1..f90d139cdb04 100644
--- a/rust/kernel/drm/kms/encoder.rs
+++ b/rust/kernel/drm/kms/encoder.rs
@@ -273,15 +273,35 @@ impl<T: DriverEncoder> UnregisteredEncoder<T> {
     /// A driver may use this from their [`KmsDriver::create_objects`] callback in order to
     /// construct new [`UnregisteredEncoder`] objects.
     ///
+    /// The returned encoder cannot outlive the device borrow:
+    ///
+    /// ```ignore,compile_fail
+    /// use kernel::{drm::kms::{encoder::{DriverEncoder, Type, UnregisteredEncoder},
+    ///                         UnregisteredKmsDevice},
+    ///              error::Result,
+    ///              str::CStr};
+    ///
+    /// fn reject_leaking_signature<T: DriverEncoder>() {
+    ///     let _: for<'a> fn(
+    ///         &'a UnregisteredKmsDevice<'a, T::Driver>,
+    ///         Type,
+    ///         u32,
+    ///         u32,
+    ///         Option<&CStr>,
+    ///         T::Args,
+    ///     ) -> Result<&'static UnregisteredEncoder<T>> = UnregisteredEncoder::<T>::new;
+    /// }
+    /// ```
+    ///
     /// [`KmsDriver::create_objects`]: kernel::drm::kms::KmsDriver::create_objects
-    pub fn new<'a, 'b: 'a>(
+    pub fn new<'a>(
         dev: &'a UnregisteredKmsDevice<'a, T::Driver>,
         type_: Type,
         possible_crtcs: u32,
         possible_clones: u32,
         name: Option<&CStr>,
         args: T::Args,
-    ) -> Result<&'b Self> {
+    ) -> Result<&'a Self> {
         let this: Pin<KBox<Encoder<T>>> = KBox::try_pin_init(
             try_pin_init!(Encoder {
                 encoder: Opaque::new(bindings::drm_encoder {
diff --git a/rust/kernel/drm/kms/plane.rs b/rust/kernel/drm/kms/plane.rs
index 0c549dece483..f52f9c872de3 100644
--- a/rust/kernel/drm/kms/plane.rs
+++ b/rust/kernel/drm/kms/plane.rs
@@ -255,8 +255,29 @@ impl<T: DriverPlane> UnregisteredPlane<T> {
     /// A driver may use this from their [`KmsDriver::create_objects`] callback in order to
     /// construct new [`UnregisteredPlane`] objects.
     ///
+    /// The returned plane cannot outlive the device borrow:
+    ///
+    /// ```ignore,compile_fail
+    /// use kernel::{drm::kms::{plane::{DriverPlane, Type, UnregisteredPlane},
+    ///                         UnregisteredKmsDevice},
+    ///              error::Result,
+    ///              str::CStr};
+    ///
+    /// fn reject_leaking_signature<T: DriverPlane>() {
+    ///     let _: for<'a> fn(
+    ///         &'a UnregisteredKmsDevice<'a, T::Driver>,
+    ///         u32,
+    ///         &[u32],
+    ///         Option<&[u64]>,
+    ///         Type,
+    ///         Option<&CStr>,
+    ///         T::Args,
+    ///     ) -> Result<&'static UnregisteredPlane<T>> = UnregisteredPlane::<T>::new;
+    /// }
+    /// ```
+    ///
     /// [`KmsDriver::create_objects`]: kernel::drm::kms::KmsDriver::create_objects
-    pub fn new<'a, 'b: 'a>(
+    pub fn new<'a>(
         dev: &'a UnregisteredKmsDevice<'a, T::Driver>,
         possible_crtcs: u32,
         formats: &[u32],
@@ -264,7 +285,7 @@ pub fn new<'a, 'b: 'a>(
         type_: Type,
         name: Option<&CStr>,
         args: T::Args,
-    ) -> Result<&'b Self> {
+    ) -> Result<&'a Self> {
         let this: Pin<KBox<Plane<T>>> = KBox::try_pin_init(
             try_pin_init!(Plane {
                 plane: Opaque::new(bindings::drm_plane {
@@ -597,7 +618,22 @@ fn plane(&self) -> &Self::Plane {
     }
 
     /// Return the current [`OpaqueCrtc`] assigned to this plane, if there is one.
-    fn crtc<'a, 'b: 'a, D>(&'a self) -> Option<&'b OpaqueCrtc<D>>
+    ///
+    /// The returned CRTC reference cannot outlive the plane-state borrow:
+    ///
+    /// ```ignore,compile_fail
+    /// use kernel::drm::kms::{crtc::OpaqueCrtc, plane::RawPlaneState, KmsDriver, ModeObject};
+    ///
+    /// fn reject_leaking_signature<S, D>()
+    /// where
+    ///     S: RawPlaneState,
+    ///     S::Plane: ModeObject<Driver = D>,
+    ///     D: KmsDriver,
+    /// {
+    ///     let _: for<'a> fn(&'a S) -> Option<&'static OpaqueCrtc<D>> = S::crtc::<D>;
+    /// }
+    /// ```
+    fn crtc<D>(&self) -> Option<&OpaqueCrtc<D>>
     where
         Self::Plane: ModeObject<Driver = D>,
         D: KmsDriver,
