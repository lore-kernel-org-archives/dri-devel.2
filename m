Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133BDE9D826
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 23:56:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A6210E179;
	Sun,  5 Apr 2026 23:56:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QWwho++C";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92DCD10E179;
 Sun,  5 Apr 2026 23:56:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 16814600AC;
 Sun,  5 Apr 2026 23:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27803C2BC9E;
 Sun,  5 Apr 2026 23:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775433364;
 bh=H/Ay6Jkav43FJVWalNMqy1drrqBC5z0jZaYEliYSxsg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QWwho++CAQHqbiJSHYjIFW+3zbIRsYkzI2NhaXD915XErZ5bX8D0JSqumwCvnboQC
 JA2kZyy0PbupBQQ6NzUS0I5RoleMORu4/mJ8QJHPf8WuIxsJK2BntYwSEFYuKrHgs5
 VPKZomQQHZR70NsihUxiVAScWTSo2yfHf8uJ/qsMQd0mTZH9HvJHft2Dn5JgiAXnIO
 3PdrXjw1Cnt6FYPbyK/FBO1nONRhPiI30ad4Kc7dhk4L7g63i4MoWAU0uWhs56aoAB
 o0/TRdl5mjZSVEIann5jDzC12StU6bGXcn2XxNGHneIkfSLv34y3M6cbP04LdQktPx
 m2gUzuUeHkCMQ==
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
Subject: [PATCH v2 14/33] rust: alloc: simplify with `NonNull::add()` now that
 it is stable
Date: Mon,  6 Apr 2026 01:52:50 +0200
Message-ID: <20260405235309.418950-15-ojeda@kernel.org>
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

Currently, we need to go through raw pointers and then re-create the
`NonNull` from the result of offsetting the raw pointer.

`feature(non_null_convenience)` [1] has been stabilized in Rust
1.80.0 [2], which is older than our new minimum Rust version
(Rust 1.85.0).

Thus, now that we bump the Rust minimum version, simplify using
`NonNull::add()` and clean the TODO note.

Link: https://github.com/rust-lang/rust/issues/117691 [1]
Link: https://github.com/rust-lang/rust/pull/124498 [2]
Reviewed-by: Tamir Duberstein <tamird@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/kernel/alloc/allocator/iter.rs | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/rust/kernel/alloc/allocator/iter.rs b/rust/kernel/alloc/allocator/iter.rs
index 5759f86029b7..e0a70b7a744a 100644
--- a/rust/kernel/alloc/allocator/iter.rs
+++ b/rust/kernel/alloc/allocator/iter.rs
@@ -42,15 +42,9 @@ fn next(&mut self) -> Option<Self::Item> {
             return None;
         }
 
-        // TODO: Use `NonNull::add()` instead, once the minimum supported compiler version is
-        // bumped to 1.80 or later.
-        //
         // SAFETY: `offset` is in the interval `[0, (self.page_count() - 1) * page::PAGE_SIZE]`,
         // hence the resulting pointer is guaranteed to be within the same allocation.
-        let ptr = unsafe { self.buf.as_ptr().add(offset) };
-
-        // SAFETY: `ptr` is guaranteed to be non-null given that it is derived from `self.buf`.
-        let ptr = unsafe { NonNull::new_unchecked(ptr) };
+        let ptr = unsafe { self.buf.add(offset) };
 
         // SAFETY:
         // - `ptr` is a valid pointer to a `Vmalloc` allocation.
-- 
2.53.0

