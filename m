Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F72CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 15:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0996310EB24;
	Tue,  5 May 2026 15:24:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SXJ30qcv";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BF8F10EB24
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 15:24:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4300543BDC;
 Tue,  5 May 2026 15:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3752DC2BCF5;
 Tue,  5 May 2026 15:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777994651;
 bh=/fRYQ5zjyOWJ/pjwZIQGbTj2eLYzfvrx5wG1aPkJ0yk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SXJ30qcvZyrwl+5xqeEEOkQOYPEOuJoahNOTRVpjZWEZtRGtD+oA+gZn8TpWHKWBm
 GYYhJ13x8GubFYRcnUxl501mOCZHvRaMTcJV3u8hp0M4dIEHS/I8g60qqKfZwFQSzl
 9A4jDC4V+x/sNS4OaC0oukadQ4UaMe9OcIvKgc3IGE7AGdt992KemwXAzEHHe2Xglc
 ad4wFuVYf/0nD1S/hmJgyQlcmf3IleEqNeFYMJIl012IlPjFoAdpH0uU76mpTtnFWS
 oemGjtz7Gh4M9NeBE46mWuutnWcefecejUYSwb3awnNqkNOH5rPEtVYSaE21VBfs8O
 nRHOS0RJ7fBhA==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 1/3] rust: alloc: add Box::zeroed()
Date: Tue,  5 May 2026 17:23:07 +0200
Message-ID: <20260505152400.3905096-2-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505152400.3905096-1-dakr@kernel.org>
References: <20260505152400.3905096-1-dakr@kernel.org>
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

Add Box::zeroed() for T: Zeroable types.

This allocates with __GFP_ZERO directly, letting the underlying
allocator deal with zeroing out the memory compared to
Box::new(T::zeroed(), flags).

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/alloc/kbox.rs | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index bd6da02c7ab8..c824ed6e1523 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -19,6 +19,7 @@
 use crate::fmt;
 use crate::init::InPlaceInit;
 use crate::page::AsPageIter;
+use crate::prelude::*;
 use crate::types::ForeignOwnable;
 use pin_init::{InPlaceWrite, Init, PinInit, ZeroableOption};
 
@@ -256,6 +257,27 @@ pub fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>, A>, AllocError> {
         Ok(Box(ptr.cast(), PhantomData))
     }
 
+    /// Creates a new zero-initialized `Box<T, A>`.
+    ///
+    /// New memory is allocated with `A` and the [`__GFP_ZERO`] flag. The allocation may fail, in
+    /// which case an error is returned. For ZSTs no memory is allocated.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let b = KBox::<[u8; 128]>::zeroed(GFP_KERNEL)?;
+    /// assert_eq!(*b, [0; 128]);
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn zeroed(flags: Flags) -> Result<Self, AllocError>
+    where
+        T: Zeroable,
+    {
+        // SAFETY: `__GFP_ZERO` guarantees the memory is zeroed; `T: Zeroable` guarantees that
+        // all-zeroes is a valid bit pattern for `T`.
+        Ok(unsafe { Self::new_uninit(flags | __GFP_ZERO)?.assume_init() })
+    }
+
     /// Constructs a new `Pin<Box<T, A>>`. If `T` does not implement [`Unpin`], then `x` will be
     /// pinned in memory and can't be moved.
     #[inline]
-- 
2.54.0

