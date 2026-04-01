Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F45D35177
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508D610EFF9;
	Wed,  1 Apr 2026 11:47:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GlBQ6KPS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB1910EFF9;
 Wed,  1 Apr 2026 11:47:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 947E360142;
 Wed,  1 Apr 2026 11:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118C5C2BCB2;
 Wed,  1 Apr 2026 11:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775044046;
 bh=iwZQRTkxE8SQciPkkFIQK+sANJEDd5bGQ1OGAUaLfG4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GlBQ6KPSTWHT4VISiYn97ivYhVXKefSUh2Q6bRU8+77PgyLwWn4NjnF93DIByady8
 9SycbuA1ixu1mts+5r+nkNfbaww5zykSVdLdjv0lucrgKWqE4LAJ/QBIU+Cn4gwg0z
 bCuzNQUeDVBg3CE437u5n2f4ONxdL5gjciyeyJ3Mv40G41XzXthovIXxTWAenLWWh0
 dfBE9IaiPg3o/GFFlOAh2uMAxZCD1G5wgyJMXmyO54m6lEhFY+P8aMpO3le2CgbKCU
 lSBH/R9RSHx/v6cF2EdoL2fKcEK9jg29eFoS1fliq8sw58kmNUYk+Y6sTjQIl0q2Mr
 LdUgb8hbudc9A==
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
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
Subject: [PATCH 07/33] rust: kbuild: remove `feature(...)`s that are now stable
Date: Wed,  1 Apr 2026 13:45:14 +0200
Message-ID: <20260401114540.30108-8-ojeda@kernel.org>
In-Reply-To: <20260401114540.30108-1-ojeda@kernel.org>
References: <20260401114540.30108-1-ojeda@kernel.org>
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

Now that the Rust minimum version is 1.85.0, there is no need to enable
certain features that are stable.

Thus clean them up.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/Makefile          |  2 --
 rust/kernel/lib.rs     | 21 ---------------------
 scripts/Makefile.build |  6 +-----
 3 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 212759b5eb7d..193cf06eea64 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -86,10 +86,8 @@ proc_macro2-cfgs := \
     wrap_proc_macro \
     $(if $(call rustc-min-version,108800),proc_macro_span_file proc_macro_span_location)
 
-# Stable since Rust 1.79.0: `feature(proc_macro_byte_character,proc_macro_c_str_literals)`.
 proc_macro2-flags := \
     --cap-lints=allow \
-    -Zcrate-attr='feature(proc_macro_byte_character,proc_macro_c_str_literals)' \
     $(call cfgs-to-flags,$(proc_macro2-cfgs))
 
 quote-cfgs := \
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 66a09d77a2c4..b48221a5b4ec 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -16,27 +16,6 @@
 // Please see https://github.com/Rust-for-Linux/linux/issues/2 for details on
 // the unstable features in use.
 //
-// Stable since Rust 1.79.0.
-#![feature(generic_nonzero)]
-#![feature(inline_const)]
-#![feature(pointer_is_aligned)]
-//
-// Stable since Rust 1.80.0.
-#![feature(slice_flatten)]
-//
-// Stable since Rust 1.81.0.
-#![feature(lint_reasons)]
-//
-// Stable since Rust 1.82.0.
-#![feature(raw_ref_op)]
-//
-// Stable since Rust 1.83.0.
-#![feature(const_maybe_uninit_as_mut_ptr)]
-#![feature(const_mut_refs)]
-#![feature(const_option)]
-#![feature(const_ptr_write)]
-#![feature(const_refs_to_cell)]
-//
 // Expected to become stable.
 #![feature(arbitrary_self_types)]
 #![feature(derive_coerce_pointee)]
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a6d1a2b210aa..d71193a45e1c 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -310,17 +310,13 @@ $(obj)/%.lst: $(obj)/%.c FORCE
 
 # The features in this list are the ones allowed for non-`rust/` code.
 #
-#   - Stable since Rust 1.79.0: `feature(inline_const)`.
-#   - Stable since Rust 1.81.0: `feature(lint_reasons)`.
-#   - Stable since Rust 1.82.0: `feature(asm_const)`,
-#     `feature(offset_of_nested)`, `feature(raw_ref_op)`.
 #   - Stable since Rust 1.87.0: `feature(asm_goto)`.
 #   - Expected to become stable: `feature(arbitrary_self_types)`.
 #   - To be determined: `feature(used_with_arg)`.
 #
 # Please see https://github.com/Rust-for-Linux/linux/issues/2 for details on
 # the unstable features in use.
-rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,inline_const,lint_reasons,offset_of_nested,raw_ref_op,used_with_arg
+rust_allowed_features := arbitrary_self_types,asm_goto,used_with_arg
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
-- 
2.53.0

