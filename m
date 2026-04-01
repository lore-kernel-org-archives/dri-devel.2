Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3ABD35177
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9097C10E987;
	Wed,  1 Apr 2026 11:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Tnllc7x6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3050610E987;
 Wed,  1 Apr 2026 11:49:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0B1A540914;
 Wed,  1 Apr 2026 11:49:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46ECC4CEF7;
 Wed,  1 Apr 2026 11:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775044175;
 bh=xz1grsgb4QE1o4cHB9GesAE8qhJ6lQQFIqn/KID5vfw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Tnllc7x6zEKN9F7U+bg8ySDzkF9jSdpxTfoTnbvmk/kuzJ/sYG/NjwfDZ6inHO1Oc
 /EhJNuqVo+qFFcjj/fjTG4t7FvH7/73DVMk3rItWld3VOFc3hPShkq57juJbvm4yFK
 OuOjBa/ib79Lo40yyq9wodqBoUB9J2VLVSXnXzelLqcvbIhRvjrsNQYPkeVyJ/hhWe
 MR9qiIFeLCqngv8TClBhUW1JlJbS5mLTIFM9Ywbs9gwbFcQAsxgy9/WZUAoO8kcySG
 DH2hQ+Pe5WAD4+4iByp79KxYyFthjqcvoT6ilEd5BiUE6UVqgy7mAfJFJVA5UZvOT/
 PKMFODChfa0KQ==
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
Subject: [PATCH 18/33] rust: kbuild: remove "dummy parameter" workaround for
 `bindgen` < 0.71.1
Date: Wed,  1 Apr 2026 13:45:25 +0200
Message-ID: <20260401114540.30108-19-ojeda@kernel.org>
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

Until the version bump of `bindgen`, we needed to pass a dummy parameter
to avoid failing the `--version` call.

Thus remove it.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 init/Kconfig                 | 7 +------
 scripts/rust_is_available.sh | 8 +-------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index f9fac458e4d4..d9b795f70a38 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2211,12 +2211,7 @@ config RUSTC_VERSION_TEXT
 config BINDGEN_VERSION_TEXT
 	string
 	depends on RUST
-	# The dummy parameter `workaround-for-0.69.0` is required to support 0.69.0
-	# (https://github.com/rust-lang/rust-bindgen/pull/2678) and 0.71.0
-	# (https://github.com/rust-lang/rust-bindgen/pull/3040). It can be removed
-	# when the minimum version is upgraded past the latter (0.69.1 and 0.71.1
-	# both fixed the issue).
-	default "$(shell,$(BINDGEN) --version workaround-for-0.69.0 2>/dev/null)"
+	default "$(shell,$(BINDGEN) --version 2>/dev/null)"
 
 #
 # Place an empty function call at each tracepoint site. Can be
diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index cefc456c2503..551f1ebd0dcb 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -121,14 +121,8 @@ fi
 # Check that the Rust bindings generator is suitable.
 #
 # Non-stable and distributions' versions may have a version suffix, e.g. `-dev`.
-#
-# The dummy parameter `workaround-for-0.69.0` is required to support 0.69.0
-# (https://github.com/rust-lang/rust-bindgen/pull/2678) and 0.71.0
-# (https://github.com/rust-lang/rust-bindgen/pull/3040). It can be removed when
-# the minimum version is upgraded past the latter (0.69.1 and 0.71.1 both fixed
-# the issue).
 rust_bindings_generator_output=$( \
-	LC_ALL=C "$BINDGEN" --version workaround-for-0.69.0 2>/dev/null
+	LC_ALL=C "$BINDGEN" --version 2>/dev/null
 ) || rust_bindings_generator_code=$?
 if [ -n "$rust_bindings_generator_code" ]; then
 	echo >&2 "***"
-- 
2.53.0

