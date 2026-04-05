Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CBCE9D827
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 23:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E48C10E18D;
	Sun,  5 Apr 2026 23:57:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZiwyuKsC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AAA010E18D;
 Sun,  5 Apr 2026 23:57:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A2112600CB;
 Sun,  5 Apr 2026 23:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B153CC19425;
 Sun,  5 Apr 2026 23:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775433420;
 bh=vrwAV7Bl6fj3wm5bdA1SVbLh83q3Kq+DPrhsVUmDW5g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZiwyuKsCF/ioWYt/NU05o38dAFYnn7AcopnYIUawB69WLhy7XUSsc1QkcPxQTz5NB
 Nv59AN39BWOY6GvSMoLn/qG3TYbCTyf449BK0i5ys4oUhcYAJ6THwXleoHmn+GNVwT
 l+R+0Qvf1Tdj8vgB0GvIcL4wKcAcN94vrKqH91GKOnVJXkBylCRfUCh7v4kw938t0f
 e+TnxHa1aSvsYnW3UVvLAZGP42Fn+4nOOTtLxAW15o0YhdPIrNPoWXBLUeIyLmced1
 /IN2BPutIO9yCe3kCWcarPLQl4/DtUxCuq+Rhyk0ZoQF9S3QLNwDBd7p0XhsPMzRTK
 BTzlmBwyK7CPQ==
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
Subject: [PATCH v2 19/33] rust: rust_is_available: remove warning for
 `bindgen` < 0.69.5 && libclang >= 19.1
Date: Mon,  6 Apr 2026 01:52:55 +0200
Message-ID: <20260405235309.418950-20-ojeda@kernel.org>
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

It is not possible anymore to fall into the issue that this warning was
alerting about given the `bindgen` version bump.

Thus simplify by removing the machinery behind it, including tests.

Reviewed-by: Tamir Duberstein <tamird@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/rust_is_available.sh                  | 15 --------
 ...ust_is_available_bindgen_libclang_concat.h |  3 --
 scripts/rust_is_available_test.py             | 34 +------------------
 3 files changed, 1 insertion(+), 51 deletions(-)
 delete mode 100644 scripts/rust_is_available_bindgen_libclang_concat.h

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index 77896e31dab5..cefc456c2503 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -214,21 +214,6 @@ if [ "$bindgen_libclang_cversion" -lt "$bindgen_libclang_min_cversion" ]; then
 	exit 1
 fi
 
-if [ "$bindgen_libclang_cversion" -ge 1900100 ] &&
-	[ "$rust_bindings_generator_cversion" -lt 6905 ]; then
-	# Distributions may have patched the issue (e.g. Debian did).
-	if ! "$BINDGEN" $(dirname $0)/rust_is_available_bindgen_libclang_concat.h | grep -q foofoo; then
-		echo >&2 "***"
-		echo >&2 "*** Rust bindings generator '$BINDGEN' < 0.69.5 together with libclang >= 19.1"
-		echo >&2 "*** may not work due to a bug (https://github.com/rust-lang/rust-bindgen/pull/2824),"
-		echo >&2 "*** unless patched (like Debian's)."
-		echo >&2 "***   Your bindgen version:  $rust_bindings_generator_version"
-		echo >&2 "***   Your libclang version: $bindgen_libclang_version"
-		echo >&2 "***"
-		warning=1
-	fi
-fi
-
 # If the C compiler is Clang, then we can also check whether its version
 # matches the `libclang` version used by the Rust bindings generator.
 #
diff --git a/scripts/rust_is_available_bindgen_libclang_concat.h b/scripts/rust_is_available_bindgen_libclang_concat.h
deleted file mode 100644
index efc6e98d0f1d..000000000000
--- a/scripts/rust_is_available_bindgen_libclang_concat.h
+++ /dev/null
@@ -1,3 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#define F(x) int x##x
-F(foo);
diff --git a/scripts/rust_is_available_test.py b/scripts/rust_is_available_test.py
index b66fa5933844..d6d54b7ea42a 100755
--- a/scripts/rust_is_available_test.py
+++ b/scripts/rust_is_available_test.py
@@ -54,23 +54,16 @@ else:
 """)
 
     @classmethod
-    def generate_bindgen(cls, version_stdout, libclang_stderr, libclang_concat_patched=False):
+    def generate_bindgen(cls, version_stdout, libclang_stderr):
         if libclang_stderr is None:
             libclang_case = f"raise SystemExit({cls.bindgen_default_bindgen_libclang_failure_exit_code})"
         else:
             libclang_case = f"print({repr(libclang_stderr)}, file=sys.stderr)"
 
-        if libclang_concat_patched:
-            libclang_concat_case = "print('pub static mut foofoo: ::std::os::raw::c_int;')"
-        else:
-            libclang_concat_case = "pass"
-
         return cls.generate_executable(f"""#!/usr/bin/env python3
 import sys
 if "rust_is_available_bindgen_libclang.h" in " ".join(sys.argv):
     {libclang_case}
-elif "rust_is_available_bindgen_libclang_concat.h" in " ".join(sys.argv):
-    {libclang_concat_case}
 else:
     print({repr(version_stdout)})
 """)
@@ -255,31 +248,6 @@ else:
         result = self.run_script(self.Expected.FAILURE, { "BINDGEN": bindgen })
         self.assertIn(f"libclang (used by the Rust bindings generator '{bindgen}') is too old.", result.stderr)
 
-    def test_bindgen_bad_libclang_concat(self):
-        for (bindgen_version, libclang_version, expected_not_patched) in (
-            ("0.69.4", "18.0.0", self.Expected.SUCCESS),
-            ("0.69.4", "19.1.0", self.Expected.SUCCESS_WITH_WARNINGS),
-            ("0.69.4", "19.2.0", self.Expected.SUCCESS_WITH_WARNINGS),
-
-            ("0.69.5", "18.0.0", self.Expected.SUCCESS),
-            ("0.69.5", "19.1.0", self.Expected.SUCCESS),
-            ("0.69.5", "19.2.0", self.Expected.SUCCESS),
-
-            ("0.70.0", "18.0.0", self.Expected.SUCCESS),
-            ("0.70.0", "19.1.0", self.Expected.SUCCESS),
-            ("0.70.0", "19.2.0", self.Expected.SUCCESS),
-        ):
-            with self.subTest(bindgen_version=bindgen_version, libclang_version=libclang_version):
-                cc = self.generate_clang(f"clang version {libclang_version}")
-                libclang_stderr = f"scripts/rust_is_available_bindgen_libclang.h:2:9: warning: clang version {libclang_version} [-W#pragma-messages], err: false"
-                bindgen = self.generate_bindgen(f"bindgen {bindgen_version}", libclang_stderr)
-                result = self.run_script(expected_not_patched, { "BINDGEN": bindgen, "CC": cc })
-                if expected_not_patched == self.Expected.SUCCESS_WITH_WARNINGS:
-                    self.assertIn(f"Rust bindings generator '{bindgen}' < 0.69.5 together with libclang >= 19.1", result.stderr)
-
-                bindgen = self.generate_bindgen(f"bindgen {bindgen_version}", libclang_stderr, libclang_concat_patched=True)
-                result = self.run_script(self.Expected.SUCCESS, { "BINDGEN": bindgen, "CC": cc })
-
     def test_clang_matches_bindgen_libclang_different_bindgen(self):
         bindgen = self.generate_bindgen_libclang("scripts/rust_is_available_bindgen_libclang.h:2:9: warning: clang version 999.0.0 [-W#pragma-messages], err: false")
         result = self.run_script(self.Expected.SUCCESS_WITH_WARNINGS, { "BINDGEN": bindgen })
-- 
2.53.0

