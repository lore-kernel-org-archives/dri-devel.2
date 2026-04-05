Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBCFE9D827
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 23:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B83510E0F0;
	Sun,  5 Apr 2026 23:54:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cN/Pm+h1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A3A810E0F0;
 Sun,  5 Apr 2026 23:54:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0EBE06011F;
 Sun,  5 Apr 2026 23:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022B9C19425;
 Sun,  5 Apr 2026 23:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775433275;
 bh=Blo4OMct9fYkxFdmel/7U9C+OpnsYmoKnhqmZOKw+4A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cN/Pm+h1MNJIdF8/BGkOea6H77vXoucr8wI0WEa1JjgbUvhFtEz8eoHKetlw+QXz/
 yKJO+pzg+gsG7x6RU/QXG3/NDSowmR9zbNCKxO2a/aJI+6JRSWJ7FlC/RdNHyNrNNL
 vkYkWnvMwABBEgYDSlwiUH1xGSN0AkwKOU2CezV3RZe4tdKCq5qAY+dKqINxZIBlio
 QPbluXudooBzD+JgtojrRNp/XPzmN19AXP+Mm5kqOBRju7q9dhhwB6RvmCMVM26hrH
 IFc9bvX9/tmEZHSnXE1MG/oWow9BHK1Pft0guBMO+KcF0Jd6vE0TdJ/PRljzy5/bOn
 xE4ThQHQFOw7g==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Courbot <acourbot@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>,
 Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-block@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org (moderated for non-subscribers),
 Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Rae Moar <raemoar63@gmail.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
 Tamir Duberstein <tamird@kernel.org>
Subject: [PATCH v2 06/33] rust: bump Clippy's MSRV and clean
 `incompatible_msrv` allows
Date: Mon,  6 Apr 2026 01:52:42 +0200
Message-ID: <20260405235309.418950-7-ojeda@kernel.org>
In-Reply-To: <20260405235309.418950-1-ojeda@kernel.org>
References: <20260405235309.418950-1-ojeda@kernel.org>
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

Following the Rust compiler bump, we can now update Clippy's MSRV we
set in the configuration, which will improve the diagnostics it generates.

Thus do so and clean a few of the `allow`s that are not needed anymore.

Reviewed-by: Tamir Duberstein <tamird@kernel.org>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 .clippy.toml                      | 2 +-
 drivers/gpu/nova-core/gsp/cmdq.rs | 6 +-----
 rust/kernel/ptr.rs                | 1 -
 rust/kernel/transmute.rs          | 2 --
 4 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/.clippy.toml b/.clippy.toml
index a51de9a46380..b0a78cc8be20 100644
--- a/.clippy.toml
+++ b/.clippy.toml
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-msrv = "1.78.0"
+msrv = "1.85.0"
 
 check-private-items = true
 
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 46819a82a51a..d9f69366642a 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -281,7 +281,6 @@ fn allocate_command(&mut self, size: usize) -> Result<GspCommand<'_>> {
         let (slice_1, slice_2) = {
             let (slice_1, slice_2) = self.driver_write_area();
 
-            #[allow(clippy::incompatible_msrv)]
             (slice_1.as_flattened_mut(), slice_2.as_flattened_mut())
         };
 
@@ -572,10 +571,7 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
             Delta::from_millis(1),
             timeout,
         )
-        .map(|(slice_1, slice_2)| {
-            #[allow(clippy::incompatible_msrv)]
-            (slice_1.as_flattened(), slice_2.as_flattened())
-        })?;
+        .map(|(slice_1, slice_2)| (slice_1.as_flattened(), slice_2.as_flattened()))?;
 
         // Extract the `GspMsgElement`.
         let (header, slice_1) = GspMsgElement::from_bytes_prefix(slice_1).ok_or(EIO)?;
diff --git a/rust/kernel/ptr.rs b/rust/kernel/ptr.rs
index c7788656a162..91811f5e27de 100644
--- a/rust/kernel/ptr.rs
+++ b/rust/kernel/ptr.rs
@@ -81,7 +81,6 @@ pub const fn new_checked(align: usize) -> Option<Self> {
     /// This is equivalent to [`align_of`], but with the return value provided as an [`Alignment`].
     #[inline(always)]
     pub const fn of<T>() -> Self {
-        #![allow(clippy::incompatible_msrv)]
         // This cannot panic since alignments are always powers of two.
         //
         // We unfortunately cannot use `new` as it would require the `generic_const_exprs` feature.
diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
index 5711580c9f9b..b9e6eadc08f5 100644
--- a/rust/kernel/transmute.rs
+++ b/rust/kernel/transmute.rs
@@ -49,7 +49,6 @@ fn from_bytes(bytes: &[u8]) -> Option<&Self>
         let slice_ptr = bytes.as_ptr().cast::<Self>();
         let size = size_of::<Self>();
 
-        #[allow(clippy::incompatible_msrv)]
         if bytes.len() == size && slice_ptr.is_aligned() {
             // SAFETY: Size and alignment were just checked.
             unsafe { Some(&*slice_ptr) }
@@ -92,7 +91,6 @@ fn from_bytes_mut(bytes: &mut [u8]) -> Option<&mut Self>
         let slice_ptr = bytes.as_mut_ptr().cast::<Self>();
         let size = size_of::<Self>();
 
-        #[allow(clippy::incompatible_msrv)]
         if bytes.len() == size && slice_ptr.is_aligned() {
             // SAFETY: Size and alignment were just checked.
             unsafe { Some(&mut *slice_ptr) }
-- 
2.53.0

