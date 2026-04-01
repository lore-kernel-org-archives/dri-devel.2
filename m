Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA05D3517A
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 11:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB7C710F068;
	Wed,  1 Apr 2026 11:49:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="au78Fn5P";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E30810F068;
 Wed,  1 Apr 2026 11:49:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C549260154;
 Wed,  1 Apr 2026 11:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C824C116C6;
 Wed,  1 Apr 2026 11:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775044140;
 bh=ItfdI64Ks8gXoHtrpj58RCfjp1hysM7VxfqZvaewK7E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=au78Fn5P62QtKs+AJuvGHcFWbjilw5jy6hHRniP49H+mzNx6g15OrAt4rwU2g+0Bf
 tgBzQ7o2EUJfMYGsWaaiWncgiCJA8DMzQeG5Hxb97hWVuDNmyp7CXYxa9h9XPB0+72
 HyKrGNgOra2twsMAAIbGarVaeaCvYqs9UnC3BNpHx/ooTRBNddV7XrpahshUBA5t4A
 bLhkkMuXgTC/ps+59WFJ9qjuX446UCiCI1TqDu41k8PyOf4qsSJ8c0PqM5AyOiXO5C
 sy02Wxq7FBpUPdnBPZ+g6kYQbEU5X+6ye5V4xHtrAdpwNgn4H15Rym/SXtIaEDW5wK
 btGTVejLETUPg==
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
Subject: [PATCH 15/33] rust: rust_is_available: remove warning for 0.66.[01]
 buggy versions
Date: Wed,  1 Apr 2026 13:45:22 +0200
Message-ID: <20260401114540.30108-16-ojeda@kernel.org>
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

It is not possible anymore to fall into the issue that this warning was
alerting about given the `bindgen` version bump.

Thus simplify by removing the machinery behind it, including tests.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/rust_is_available.sh             | 13 ------------
 scripts/rust_is_available_bindgen_0_66.h |  2 --
 scripts/rust_is_available_test.py        | 26 +++---------------------
 3 files changed, 3 insertions(+), 38 deletions(-)
 delete mode 100644 scripts/rust_is_available_bindgen_0_66.h

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index d2323de0692c..77896e31dab5 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -163,19 +163,6 @@ if [ "$rust_bindings_generator_cversion" -lt "$rust_bindings_generator_min_cvers
 	echo >&2 "***"
 	exit 1
 fi
-if [ "$rust_bindings_generator_cversion" -eq 6600 ] ||
-	[ "$rust_bindings_generator_cversion" -eq 6601 ]; then
-	# Distributions may have patched the issue (e.g. Debian did).
-	if ! "$BINDGEN" $(dirname $0)/rust_is_available_bindgen_0_66.h >/dev/null; then
-		echo >&2 "***"
-		echo >&2 "*** Rust bindings generator '$BINDGEN' versions 0.66.0 and 0.66.1 may not"
-		echo >&2 "*** work due to a bug (https://github.com/rust-lang/rust-bindgen/pull/2567),"
-		echo >&2 "*** unless patched (like Debian's)."
-		echo >&2 "***   Your version:     $rust_bindings_generator_version"
-		echo >&2 "***"
-		warning=1
-	fi
-fi
 
 # Check that the `libclang` used by the Rust bindings generator is suitable.
 #
diff --git a/scripts/rust_is_available_bindgen_0_66.h b/scripts/rust_is_available_bindgen_0_66.h
deleted file mode 100644
index c0431293421c..000000000000
--- a/scripts/rust_is_available_bindgen_0_66.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#define A "\0"
diff --git a/scripts/rust_is_available_test.py b/scripts/rust_is_available_test.py
index 4fcc319dea84..b66fa5933844 100755
--- a/scripts/rust_is_available_test.py
+++ b/scripts/rust_is_available_test.py
@@ -54,17 +54,12 @@ else:
 """)
 
     @classmethod
-    def generate_bindgen(cls, version_stdout, libclang_stderr, version_0_66_patched=False, libclang_concat_patched=False):
+    def generate_bindgen(cls, version_stdout, libclang_stderr, libclang_concat_patched=False):
         if libclang_stderr is None:
             libclang_case = f"raise SystemExit({cls.bindgen_default_bindgen_libclang_failure_exit_code})"
         else:
             libclang_case = f"print({repr(libclang_stderr)}, file=sys.stderr)"
 
-        if version_0_66_patched:
-            version_0_66_case = "pass"
-        else:
-            version_0_66_case = "raise SystemExit(1)"
-
         if libclang_concat_patched:
             libclang_concat_case = "print('pub static mut foofoo: ::std::os::raw::c_int;')"
         else:
@@ -74,8 +69,6 @@ else:
 import sys
 if "rust_is_available_bindgen_libclang.h" in " ".join(sys.argv):
     {libclang_case}
-elif "rust_is_available_bindgen_0_66.h" in " ".join(sys.argv):
-    {version_0_66_case}
 elif "rust_is_available_bindgen_libclang_concat.h" in " ".join(sys.argv):
     {libclang_concat_case}
 else:
@@ -83,8 +76,8 @@ else:
 """)
 
     @classmethod
-    def generate_bindgen_version(cls, stdout, version_0_66_patched=False):
-        return cls.generate_bindgen(stdout, cls.bindgen_default_bindgen_libclang_stderr, version_0_66_patched)
+    def generate_bindgen_version(cls, stdout):
+        return cls.generate_bindgen(stdout, cls.bindgen_default_bindgen_libclang_stderr)
 
     @classmethod
     def generate_bindgen_libclang_failure(cls):
@@ -245,19 +238,6 @@ else:
         result = self.run_script(self.Expected.FAILURE, { "BINDGEN": bindgen })
         self.assertIn(f"Rust bindings generator '{bindgen}' is too old.", result.stderr)
 
-    def test_bindgen_bad_version_0_66_0_and_0_66_1(self):
-        for version in ("0.66.0", "0.66.1"):
-            with self.subTest(version=version):
-                bindgen = self.generate_bindgen_version(f"bindgen {version}")
-                result = self.run_script(self.Expected.SUCCESS_WITH_WARNINGS, { "BINDGEN": bindgen })
-                self.assertIn(f"Rust bindings generator '{bindgen}' versions 0.66.0 and 0.66.1 may not", result.stderr)
-
-    def test_bindgen_bad_version_0_66_0_and_0_66_1_patched(self):
-        for version in ("0.66.0", "0.66.1"):
-            with self.subTest(version=version):
-                bindgen = self.generate_bindgen_version(f"bindgen {version}", True)
-                result = self.run_script(self.Expected.SUCCESS, { "BINDGEN": bindgen })
-
     def test_bindgen_libclang_failure(self):
         bindgen = self.generate_bindgen_libclang_failure()
         result = self.run_script(self.Expected.FAILURE, { "BINDGEN": bindgen })
-- 
2.53.0

