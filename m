Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5556C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2867110E669;
	Mon, 13 Jul 2026 20:15:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CFEfdf6H";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4264310E669
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 20:15:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E181940122;
 Mon, 13 Jul 2026 20:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E441F00A3A;
 Mon, 13 Jul 2026 20:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783973712;
 bh=SJ/u76rqu3IYu0oQBdoKgOaRVyV4JG61V9cEDEByDGo=;
 h=From:To:Cc:Subject:Date:Reply-To;
 b=CFEfdf6H9PYjjN3lq/blkl7rCJHoVvDBFmjiioyAvodlAIj3EAaC/g9qtNvIsQvWz
 dEU89f/Tdlv9noaleyTunEtynZOQobFnmkpg6n5B4jvNohJON6bGKgvCwduztuNj1Q
 tKBchBREBwXN2N1Pw/zFVN48sBNTbYuVPIV1QOPLImTAPWZ9o1TJpn4ertMrgLcmW3
 ytOMs+CL7zadeLHtggYuKZXZjOmldP1K32XTAwg+axzroO65jBeuhqc99Ab0P4xJ6A
 JvsHnB00uP4afaRg0tB8z+dDpo58juHmHc1JLMoXIVeCafRGrZacldz6LodSwMyUzf
 CAaycXdmhKkyA==
From: Gary Guo <gary@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Eliot Courtney <ecourtney@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org
Subject: [PATCH] rust: device: make lifetime on `Core` and `CoreInternal`
 invariant
Date: Mon, 13 Jul 2026 21:14:54 +0100
Message-ID: <20260713201455.640151-1-gary@kernel.org>
X-Mailer: git-send-email 2.54.0
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
Reply-To: Gary Guo <gary@garyguo.net>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Gary Guo <gary@garyguo.net>

Currently the lifetime on `Core` and `CoreInternal` is covariant. This
means that they can be coerced into shorter living lifetimes. On `probe`
function, signature has `&'bound Device<Core<'a>>`; the type's wellformness
would imply `'a: 'bound` and thus the type can be coerced `&'bound
Device<Core<'bound>>`, defeating the purpose of having the lifetime bound
to prevent users of the `Core` type to escape the function.

Fix this by making the lifetime invariant, so the coercion is impossible.
The lifetime here only needs to be "branded" so it does not coerce or unify
with other lifetimes, so we do not need to ensure `'bound: 'a`.

This requires modifying `nova-core` which relies on this implied bound due
to pre-2024 capture rule. The "use" bound can be removed if built with
edition 2024.

Fixes: 24799831d631 ("rust: device: make Core and CoreInternal lifetime-parameterized")
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/gpu.rs |  6 +++---
 rust/kernel/device.rs        | 10 ++++++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index b3c91731db45..b603b0bd2692 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -285,10 +285,10 @@ pub(crate) struct Gpu<'gpu> {
 }
 
 impl<'gpu> Gpu<'gpu> {
-    pub(crate) fn new(
-        pdev: &'gpu pci::Device<device::Core<'_>>,
+    pub(crate) fn new<'a>(
+        pdev: &'gpu pci::Device<device::Core<'a>>,
         bar: Bar0<'gpu>,
-    ) -> impl PinInit<Self, Error> + 'gpu {
+    ) -> impl PinInit<Self, Error> + use<'gpu, 'a> {
         try_pin_init!(Self {
             device: pdev.as_ref(),
             spec: Spec::new(pdev.as_ref(), bar).inspect(|spec| {
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 645afc49a27d..db25ed1ae8e5 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -511,7 +511,11 @@ pub trait DeviceContext: private::Sealed {}
 /// callback it appears in. It is intended to be used for synchronization purposes. Bus device
 /// implementations can implement methods for [`Device<Core>`], such that they can only be called
 /// from bus callbacks.
-pub struct Core<'a>(PhantomData<&'a ()>);
+///
+/// The lifetime `'a` is for "lifetime branding" purpose. Callbacks need to polymorphic over this
+/// lifetime so the `&'bound Device<Core<'_>>` provided to them cannot outlive the scope of the
+/// function. For this reason, it needs to be invariant.
+pub struct Core<'a>(PhantomData<fn(&'a ()) -> &'a ()>);
 
 /// Semantically the same as [`Core`], but reserved for internal usage of the corresponding bus
 /// abstraction.
@@ -522,7 +526,9 @@ pub trait DeviceContext: private::Sealed {}
 ///
 /// This context mainly exists to share generic [`Device`] infrastructure that should only be called
 /// from bus callbacks with bus abstractions, but without making them accessible for drivers.
-pub struct CoreInternal<'a>(PhantomData<&'a ()>);
+///
+/// Lifetime `'a` is invariant for the same reason as [`Core`].
+pub struct CoreInternal<'a>(PhantomData<fn(&'a ()) -> &'a ()>);
 
 /// The [`Bound`] context is the [`DeviceContext`] of a bus specific device when it is guaranteed to
 /// be bound to a driver.

base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.54.0

