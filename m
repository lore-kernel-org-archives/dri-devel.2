Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E78CD4851
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 00:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27F3E10E214;
	Sun, 17 May 2026 00:02:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lo61tpVf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C11AF10E214
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 00:02:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B3002600BB;
 Sun, 17 May 2026 00:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1103CC2BCB7;
 Sun, 17 May 2026 00:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778976131;
 bh=WWXEhYL1pyozAOOzGV1K7eIyCXDvUYRdwd9dq3jRv+s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lo61tpVfwVbXES6wNBezAs6W56coiOOFxvbuCpfd0rS7c8DHpPXa7rWQ9b2h39yJf
 52E9ibLWcOBxncfcjts9vEGDD6+hxRXH+7+igjy6LFa3pfV42nIFPgwS3mfIF4peta
 RAWLr4ovOm14MIVN7ojinfiynXsG7ry7l9CTYZBEOefmOKlhHr29kb0ZDd/z4f30mE
 gTraAhbmmyyMBFdxdMXEkFYYwTmVBgILaEQ0/46HGX1Yk2kWNq0CptZMOkMF/F8gQU
 w1srGi76W+RZvf5Sh0aNmYCQ/60ptN2b9+Ul1t6eh4HpBMhitFRsekdS0wyRHjsajM
 pFrJyniiD1xgw==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com,
 pcolberg@redhat.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 01/27] rust: alloc: remove `'static` bound on
 `ForeignOwnable`
Date: Sun, 17 May 2026 02:00:49 +0200
Message-ID: <20260517000149.3226762-2-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517000149.3226762-1-dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
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

From: Gary Guo <gary@garyguo.net>

The `'static` bound is currently necessary because there's no
restriction on the lifetime of the GAT. Add a `Self: 'a` bound to
restrict possible lifetimes on `Borrowed` and `BorrowedMut`, and lift
the `'static` requirement.

Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc/kbox.rs | 24 ++++++++++++++++++------
 rust/kernel/types.rs      |  8 ++++++--
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index c824ed6e1523..2f8c16473c2c 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -477,7 +477,7 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
 
 // SAFETY: The pointer returned by `into_foreign` comes from a well aligned
 // pointer to `T` allocated by `A`.
-unsafe impl<T: 'static, A> ForeignOwnable for Box<T, A>
+unsafe impl<T, A> ForeignOwnable for Box<T, A>
 where
     A: Allocator,
 {
@@ -487,8 +487,14 @@ unsafe impl<T: 'static, A> ForeignOwnable for Box<T, A>
         core::mem::align_of::<T>()
     };
 
-    type Borrowed<'a> = &'a T;
-    type BorrowedMut<'a> = &'a mut T;
+    type Borrowed<'a>
+        = &'a T
+    where
+        Self: 'a;
+    type BorrowedMut<'a>
+        = &'a mut T
+    where
+        Self: 'a;
 
     fn into_foreign(self) -> *mut c_void {
         Box::into_raw(self).cast()
@@ -516,13 +522,19 @@ unsafe fn borrow_mut<'a>(ptr: *mut c_void) -> &'a mut T {
 
 // SAFETY: The pointer returned by `into_foreign` comes from a well aligned
 // pointer to `T` allocated by `A`.
-unsafe impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
+unsafe impl<T, A> ForeignOwnable for Pin<Box<T, A>>
 where
     A: Allocator,
 {
     const FOREIGN_ALIGN: usize = <Box<T, A> as ForeignOwnable>::FOREIGN_ALIGN;
-    type Borrowed<'a> = Pin<&'a T>;
-    type BorrowedMut<'a> = Pin<&'a mut T>;
+    type Borrowed<'a>
+        = Pin<&'a T>
+    where
+        Self: 'a;
+    type BorrowedMut<'a>
+        = Pin<&'a mut T>
+    where
+        Self: 'a;
 
     fn into_foreign(self) -> *mut c_void {
         // SAFETY: We are still treating the box as pinned.
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 4329d3c2c2e5..9cf9f869d195 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -27,10 +27,14 @@ pub unsafe trait ForeignOwnable: Sized {
     const FOREIGN_ALIGN: usize;
 
     /// Type used to immutably borrow a value that is currently foreign-owned.
-    type Borrowed<'a>;
+    type Borrowed<'a>
+    where
+        Self: 'a;
 
     /// Type used to mutably borrow a value that is currently foreign-owned.
-    type BorrowedMut<'a>;
+    type BorrowedMut<'a>
+    where
+        Self: 'a;
 
     /// Converts a Rust-owned object to a foreign-owned one.
     ///
-- 
2.54.0

