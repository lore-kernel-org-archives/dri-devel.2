Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A54FF8867
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 22:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E725010E970;
	Mon, 27 Apr 2026 22:12:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dJLRKLjR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC84A10E970
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 22:12:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4115F6012B;
 Mon, 27 Apr 2026 22:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B69C19425;
 Mon, 27 Apr 2026 22:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777327947;
 bh=bM12jT1hv0K0oENDCBepC4nrrQUDFCBN7Pb+KzPNmtA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dJLRKLjRm9qlfsoANY2fNN4UtrsSDSd7D+xH5aB4COfjRw7n/QHDm96SJn7XnB4PX
 J9hzk1e+EKPC4SU2TmXraGD3g7QAFijLpGK7VwvpCZY4ESZ/f0uFK0aJDyqpijdU40
 SX7nSiNxoSYnjx5aLu0tPAJ7i2IVobXsM5ozDYjWyezcCSt8Yx+nuchuAw/SN/bOCi
 Y8/H55/J5Ws2Do3nbhGYPCG+GMSMnQ2UYLlpLrDyMgZj4hfcdtx6j4m41uyUnJqB27
 SueqprNZm0gboHo8WVABYI87am+945g0j3AP+XWmIuTrWVTVs7osXRTUz+fN57rzFs
 qaCQ2uP3eegzw==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 03/24] rust: devres: add ForLt support to Devres
Date: Tue, 28 Apr 2026 00:11:01 +0200
Message-ID: <20260427221155.2144848-4-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427221155.2144848-1-dakr@kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
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

Use ForLt::cast_ref() in Devres access methods, enabling lifetime
shortening for types that are covariant over their lifetime parameter.

This is a no-op for 'static types, but prepares Devres for use with
lifetime-parameterized types such as pci::Bar<'_, SIZE>.

Add DevresGuard as a wrapper around RevocableGuard that applies
ForLt::cast_ref() on deref().

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/devres.rs | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index 9e5f93aed20c..7baabcdb1ad3 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -24,6 +24,7 @@
         Arc, //
     },
     types::{
+        ForLt,
         ForeignOwnable,
         Opaque, //
     },
@@ -324,22 +325,26 @@ pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a T> {
         // SAFETY: `dev` being the same device as the device this `Devres` has been created for
         // proves that `self.data` hasn't been revoked and is guaranteed to not be revoked as long
         // as `dev` lives; `dev` lives at least as long as `self`.
-        Ok(unsafe { self.data().access() })
+        Ok(<ForLt!(T)>::cast_ref(unsafe { self.data().access() }))
     }
 
     /// [`Devres`] accessor for [`Revocable::try_access`].
-    pub fn try_access(&self) -> Option<RevocableGuard<'_, T>> {
-        self.data().try_access()
+    #[allow(clippy::type_complexity)]
+    pub fn try_access(&self) -> Option<DevresGuard<'_, ForLt!(T)>> {
+        self.data().try_access().map(DevresGuard)
     }
 
     /// [`Devres`] accessor for [`Revocable::try_access_with`].
     pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self, f: F) -> Option<R> {
-        self.data().try_access_with(f)
+        self.data()
+            .try_access_with(|data| f(<ForLt!(T)>::cast_ref(data)))
     }
 
     /// [`Devres`] accessor for [`Revocable::try_access_with_guard`].
     pub fn try_access_with_guard<'a>(&'a self, guard: &'a rcu::Guard) -> Option<&'a T> {
-        self.data().try_access_with_guard(guard)
+        self.data()
+            .try_access_with_guard(guard)
+            .map(<ForLt!(T)>::cast_ref)
     }
 }
 
@@ -365,6 +370,20 @@ fn drop(&mut self) {
     }
 }
 
+/// Guard returned by [`Devres::try_access`].
+///
+/// Dereferences to `F::Of<'a>`, applying [`ForLt::cast_ref`] to shorten the lifetime of the
+/// stored data to the guard's borrow lifetime.
+pub struct DevresGuard<'a, F: ForLt>(RevocableGuard<'a, F::Of<'static>>);
+
+impl<'a, F: ForLt> core::ops::Deref for DevresGuard<'a, F> {
+    type Target = F::Of<'a>;
+
+    fn deref(&self) -> &Self::Target {
+        F::cast_ref(&*self.0)
+    }
+}
+
 /// Consume `data` and [`Drop::drop`] `data` once `dev` is unbound.
 fn register_foreign<P>(dev: &Device<Bound>, data: P) -> Result
 where
-- 
2.54.0

