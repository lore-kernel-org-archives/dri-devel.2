Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E9FD35177
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F9310F031;
	Wed,  1 Apr 2026 11:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bw0XQFM9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172F710F031;
 Wed,  1 Apr 2026 11:47:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id F1C8B40912;
 Wed,  1 Apr 2026 11:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98766C116C6;
 Wed,  1 Apr 2026 11:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775044069;
 bh=xsU9IffmhOUWeURxd1cBn+xx+oWcdYdxyuUvVgPmku0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bw0XQFM9BtXzltVVfX1cRyS5Ny7916Ny6Nrc3TLq9KJZYh0JtBh+ukTFEyx8Z85t8
 /vt7Jbc/zq1y9bQ1shJhG3VR8TxOtBZF4NjJHMa7mU/xZAlefh37LD+NPTu+Ydfi49
 JZ53a+OUpRjXBEozckaDoUhJgDDxIg+j6uv+ZggEvUq3It6rUqjdZ6bh+lQmBq+fnd
 qgyPYo7kcXdNsMmw1yjq21a8J89cwAmGQvzQVu5nFumVK/lfkLoYnqg7V/B3EDnv2S
 Uy6UH8O6mHui9UIcrilZWtiKbbK/WhNF71Bx912WmOVg7CuvV4vNq3M2vlDeu6Xlr9
 RAOV3bDFHx0ZA==
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
Subject: [PATCH 09/33] rust: kbuild: make `--remap-path-prefix` workaround
 conditional
Date: Wed,  1 Apr 2026 13:45:16 +0200
Message-ID: <20260401114540.30108-10-ojeda@kernel.org>
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

The Internal Compiler Error that the comment mentions [1] was fixed in
Rust 1.87.0 [2]. And, for other workarounds, we plan on limiting where
we apply them [3].

Thus limit the ICE one too.

This will help to make sure the workaround is not needed anymore on
newer versions.

Link: https://github.com/rust-lang/rust/issues/138520 [1]
Link: https://github.com/rust-lang/rust/pull/138556 [2]
Link: https://lore.kernel.org/rust-for-linux/20260205131815.2943152-2-mlksvender@gmail.com/ [3]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index 708530ee3613..163d2258e93f 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -145,10 +145,12 @@ doctests_modifiers_workaround := $(rustdoc_modifiers_workaround)$(if $(call rust
 # `rustdoc` ICEs on out-of-tree builds in Rust < 1.87.0
 # (https://github.com/rust-lang/rust/issues/138520). Thus workaround the
 # issue skipping the flag.
+rustdoc_remap_workaround := $(if $(call rustc-min-version,108700),,--remap-path-prefix=%)
+
 quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
       cmd_rustdoc = \
 	OBJTREE=$(abspath $(objtree)) \
-	$(RUSTDOC) $(filter-out $(skip_flags) --remap-path-prefix=%,$(if $(rustdoc_host),$(rust_common_flags),$(rust_flags))) \
+	$(RUSTDOC) $(filter-out $(skip_flags) $(rustdoc_remap_workaround),$(if $(rustdoc_host),$(rust_common_flags),$(rust_flags))) \
 		$(rustc_target_flags) -L$(objtree)/$(obj) \
 		-Zunstable-options --generate-link-to-definition \
 		--output $(rustdoc_output) \
-- 
2.53.0

