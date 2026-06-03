Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1CBCD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E65BA10F72F;
	Wed,  3 Jun 2026 01:10:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WZEuJ5C3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A154F10F72F
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 01:10:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 885B243DD3;
 Wed,  3 Jun 2026 01:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D92F1F00898;
 Wed,  3 Jun 2026 01:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780449053;
 bh=5u6SKAfOQENdvm9cJV5fTBpN3ZssvduKcZ4mI7udZDE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WZEuJ5C3uR808zrPCLf2pFl3JhLLGmxCrxORyVMHaFAvtUeZPYyUVIThwwUMPHnOq
 XWMFFqe1mRfZ0t93nTXFrYMJX4OF12xSjJ9IW/+CfxIImiYeQMn6qF/ynOR63Tc1DE
 /nDYS0MD9/LxDOcfQDy1W7rQ8JNIRuN2bB2eehi5MRDYAF3lSrKA1NepQIy9YLdeVo
 iraHgEvbp3aoHt9YqOXZCa4ulwpbySKlJplI1ISLbiXOMMwbwW73biwMhu/TXYRHdK
 49f4BK0x5DW08xyHNddohUHRwChImQkv7ssy9sDYaDWnpXmPOo///BUXmImLoxPz+E
 xNeZ2g6hFE7fg==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, acourbot@nvidia.com,
 ecourtney@nvidia.com, m.wilczynski@samsung.com, david.m.ertman@intel.com,
 ira.weiny@intel.com, leon@kernel.org, daniel.almeida@collabora.com,
 bhelgaas@google.com, kwilczynski@kernel.org
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: [PATCH v2 5/7] rust: devres: add DevresLt for ForLt-aware device
 resource access
Date: Wed,  3 Jun 2026 03:10:16 +0200
Message-ID: <20260603011020.2073650-6-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603011020.2073650-1-dakr@kernel.org>
References: <20260603011020.2073650-1-dakr@kernel.org>
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

Devres<T> stores resources as T and returns &'a T from access(). For
lifetime-parameterized types like Bar<'a, SIZE> that are transmuted to
'static for storage, this exposes the synthetic 'static lifetime to
callers -- any method on the stored type that returns a reference with
its lifetime parameter would yield a &'static reference, which is
unsound.

Add DevresLt<F: ForLt>, a thin wrapper around Devres<F::Of<'static>>
that applies ForLt's lifetime-shortening operations in all access
methods to shorten the stored 'static lifetime to the caller's borrow
lifetime.

DevresLt::new() is unsafe because the caller must guarantee that the
data remains valid for the device's full bound scope; the internal
transmute from F::Of<'a> to F::Of<'static> would otherwise allow
use-after-free.

Two access patterns are provided:

- CovariantForLt types get direct-reference accessors (access,
  try_access) that return shortened references via
  CovariantForLt::cast_ref.

- Plain ForLt types use closure-based accessors (access_with,
  try_access_with) whose universally quantified lifetime prevents
  callers from smuggling in concrete short-lived references.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs | 110 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 82cbd8b969fb..23db91377f5e 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -24,6 +24,8 @@
         Arc, //
     },
     types::{
+        CovariantForLt,
+        ForLt,
         ForeignOwnable,
         Opaque, //
     },
@@ -365,6 +367,114 @@ fn drop(&mut self) {
     }
 }
 
+/// Guard returned by [`DevresLt::try_access`].
+///
+/// Dereferences to `F::Of<'a>`, shortening the lifetime of the stored data to the guard's borrow
+/// lifetime.
+pub struct DevresGuard<'a, F: CovariantForLt>(RevocableGuard<'a, F::Of<'static>>);
+
+impl<'a, F: CovariantForLt> core::ops::Deref for DevresGuard<'a, F> {
+    type Target = F::Of<'a>;
+
+    fn deref(&self) -> &Self::Target {
+        F::cast_ref(&*self.0)
+    }
+}
+
+/// Device-managed resource with [`ForLt`](trait@ForLt)-aware access.
+///
+/// `DevresLt` wraps [`Devres`] and shortens the stored `'static` lifetime to the caller's borrow
+/// lifetime in all access methods.
+///
+/// Types that implement [`trait@CovariantForLt`] get direct-reference accessors ([`Self::access`],
+/// [`Self::try_access`]). Plain [`ForLt`](trait@ForLt) types use closure-based accessors
+/// ([`Self::access_with`], [`Self::try_access_with`]).
+pub struct DevresLt<F: ForLt>(Devres<F::Of<'static>>)
+where
+    F::Of<'static>: Send;
+
+impl<F: ForLt> DevresLt<F>
+where
+    F::Of<'static>: Send,
+{
+    /// Creates a new [`DevresLt`] instance of the given `data`.
+    ///
+    /// # Safety
+    ///
+    /// The data must remain valid for the device's full bound scope. [`DevresLt`] allows
+    /// access until the device is unbound, which may outlast `'a`.
+    pub unsafe fn new<'a, E>(
+        dev: &'a Device<Bound>,
+        data: impl PinInit<F::Of<'a>, E>,
+    ) -> Result<Self>
+    where
+        Error: From<E>,
+    {
+        // SAFETY: The caller guarantees the data is valid for the device's full bound scope.
+        // Lifetimes do not affect layout, so F::Of<'a> and F::Of<'static> have identical
+        // representation; casting the slot pointer is sound.
+        let data = unsafe {
+            pin_init::pin_init_from_closure::<F::Of<'static>, E>(move |slot| {
+                data.__pinned_init(slot.cast())
+            })
+        };
+
+        Ok(Self(Devres::new(dev, data)?))
+    }
+
+    /// Return a reference of the [`Device`] this [`DevresLt`] instance has been created with.
+    pub fn device(&self) -> &Device {
+        self.0.device()
+    }
+
+    /// Obtain `&F::Of<'_>`, bypassing the [`Revocable`], through a closure.
+    ///
+    /// This method works like [`DevresLt::access`](DevresLt::access) but accepts any
+    /// [`trait@ForLt`] type, not just [`trait@CovariantForLt`].
+    pub fn access_with<R, G>(&self, dev: &Device<Bound>, f: G) -> Result<R>
+    where
+        G: for<'a> FnOnce(&'a F::Of<'a>) -> R,
+    {
+        self.0.access(dev).map(|data| {
+            // SAFETY: The closure's HRTB `for<'a>` prevents the caller from smuggling in
+            // references with a concrete short lifetime, making the round-trip from `'static`
+            // sound regardless of variance.
+            f(unsafe { F::cast_ref_unchecked(data) })
+        })
+    }
+
+    /// [`DevresLt`] accessor for [`Revocable::try_access_with`].
+    pub fn try_access_with<R, G>(&self, f: G) -> Option<R>
+    where
+        G: for<'a> FnOnce(&'a F::Of<'a>) -> R,
+    {
+        self.0.data().try_access_with(|data| {
+            // SAFETY: The closure's HRTB `for<'a>` prevents the caller from smuggling in
+            // references with a concrete short lifetime, making the round-trip from `'static`
+            // sound regardless of variance.
+            f(unsafe { F::cast_ref_unchecked(data) })
+        })
+    }
+}
+
+impl<F: CovariantForLt> DevresLt<F>
+where
+    F::Of<'static>: Send,
+{
+    /// Obtain `&'a F::Of<'a>`, bypassing the [`Revocable`].
+    ///
+    /// This method works like [`Devres::access`], but shortens the returned reference's lifetime
+    /// from `'static` to `'a` via [`CovariantForLt::cast_ref`].
+    pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a F::Of<'a>> {
+        self.0.access(dev).map(F::cast_ref)
+    }
+
+    /// [`DevresLt`] accessor for [`Revocable::try_access`].
+    pub fn try_access(&self) -> Option<DevresGuard<'_, F>> {
+        self.0.data().try_access().map(DevresGuard)
+    }
+}
+
 /// Consume `data` and [`Drop::drop`] `data` once `dev` is unbound.
 fn register_foreign<P>(dev: &Device<Bound>, data: P) -> Result
 where
-- 
2.54.0

