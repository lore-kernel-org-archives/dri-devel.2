Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A941CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 20:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9D3E10E264;
	Mon, 25 May 2026 20:29:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KpduoAIr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E62D10E264
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 20:29:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 33F8041B20;
 Mon, 25 May 2026 20:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C501F000E9;
 Mon, 25 May 2026 20:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779740985;
 bh=CvsWKx5YQe9ahMUZVvp0ojIrus3es8Io68N4EoQNks0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KpduoAIr0LeDIRVPVRU0Ks2uAUTfj4bIY+YARKxe/qUadknx+sc+/0ys/MCuAtH8o
 9x/F+Y4eIJ/pvHBzJXMO/VVPJJYiIR98t6JGsQdGfkyaPLSBMn50p8p94E4PqKu30d
 N5/tDY5d+OTB7CgA+rde2mus8bXXYpCImZqkEI09XT5Tophca2IJUAoMsx1J1wxILm
 ovpLRaYvuq1C9zDYFN53npOxUuu28YK2DD5sB1sU3eXWP02BmHnUEp5osWhtajC2IQ
 J7tGd39Qbd1XlaxcPt7EvDPsvCQuFs5knqcLU+qv3q1LrLMCa7VMkcX8eCKNz3YOoX
 kNEtI26E5U9XA==
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
Subject: [PATCH v5 02/24] rust: alloc: remove `'static` bound on
 `ForeignOwnable`
Date: Mon, 25 May 2026 22:20:49 +0200
Message-ID: <20260525202921.124698-3-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525202921.124698-1-dakr@kernel.org>
References: <20260525202921.124698-1-dakr@kernel.org>
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

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

